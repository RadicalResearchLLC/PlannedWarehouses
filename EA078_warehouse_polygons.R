##Class warehouse polygon code list
##Created February 2023

library(sf)
library(tidyverse)
library(leaflet)
library(htmltools)

airport_lot_44<- rbind(
  c(-117.397664, 34.591895),
  c(-117.395513, 34.591843),
  c(-117.395597, 34.587329),
  c(-117.397643, 34.587329),
  c(-117.397664, 34.591895))

Airport44<- st_sf(
  name = 'Airport_Lot_44_Victorville', 
  geom = st_sfc(st_polygon(list(airport_lot_44))), 
  crs = 4326)

#Mike M #Airport Gateway Specific Plan
AirportGateway1 <- rbind(
  c(-117.26095, 34.11023),
  c(-117.26095, 34.10611),
  c(-117.25946, 34.10484),
  c(-117.24921, 34.10484),
  c(-117.24455, 34.1069),
  c(-117.22594, 34.1069),
  c(-117.21669, 34.1069),
  c(-117.21262, 34.1069),
  c(-117.21248, 34.10476),
  c(-117.20905, 34.10528),
  c(-117.20532, 34.10613),
  c(-117.1997, 34.10617),
  c(-117.1998, 34.1116),
  c(-117.20086, 34.11073),
  c(-117.2117, 34.11074),
  c(-117.21757, 34.109),
  c(-117.21757, 34.11032),
  c(-117.24932, 34.11012),
  c(-117.24932, 34.10847),
  c(-117.25412, 34.10847),
  c(-117.25412, 34.11012),
  c(-117.26095, 34.11023)
)

AirportGatewaySP <- st_sf(
  name = 'Airport Gateway Specific Plan Area', 
  geom = st_sfc(st_polygon(list(AirportGateway1))), 
  crs = 4326
)



##Update this line of code with the name of your warehouse polygon 

plannedWarehouses <- rbind(Airport44, AirportGatewaySP)

##Map

leaflet() %>% 
  addTiles() %>%  
  addPolygons(data = plannedWarehouses,
              color = 'darkred',
              fillOpacity = 0.6,
              weight = 1,
              label = ~htmlEscape(name)) #%>% 
  #setView(lng = -117.396398, lat = 34.590419, zoom = 14)
