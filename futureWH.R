##Generate geospatial datafile of planned warehouses
##Created by Mike McCarthy and possibly EA 078
##First created as part of MJPA mapping process in October 2022
##Last modified February 2023

rm(list =ls())
'%ni%' <- Negate('%in%') ## not in operator

library(sf)
library(tidyverse)
library(googlesheets4)

# existing warehouses
WH.url <- 'https://raw.githubusercontent.com/RadicalResearchLLC/WarehouseMap/main/WarehouseCITY/geoJSON/finalParcels.geojson'
warehouses <- st_read(WH.url) %>% 
  st_transform("+proj=longlat +ellps=WGS84 +datum=WGS84") %>% 
  filter(county %in% c('Riverside', 'San Bernardino'))

#manually entered parcels from 215/60 corridor
source('PolygonTest.R')
source('EA078_warehouse_polygons.R')

#worksheet with details of projects
March215_60_sheet <- read_sheet('https://docs.google.com/spreadsheets/d/1u7JJYoxl5lE-oXJHEt5kqICmLug6SDh5sYSrSNud7Cs/edit#gid=0',
                       sheet = 'March215_60') %>% 
  janitor::clean_names()

#a couple of older approved warehouses in Moreno Valley from public records request
missingMoVal <- sf::st_read('C:/Dev/MJPA2/jurisdictions/moValmissing.geojson') %>% 
  select(Name, geometry) %>% 
  rename(geom = geometry, name = Name)

planned215_60_full <- planned215_60 %>% 
  bind_rows(missingMoVal) %>% 
  full_join(March215_60_sheet, by = c('name' = 'building_id')) %>% 
  rename(buildingID = 'name', project_size_sq_ft = size_sq_ft) %>% 
  select(-x14, -jurisdiction_enviro_docs)

shapeArea <- st_area(planned215_60_full)

planned_tidy <- planned215_60_full %>% 
  mutate(type = 'Planned',
         area =  round(as.numeric(10.764*shapeArea), -3)) %>% 
  mutate(floorSpace.sq.ft = 0.5*area) %>% 
  select(buildingID, type, floorSpace.sq.ft, area, jurisdiction, geom) %>% 
  rename(name = buildingID) %>% 
  mutate(year_built = '2025')

##San Bernardino County planned warehouse data to date

## Fontana and near Fontana data
## MCN_projects acquired from City of Fontana Open Data page January 2023
## https://data-fontanaca.opendata.arcgis.com/datasets/mcn-projects-public/explore?location=34.108794%2C-117.462315%2C12.92

notWHParcels <- c('zoning code amendment schools in fbc and truck rep',
                  'east coast truck and auto sales',
                  'up zoning for the i-15 logistics warehouse')

Fontana3yrPlanned <- sf::st_read(dsn = 'C:/Dev/Fontana_analysis/MCN_Projects_Public.geojson') %>% 
  rename(name = Fontana_COF_DSO_PRJS_PROJ_NAME,
         number = Fontana_COF_DSO_PRJS_PROJECT_NO,
         status = Fontana_COF_DSO_PRJS_ProjectSta,
         apn = Fontana_COF_DSO_PRJS_PARCELID) %>% 
  mutate(name = stringr::str_to_lower(name)) %>% 
  mutate(wh = str_detect(name, 'warehouse'),
         ind = str_detect(name, 'industrial'),
         log = str_detect(name, 'logistics'),
         com = str_detect(name, 'commerce'),
         truck = str_detect(name, 'truck'),
         bus = str_detect(name, 'business center')) %>% 
  filter(name %ni% notWHParcels)

Fontana_industrial <- Fontana3yrPlanned %>% 
  filter(wh == TRUE | ind == TRUE | log == TRUE | com == TRUE | truck == TRUE | bus == TRUE) %>% 
  filter(OBJECTID %ni% c(4, 79, 81, 84, 88, 131, 136, 222, 223, 351, 500, 501, 502, 503, 657, 659, 660, 966, 969 )) %>% 
  select(name, number, apn, status, Shape__Area, geometry) %>% 
  rename(footprint = Shape__Area)

#remove excess columns
Fontana_industrial2 <- Fontana_industrial %>% 
  select(name, number, geometry, status, footprint, apn) %>%
  mutate(row = row_number())
#remove duplicates
u <- st_equals(Fontana_industrial2, retain_unique = TRUE)
Fontana_industrial <- Fontana_industrial2[-unlist(u),] %>% 
  select(-row)

speed <- rbind(c(-117.51347, 34.08497),
               c(-117.51289, 34.08684),
               c(-117.51, 34.088),
               c(-117.50901, 34.09033),
               c(-117.50595, 34.09304),
               c(-117.48938, 34.09361),
               c(-117.48938, 34.08392),
               c(-117.51347, 34.08497))
Speedway <- st_sf(name = 'Speedway Commerce Center', geom = st_sfc(st_polygon(list(speed))), crs = 4326)

rm(ls = speed, Fontana3yrPlanned, missingMoVal)

#Import EA018 warehouse list  
EA018sheet <- read_sheet('https://docs.google.com/spreadsheets/d/1Ev8455_HqftMlcxs9o7hbe3eip9SgOMomG5KHI9XlBs/edit#gid=720173336',
                                sheet = 'Warehouse Coordinates EA 108') %>% 
  select(1:3) %>% 
  janitor::clean_names() %>% 
  rename(name = name_1, lng = longitude_2, lat = latitude_3) %>% 
  filter(!is.na(lng))

EA018_whNames <- EA018sheet %>%
  select(name) %>% 
  distinct() 

tempPolygon <- EA018sheet %>%
  st_as_sf(coords = c('lng', 'lat'), crs = 4326) %>%
  group_by(name) %>%
  summarise(geom = st_combine(geometry)) %>%
  st_cast("POLYGON")
  

## SBD list to date
SBD_wh_narrowest <- Fontana_industrial %>% 
  select(name, geometry) %>% 
  rename(geom = geometry) %>% 
  bind_rows(bloom_proj) %>% 
  bind_rows(Speedway) %>% 
  bind_rows(plannedWarehouses) %>% 
  bind_rows(tempPolygon)

planned_tidy_narrow_all <- planned_tidy %>% 
  select(name, geom) %>% 
  bind_rows(SBD_wh_narrowest)


## March JPA cumulative Impact list 1
leaflet() %>% 
  addTiles() %>% 
  addProviderTiles(providers$CartoDB.PositronNoLabels, group = 'Basemap') %>% 
  addProviderTiles(provider = providers$Esri.WorldImagery, 
                   group = 'Imagery') %>% 
  addLayersControl(baseGroups = c('Basemap', 'Imagery'),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  setView(lng = -117.3, lat = 34, zoom = 9)%>% 
  addPolygons(data = planned_tidy_narrow_all,
              color = 'black',
              weight = 1,
              label = ~htmlEscape(name)) %>% 
  addPolygons(data = warehouses,
              color= 'red',
              fillOpacity = 0.2,
              weight = 1)


unlink('plannedWarehouses.geojson')
sf::st_write(planned_tidy_narrow_all, 'plannedWarehouses.geojson')

