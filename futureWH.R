##Generate geospatial datafile of planned warehouses
##Created by Mike McCarthy and possibly EA 078
##First created as part of MJPA mapping process in October 2022
##Last modified April 2024

#rm(list =ls())
'%ni%' <- Negate('%in%') ## not in operator

library(sf)
library(tidyverse)
library(googlesheets4)


 # filter(county %in% c('Riverside', 'San Bernardino'))

#manually entered parcels from 215/60 corridor
source('PolygonTest.R')
source('EA078_warehouse_polygons.R')

#worksheet with details of projects
# do I need this?
#March215_60_sheet <- read_sheet('https://docs.google.com/spreadsheets/d/1u7JJYoxl5lE-oXJHEt5kqICmLug6SDh5sYSrSNud7Cs/edit#gid=0',
#                       sheet = 'March215_60') %>% 
#  janitor::clean_names()

#a couple of older approved warehouses in Moreno Valley from public records request
missingMoVal <- sf::st_read('C:/Dev/MJPA2/jurisdictions/moValmissing.geojson') %>% 
  select(Name, geometry) %>% 
  rename(geom = geometry, name = Name)

#planned215_60_full <- planned215_60 %>% 
#  bind_rows(missingMoVal) %>% 
#  full_join(March215_60_sheet, by = c('name' = 'building_id')) %>% 
#  rename(buildingID = 'name', project_size_sq_ft = size_sq_ft) %>% 
#  select(-x14, -jurisdiction_enviro_docs)

##San Bernardino County planned warehouse data to date

## Fontana and near Fontana data
## MCN_projects acquired from City of Fontana Open Data page  May 2023
## https://data-fontanaca.opendata.arcgis.com/datasets/mcn-projects-public/explore?location=34.108794%2C-117.462315%2C12.92

notWHParcels <- c('zoning code amendment schools in fbc and truck rep',
                  'east coast truck and auto sales',
                  'up zoning for the i-15 logistics warehouse')

Fontana3yrPlanned <- sf::st_read(dsn = 'MCN_Projects_Public.geojson')  |>  
  rename(name = ProjName,
         number = ProjNum,
         status = Status,
         apn = ProjAPN) |> 
 # select(name, number, apn, status, Description, geometry) |> 
  mutate(name = stringr::str_to_lower(name)) |>  
  mutate(wh = str_detect(name, 'warehouse'),
         ind = str_detect(name, 'industrial'),
         log = str_detect(name, 'logistics'),
         com = str_detect(name, 'commerce'),
         truck = str_detect(name, 'truck'),
         bus = str_detect(name, 'business center'),
         cc = str_detect(name, 'corporate center')) %>% 
  filter(name %ni% notWHParcels) |> 
  st_transform(crs = 4326) |> 
  mutate(name = case_when(
        name == 'north fontana industrial complex' ~ 'sierra business center 2',
        name == 'sierra business center' ~ 'sierra business center 1',
        name == 'sierra avenue industrial building' ~ 'sierra business center 3',
        name == 'duke warehouse' ~ 'cypress and slover warehouse',
        TRUE ~ name
  ))

Fontana_industrial <- Fontana3yrPlanned |>  
  filter(wh == TRUE | ind == TRUE | log == TRUE | com == TRUE | truck == TRUE | bus == TRUE | cc == TRUE) |>  
  filter(OBJECTID %ni% c(160, 674)) %>% 
  select(OBJECTID,name, number, apn, status, Description, truck, geometry)  


#remove excess columns
Fontana_industrial2 <- Fontana_industrial %>% 
  select(name, number, geometry, status, truck) %>%
  mutate(row = row_number()) |> 
  filter(truck == FALSE)
#remove duplicates and merge named projects
u <- st_equals(Fontana_industrial2, retain_unique = TRUE)
Fontana_industrial <- Fontana_industrial2[-unlist(u),] %>% 
  select(-row) |> 
  group_by(name) |> 
  summarize(.groups = 'drop') |> 
  mutate(repair = str_detect(name, 'repair'),
         timeExt = str_detect(name, 'time extension')) |> 
  filter(repair == FALSE & timeExt == FALSE) |> 
  select(-repair, -timeExt) #|> 
  

speed <- rbind(c(-117.51347, 34.08497),
               c(-117.51289, 34.08684),
               c(-117.51, 34.088),
               c(-117.50901, 34.09033),
               c(-117.50595, 34.09304),
               c(-117.48938, 34.09361),
               c(-117.48938, 34.08392),
               c(-117.51347, 34.08497))
Speedway <- st_sf(name = 'Speedway Commerce Center I', geom = st_sfc(st_polygon(list(speed))), crs = 4326)

rm(ls = speed, Fontana3yrPlanned)

# Menifee shapefile 
menifee <- sf::st_read(dsn = 'Menifee') %>% 
  st_transform(crs =4326) %>% 
  select(ProjectTit, geometry) %>% 
  rename(name = ProjectTit, geom = geometry) |> 
  mutate(name = ifelse(name == 'Ethanac & Barnett Warehouse',
                       'Ethanac and Barnett Warehouse', name)) |> 
  mutate(name = ifelse(name == 'Corsica Business Park',
                       'Corsica Evans Wheat Warehouses 1', name)) |> 
  mutate(name = ifelse(name == 'Wheat Warehouse',
                       'Corsica Evans Wheat Warehouses 2', name)) |> 
  mutate(name = ifelse(name == 'Ethanac and Evans Warehouse',
                       'Corsica Evans Wheat Warehouses 3', name)) |> 
  mutate(name = ifelse(name == 'Capstone Industrial',
                       'CADO Menifee Warehouse', name)) |> 
  filter(name != 'Northern Gateway Commerce Center I') |> 
  filter(name != 'McGee Office and Storage') |> 
  filter(name != 'Nova Battery Storage') |> 
  filter(name != 'Trumble and Watson Warehouse') |> 
  filter(name != 'United Carports Warehouse')

#Import EA018 warehouse list  
#Authentication required
EA018sheet <- read_sheet('https://docs.google.com/spreadsheets/d/1Ev8455_HqftMlcxs9o7hbe3eip9SgOMomG5KHI9XlBs/edit#gid=720173336',
                                sheet = 'Warehouse Coordinates EA 108') %>% 
  select(1:3) %>% 
  janitor::clean_names() %>% 
  rename(lng = longitude, lat = latitude) %>% 
  filter(!is.na(lng))

EA018_whNames <- EA018sheet %>%
  select(name) %>% 
  distinct() 

tempPolygon <- EA018sheet %>%
  st_as_sf(coords = c('lng', 'lat'), crs = 4326) %>%
  group_by(name) %>%
  summarise(geom = st_combine(geometry)) %>%
  st_cast("POLYGON")

## remove extraneous
rm(ls = EA018_whNames, EA018sheet, Fontana_industrial2, u)

## Known warehouse list to date
planned_tidy2 <- Fontana_industrial %>% 
  select(name, geometry) %>% 
  rename(geom = geometry) %>% 
  bind_rows(bloom_proj) %>% 
  bind_rows(Speedway) %>% 
  bind_rows(plannedWarehouses) %>% 
  bind_rows(tempPolygon) %>% 
  bind_rows(menifee) |> 
  bind_rows(planned215_60) |> 
  bind_rows(missingMoVal)

built_WH_list <- c('airef beech ave logistics center',
                            'almond truck and trailer',
                            'beech and santa ana warehouse',
                            'boyle west warehouse',
                            'citrus & slover warehouse',
                            'clover industrial property',
                            'fontana foothills commerce center',
                            'goodman industrial park iii',
                            'homestead industrial project',
                            'Interchange Logistics Center 2',
                            'Knox Business Park Bldg. D',
                            'Knox Business Park Bldg. E',
                            'Mango Avenue Industrial',
                            'Multi_Tenant_Industrial_Warehouse_Redlands',
                            'Mountain View Industrial',
                            #'santa ana ave industrial development',
                            'Seaton and Perry Industrial Project',
                            'Seaton Tech Center',
                            'sierra and casa grande industrial project',
                            'SierraSummit',
                            'South Campus Reg3',
                            'South Campus Bldg 2',
                            'South Campus Bldg 1',
                            'target warehouse generator',
                            'Whittram Avenue Warehouse',
                            'Menifee Commerce Center II')

rejected_list <- c('Airport Gateway Specific Plan Area', 'Compass Danbe Centerpointe')

multiBldg_complexes <- c('barton rd logistics center',
                         'edgemont commerce center',
                         'fontana business center',
                         'freeway corridor specific plan',
                         'highway 74 plan',
                         'majestic freeway business park',
                         'south campus',
                         'sycamore hills distribution center bldg',
                         'temescal valley commerce center')

sf_use_s2(FALSE)
planned_tidy3 <- planned_tidy2 |> 
  filter(name %ni% built_WH_list) |> 
  filter(name %ni% rejected_list) |> 
  mutate(name = str_to_lower(name)) |> 
  group_by(name) |> 
  summarize(.groups = 'drop') |> 
  mutate(name = case_when(
    name == 'cra 938' ~ 'iowa street warehouse',
    name == 'menifee valley specific plan eir' ~ 'menifee valley specific plan', 
    TRUE ~ name
  ))

planned_tidy <- planned_tidy3 |> 
  mutate(complexName = case_when(
    str_detect(name, 'barton rd logistics center') ~ 'barton rd logistics center',
    str_detect(name, 'edgemont commerce center') ~ 'edgemont commerce center',
    str_detect(name, 'fontana business center') ~ 'fontana business center',
    str_detect(name, 'freeway corridor specific plan') ~ 'freeway corridor specific plan',
    str_detect(name, 'highway 74 plan') ~ 'highway 74 plan',
    str_detect(name, 'majestic freeway business park') ~ 'majestic freeway business park',
    str_detect(name, 'south campus') ~ 'south campus',
    str_detect(name, 'sycamore hills distribution center bldg') ~ 'sycamore hills distribution center bldg',
    str_detect(name, 'temescal valley commerce center') ~ 'temescal valley commerce center',
    str_detect(name, 'cordova complex') ~ 'cordova complex',
    str_detect(name, 'corsica evans wheat warehouses') ~ 'corsica evans wheat warehouses',
    str_detect(name, 'sierra business center') ~ 'sierra business center',
    str_detect(name, 'ontario ranch') ~ 'ontario ranch',
    TRUE ~ name
  )) |> 
  group_by(complexName) |> 
  summarize(.groups = 'drop') |> 
  rename(name = complexName)

# existing warehouses
WH.url <- 'https://raw.githubusercontent.com/RadicalResearchLLC/WarehouseMap/main/WarehouseCITY/geoJSON/finalParcels.geojson'
warehouses <- st_read(WH.url) %>% 
  st_transform("+proj=longlat +ellps=WGS84 +datum=WGS84") #%>% 


## Planned warehouses cumulative Impact list 1
leaflet() %>% 
  addTiles() %>% 
  addProviderTiles(providers$CartoDB.Positron, group = 'Basemap') %>% 
  addProviderTiles(provider = providers$Esri.WorldImagery, 
                   group = 'Imagery') %>% 
  addLayersControl(baseGroups = c('Basemap', 'Imagery'),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  setView(lng = -117.3, lat = 34, zoom = 9)%>% 
  addPolygons(data = warehouses,
              fillColor= 'black',
              color = 'red',
              fillOpacity = 0.2,
              weight = 1) |> 
  addPolygons(data = planned_tidy,
              color = 'black',
              weight = 1,
              label = ~htmlEscape(name),
              fillOpacity = 0.3) 

## Link to CEQA master list

MasterSCH <- read_sheet('https://docs.google.com/spreadsheets/d/1Ev8455_HqftMlcxs9o7hbe3eip9SgOMomG5KHI9XlBs/edit#gid=720173336',
                         sheet = 'MasterList',
                        col_types = 'ccn?iccDcccccccicc??????') |> 
  distinct() |> 
  janitor::clean_names() |> 
  select(1:19)

sf_use_s2(FALSE)

planned_with_CEQA <- planned_tidy |> 
  mutate(name = str_to_lower(name)) |> 
  inner_join(MasterSCH) |> 
  select(geom, project, ceqa_url, sch_number, stage_pending_approved)

planned_mismatch <- planned_tidy |> 
  mutate(name = str_to_lower(name)) |> 
  st_set_geometry(value = NULL) |> 
  full_join(MasterSCH) |> 
  anti_join(planned_with_CEQA) |> 
  arrange(name) 

planned_unmatched <- planned_tidy |> 
  right_join(planned_mismatch) |> 
  filter(is.na(project))

planned_color_palette <- colorFactor(
  palette = c('black', 'maroon', 'maroon', 'maroon', 'purple', 'pink', 'maroon', 'maroon'),
  domain = planned_with_CEQA$stage_pending_approved
)

leaflet() %>% 
  addTiles() %>% 
  addProviderTiles(providers$CartoDB.Positron, group = 'Basemap') %>% 
  addProviderTiles(provider = providers$Esri.WorldImagery, 
                   group = 'Imagery') %>% 
  addLayersControl(baseGroups = c('Basemap', 'Imagery'),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  setView(lng = -117.3, lat = 34, zoom = 9)%>% 
  addPolygons(data = planned_with_CEQA,
              color = ~planned_color_palette(stage_pending_approved) ,
              fillOpacity = 0.2,
              weight = 1,
              label = ~htmlEscape(paste(name, stage_pending_approved))
              )|> 
  addPolygons(data = planned_unmatched,
              color = 'blue',
              weight = 1,
              label = ~htmlEscape(name),
              fillOpacity = 0.3) 

##only works with original FONTANA INDUSTRIAL
mismatched_w_description <- Fontana_industrial |> 
  right_join(planned_mismatch) |> 
  filter(is.na(project))

unlink('plannedWarehouses.geojson')
sf::st_write(planned_tidy, 'plannedWarehouses.geojson')

areaM2 <- as.numeric(st_area(planned_with_CEQA))
planned_with_CEQA$parcel_area <- areaM2*10.7639
sum_stats <- planned_with_CEQA |> 
  st_set_geometry(value = NULL) |> 
  group_by(stage_pending_approved) |> 
  summarize(sumBldg = round(sum(size_sqft, na.rm = T), -3),
            sumFootprint = round(sum(parcel_area, na.rm = T), -4),
            countProjects = n()) 

sf::st_write(planned_with_CEQA, 'CEQA_WH.geojson')

