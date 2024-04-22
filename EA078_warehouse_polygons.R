##Class warehouse polygon code list
##Created February 2023

library(sf)
library(tidyverse)
library(leaflet)
library(htmltools)

#Chanah Haigh # Southern California Logistics Airport Lot 44 Distribution Center
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

#Anders Blaine #Southern Ontario Logistics Center Phase 2
SOLC1 <- rbind(
  c(-117.628099, 33.983300),
  c(-117.628099, 33.990346),
  c(-117.641575, 33.990382),
  c(-117.641146, 33.983265),
  c(-117.628099, 33.983300)
)
  
  SOLC <- st_sf(
    name = 'South Ontario Logistics Center', 
    geom = st_sfc(st_polygon(list(SOLC1))), 
    crs = 4326
  )
  
  

  
  
  
  #Seiji Akera #Legacy Specific Plan Project, Beaumont
  LegacyHighlands <- rbind(
    c(-117.009556, 33.933410),
    c(-117.016460, 33.933410), 
    c(-117.016460, 33.928759),
    c(-117.014361, 33.928688),
    c(-117.012596, 33.928068),
    c(-117.010818, 33.927529),
    c(-117.009416, 33.927529),
    c(-117.009556, 33.933410)
  )
  
  LegacyPhaseII<- st_sf(
    name = 'Legacy Highlands Phase II', 
    geom = st_sfc(st_polygon(list(LegacyHighlands))), 
    crs = 4326
  )  
  

  # Ivy Jones # Merril Commerce Center Specific Plan
  MerrilCommerce1 <- rbind(
    c(-117.62792680583084, 33.98314198689001),
    c(-117.62805555185095, 33.990365534672506),
    c(-117.60698411989317, 33.99050786442112),
    c(-117.60694120455312, 33.983319914161),
    c(-117.62792680583084, 33.98314198689001)
  )
  MerrilCommerce <- st_sf(
    name = 'Merril Commerce Center Specific Plan Area', 
    geom = st_sfc(st_polygon(list(MerrilCommerce1))), 
    crs = 4326
  )
  
  # Ivy Jones # Hesperia Commerce Center II
  HesperiaCommerce1 <- rbind(
    c(-117.41127489895435, 34.43390329854649),
    c(-117.41651057053542, 34.42687696149357),
    c(-117.40385054522474, 34.42685926216581),
    c(-117.40382908738243, 34.431549452930234),
    c(-117.39970921473896, 34.43146096120079),
    c(-117.39970921473896, 34.43266444069341),
    c(-117.40378617204239, 34.4327706292284),
    c(-117.40391491806251, 34.43400948550096),
    c(-117.41127489895435, 34.43390329854649)
  )
  HesperiaCommerce <- st_sf(
    name = 'Hesperia Commerce Center II', 
    geom = st_sfc(st_polygon(list(HesperiaCommerce1))), 
    crs = 4326
  )
  
  
  #Henry S #Altitude Business Centre
  
  AltitudeBusinessCentre <- rbind(
    c(-117.64742,33.96615),
    c(-117.64740,33.96139),
    c(-117.64529,33.96133),
    c(-117.64532,33.96360),
    c(-117.64365,33.96600),
    c(-117.64330,33.96754),
    c(-117.64420,33.96738),
    c(-117.64614,33.96518),
    c(-117.64742,33.96615)
  )
  
  AltitudeBusinessCentre <- st_sf(
    name = 'Altitude Business Centre', 
    geom = st_sfc(st_polygon(list(AltitudeBusinessCentre))), 
    crs = 4326
  )
  
  #Tommy Shenoi #Majestic Freeway 
  MajesticFreeway1 <- rbind(
    c(-117.255997, 33.851779),
    c(-117.256483, 33.851793),
    c(-117.256948, 33.851731),
    c(-117.257368, 33.851591),
    c(-117.257940, 33.851313),
    c(-117.258482, 33.851033),
    c(-117.258505, 33.850907),
    c(-117.257539, 33.849798),
    c(-117.257298, 33.849426),
    c(-117.257104, 33.849056),
    c(-117.256979, 33.848534),
    c(-117.256863, 33.848430),
    c(-117.254740, 33.848791),
    c(-117.255997, 33.851779))
  MajesticFreeway <- st_sf(
    name = 'Majestic Freeway Center', 
    geom = st_sfc(st_polygon(list(MajesticFreeway1))), 
    crs = 4326
  )
  
  #Austin Dowd #Mountain View Industrial
MountainViewIndustrial <- rbind(
    c(-117.243449,34.070819) ,
    c(-117.243476,34.067186) ,
    c(-117.238418,34.067131) ,
    c(-117.243449,34.070819)
  )
  
  MountainViewIndustrialSP <- st_sf(
    name = 'Mountain View Industrial', 
    geom = st_sfc(st_polygon(list(MountainViewIndustrial))), 
    crs = 4326)
  
  #Austin Dowd #Project Viento 
  ProjectViento <- rbind(
    c(-116.536738,33.910388), 
    c(-116.536847,33.903462),
    c(-116.531203,33.903385),
    c(-116.531215,33.910490),
    c(-116.536738,33.910388) 
    
  )
  
  ProjectVientoSP <- st_sf(
    name = 'Project Viento', 
    geom = st_sfc(st_polygon(list(ProjectViento))), 
    crs = 4326)
  
  #Chanah Haigh, 1-15 logistics center, Fontana
  #Mike - already in Fontana MCN projects
#  I15_Logistics<- rbind(
#    c(-117.449386, 34.174042),
#    c(-117.449396, 34.177887),
#    c(-117.444219, 34.180457),
#    c(-117.443179, 34.181885),
#    c(-117.442701, 34.181696),
#    c(-117.441911, 34.182780),
#    c(-117.440517, 34.183313),
#    c(-117.442701, 34.179545),
#    c(-117.441183, 34.178616),
#    c(-117.443179, 34.181885),
#    c(-117.449386, 34.174042))
  
#I15_Logistics <- st_sf(
#      name = 'I-15 Logistics Center', 
#      geom = st_sfc(st_polygon(list(I15_Logistics))), 
#      crs = 4326)
#Cece Ontario Ranch  
OntarioRanch1 <- rbind(
  c(-117.647611,33.990414) ,
  c(-117.645448,33.990391) ,
  c(-117.645599,33.992113) ,
  c(-117.647638,33.992124),
  c(-117.647611,33.990414)
)

OntarioRanch <- st_sf(
  name = 'Ontario Ranch 3', 
  geom = st_sfc(st_polygon(list(OntarioRanch1))), 
  crs = 4326)

SierraSummit1 <- rbind(
  c(-117.435592,34.151719) ,
  c(-117.431981,34.151734) ,
  c(-117.432045,34.153952) ,
  c(-117.435675,34.153952),
  c(-117.435592,34.151719)
)

SierraSummit <- st_sf(
  name = 'SierraSummit', 
  geom = st_sfc(st_polygon(list(SierraSummit1))), 
  crs = 4326)

#Medha Gelli #Multi Tenant Industrial Warehouse Redlands
M_T_Ind_Redlands <- rbind(
  c(-117.22175, 34.05845),
  c(-117.21965, 34.05845),
  c(-117.21965, 34.0567),
  c(-117.22175, 34.0567),
  c(-117.22175, 34.05845)
)
Industrial_Redlands <- st_sf(
  name = 'Multi_Tenant_Industrial_Warehouse_Redlands', 
  geom = st_sfc(st_polygon(list(M_T_Ind_Redlands))), 
  crs = 4326
)
#Seiji Akera #Hesperia Commerce Center II
HesperiaCC2 <- rbind(
  c(-117.399731, 34.432906), 
  c(-117.403902, 34.432906), 
  c(-117.403902, 34.433961), 
  c(-117.411273, 34.433961), 
  c(-117.416482, 34.426899), 
  c(-117.403902, 34.426899), 
  c(-117.403902, 34.431690), 
  c(-117.399731, 34.431690), 
  c(-117.399731, 34.432906)
)
HesperiaCC2SP <- st_sf(
  name = 'Hesperia Commerce Center II', 
  geom = st_sfc(st_polygon(list(HesperiaCC2))), # Turns the coordinates into a list, creates a polygon out of it, then checks to make sure it's a valid shape
  crs = 4326
)
#Kana
DaraIndustrial1  <- rbind(
  c(-117.399733,  34.416016),
  c(-117.404690, 34.416016),
  c(-117.404658, 34.417848),
  c(-117.399808, 34.417830),
  c(-117.399733,  34.416016))
DaraIndustrialProject <- st_sf(
  name = 'DaraIndustrialProject', 
  geom = st_sfc(st_polygon(list(DaraIndustrial1))), 
                crs = 4326 
  )
  
CADOMenifee1 <- rbind(
  c(-117.215164, 33.742054),
  c(-117.215185, 33.742018),
  c(-117.215078,33.737834),
  c(-117.219133,33.737843),
  c(-117.215164, 33.742054)
)
  CADOManifeeProject <- st_sf(
    name = 'CADOMenifee1',
    geom = st_sfc(st_polygon(list(CADOMenifee1))),
                  crs = 4326
    )
  
# Nile Phillips, I-15 Industrial Park
  
I15_industrial_park <- rbind(
  c(-117.399052, 34.415999),
  c(-117.399035, 34.419499),
  c(-117.394950, 34.419354),
  c(-117.394843, 34.419407),
  c(-117.390293, 34.419502),
  c(-117.390282, 34.423642),
  c(-117.388787, 34.423721),
  c(-117.387983, 34.423549),
  c(-117.386279, 34.423456),
  c(-117.386118, 34.420154),
  c(-117.389354, 34.415900),
  c(-117.390174, 34.415927),
  c(-117.390286, 34.419215),
  c(-117.394787, 34.419268),
  c(-117.394884, 34.415953),
  c(-117.399052, 34.415999)
)

I15_industrial_park_polygon <- st_sf(
  name = 'I-15 Industrial Park Area', 
  geom = st_sfc(st_polygon(list(I15_industrial_park))),
  crs = 4326
)



#Medha Gelli #2022 Legacy Highlands Specific Plan Project
L_H_S_P <- rbind(
  c(-117.016622, 33.928488),
  c(-117.013466, 33.92812),
  c(-117.01107, 33.92725),
  c(-117.00794, 33.92725),
  c(-117.0035, 33.922215), 
  c(-117.0035, 33.918507),
  c(-116.9991, 33.918507),
  c(-116.9991, 33.899434),
  c(-116.999445, 33.894),
  c(-117.004030, 33.890865),
  c(-117.004030, 33.894),
  c(-117.010184, 33.894),
  c(-117.012825, 33.894),
  c(-117.012825, 33.896723),
  c(-117.017464, 33.896723),
  c(-117.016622, 33.928488)
)
Legacy_Highlands_SP <- st_sf(
  name = 'Legacy Highlands Phase II Specific Plan', 
  geom = st_sfc(st_polygon(list(L_H_S_P))), 
  crs = 4326
)

#Henry S #Chino Majestic Heritage

ChinoMajesticHeritage <- rbind(
  c(-117.66691,33.96004),
  c(-117.66687,33.95390),
  c(-117.66148,33.95395),
  c(-117.66149839516504,33.95756713390191),
  c(-117.65915950909319,33.957576032949845),
  c(-117.65905222074082,33.95880409264722),
  c(-117.65939554346696,33.960058830976294),
  c(-117.66691,33.96004)
)

ChinoMajesticHeritageSP <- st_sf(
  name = 'Chino Majestic Heritage', 
  geom = st_sfc(st_polygon(list(ChinoMajesticHeritage))), 
  crs = 4326
)
#Cece Sunset Crossroads
SunsetCrossroads1 <- rbind(
  c(-116.928900, 33.9253),
  c(-116.92285, 33.92531),
  c(-116.92019, 33.92219),
  c(-116.91197, 33.92172),
  c(-116.91176, 33.91077),
  c(-116.92469, 33.9109), 
  c(-116.92347, 33.91298),
  c(-116.92348, 33.91559),
  c(-116.9272, 33.91559),
  c(-116.9272, 33.91976),
  c(-116.92468, 33.91834), 
  c(-116.9283, 33.92254),
  c(-116.92922, 33.92281),
  c(-116.928900, 33.9253)
)

SunsetCrossroads <- st_sf(
  name = 'SunsetCrossroads', 
  geom = st_sfc(st_polygon(list(SunsetCrossroads1))), 
  crs = 4326)

#Cece Olive Avenue
OliveAvenue1 <- rbind(
  c(-117.393255, 34.121490),
  c(-117.393286, 34.122429),
  c(-117.392281, 34.122457),
  c(-117.392219, 34.124988),
  c(-117.391414, 34.124925),
  c(-117.388074, 34.123529),
  c(-117.388007, 34.121494),
  c(-117.393255, 34.121490)
)

OliveAvenue <- st_sf(
  name = 'OliveAvenue', 
  geom = st_sfc(st_polygon(list(OliveAvenue1))), 
  crs = 4326)
#Cece Orchard Logistics
OrchardLogistics1 <- rbind(
  c(-116.998831, 33.933221),
  c(-116.994936, 33.933020),
  c(-116.994911, 33.929996),
  c(-116.998739, 33.930155),
  c(-116.998831, 33.933221)
)

OrchardLogistics <- st_sf(
  name = 'OrchardLogistics', 
  geom = st_sfc(st_polygon(list(OrchardLogistics1))), 
  crs = 4326)

#Cece Potrero Logistics
PotreroLogistics1 <- rbind(
  c(-117.016407, 33.928711),
  c(-117.016513, 33.933479),
  c(-117.008081, 33.933368),
  c(-117.007948, 33.927519),
  c(-117.011153, 33.927608),
  c(-117.013720, 33.928502),
  c(-117.016380, 33.928789),
  c(-117.016407, 33.928711)
)

PotreroLogistics <- st_sf(
  name = 'PotreroLogistics', 
  geom = st_sfc(st_polygon(list(PotreroLogistics1))), 
  crs = 4326)

#Cece Apple Valley

AppleValley1 <- rbind(
  c(-117.257541, 34.591280),
  c(-117.251097, 34.601122),
  c(-117.241881, 34.600996),
  c(-117.241881, 34.594584),
  c(-117.257541, 34.591280)
)

AppleValley <- st_sf(
  name = 'Apple Valley 143', 
  geom = st_sfc(st_polygon(list(AppleValley1))), 
  crs = 4326)

#Chanah Haigh, Durst Drive Warehouse
Durst<- rbind(
  c( -117.396297, 34.096014),
  c( -117.394236, 34.096060),
  c( -117.394240, 34.094391),
  c( -117.396283, 34.094372),
  c( -117.396297, 34.096014))

Durst<- st_sf(
  name= 'Durst Drive Warehouse', 
  geom=st_sfc(st_polygon(list(Durst))),
  crs=4326)

#Paige Baird #Ontario Ranch Specific Plan

OntarioRanchSub<- rbind(
  c(-117.645242, 33.990213),
  c(-117.641099, 33.990237),
  c(-117.641124, 33.983297),
  c(-117.645230, 33.983205),
  c(-117.645242, 33.990213)
)
OntarioRanchSub <- st_sf(
  name = 'Ontario Ranch Specific Plan', 
  geom = st_sfc(st_polygon(list(OntarioRanchSub))), 
  crs = 4326
)

#Max Boyle Ontario Ranch subsequent
OntarioRanch2 <- rbind(
  c(-117.650557, 33.98308),
  c(-117.645309, 33.983184),
  c(-117.645393, 33.990257),
  c(-117.650575, 33.990197),
  c(-117.650557, 33.98308)
)
OntarioRanch2 <- st_sf(
  name = 'Ontario Ranch 1', 
  geom = st_sfc(st_polygon(list(OntarioRanch2))), 
  crs = 4326
)

#Max Boyle 9th and Vineyard Development
NinthandVineyard <- rbind(
  c(-117.619778, 34.092563),
  c(-117.619774, 34.094813),
  c(-117.617814, 34.094820),
  c(-117.617807, 34.094756),
  c(-117.617444, 34.094732),
  c(-117.617416, 34.093878),
  c(-117.615461, 34.093884),
  c(-117.615482, 34.095657),
  c(-117.612545, 34.095668),
  c(-117.611237, 34.094025),
  c(-117.611265, 34.092636),
  c(-117.619778, 34.092563)
)
NinthandVineyard <- st_sf(
  name = 'Ninth and Vineyard', 
  geom = st_sfc(st_polygon(list(NinthandVineyard))), 
  crs = 4326
)

#Anders Blaine #Pepper Ave Industrial  Development Project
PEPPERAVE <- rbind(
  c(-117.352935, 34.132245),
  c(-117.348682, 34.132309),
  c(-117.348643, 34.130376),
  c(-117.351070, 34.130290),
  c(-117.351057, 34.129728),
  c(-117.352870, 34.129728),
  c(-117.352935, 34.132245)
)
PEPPERAVE <- st_sf(
  name = 'Pepper Ave Industrial Development Project', 
  geom = st_sfc(st_polygon(list(PEPPERAVE))), 
  crs = 4326
)

#Nathan Lu 
SoOntLogisticsCenterP_1 <- rbind(
  c(-117.63677654605547, 33.99034338154487),
  c(-117.62812910496746, 33.99037896401365),
  c(-117.62808618962706, 33.984881295912764),
  c(-117.6323777236658, 33.984916880668564),
  c(-117.6323777236658, 33.983191002850994),
  c(-117.63660488469391, 33.98326217376304),
  c(-117.63677654605547, 33.99034338154487)
)

SoOntLogisticsCenterP_1 <- st_sf(
  name = 'South Ontario Logistics Center Specific Plan Phase I', 
  geom = st_sfc(st_polygon(list(SoOntLogisticsCenterP_1))), 
  crs = 4326
)

# Nile Phillips, The Landing

landing_coords <- rbind(
  c(-117.227673, 34.106681),
  c(-117.227586, 34.104924),
  c(-117.226203, 34.104893),
  c(-117.226214, 34.104177),
  c(-117.220180, 34.104028),
  c(-117.220217, 34.104307),
  c(-117.219374, 34.104327),
  c(-117.219362, 34.106521),
  c(-117.227673, 34.106681)
)

landing_polygon <- st_sf(
  name = 'The Landing', 
  geom = st_sfc(st_polygon(list(landing_coords))),  # convert the coordinates to a list
  crs = 4326  # our coordinate reference system
)

#Annie Voss #Renaissance Ranch Commerce Center

RenaissanceRanchCCSP <- rbind(
  c(-117.425462, 33.736989),
  c(-117.421235, 33.734446),
  c(-117.419722, 33.733706),
  c(-117.417298, 33.733162),
  c(-117.416761, 33.732180),
  c(-117.415978, 33.732689),
  c(-117.416139, 33.727719),
  c(-117.424621, 33.727786),
  c(-117.424718, 33.734888),
  c(-117.428087, 33.734995),
  c(-117.428097, 33.735914),
  c(-117.429041, 33.736004),
  c(-117.429041, 33.736762),
  c(-117.426529, 33.736863),
  c(-117.426620, 33.737247),
  c(-117.425462, 33.736989)
)

RenaissanceRanchComerceCenter <- st_sf(
  name = 'Renaissance Ranch Commerce Center', 
  geom = st_sfc(st_polygon(list(RenaissanceRanchCCSP))), 
  crs = 4326)

##Update this line of code with the name of your warehouse polygon 

plannedWarehouses <- rbind(Airport44, AirportGatewaySP, AppleValley,
                           AltitudeBusinessCentre, ChinoMajesticHeritageSP, #CADOMenifee removed for dupe
                           DaraIndustrialProject, Durst,
                           HesperiaCommerce, #HesperiaCC2SP, 
                           Industrial_Redlands,
                           I15_industrial_park_polygon, landing_polygon, Legacy_Highlands_SP,
                           MerrilCommerce, MountainViewIndustrialSP, NinthandVineyard,
                           OntarioRanch, OntarioRanch2, OliveAvenue, OrchardLogistics, 
                           PEPPERAVE, PotreroLogistics, ProjectVientoSP, RenaissanceRanchComerceCenter, 
                           SierraSummit, SOLC, SunsetCrossroads )

##Map

leaflet() %>% 
  addTiles() %>%  
  addProviderTiles(provider = providers$CartoDB.PositronNoLabels) %>% 
  addPolygons(data = plannedWarehouses,
              color = 'darkred',
              fillOpacity = 0.6,
              weight = 1,
              label = ~htmlEscape(name)) #%>% 
  #setView(lng = -117.396398, lat = 34.590419, zoom = 14)

rm(ls = airport_lot_44, Airport44, AirportGateway1,AirportGatewaySP, AltitudeBusinessCentre)
rm(ls = AppleValley, AppleValley1, CADOManifeeProject, CADOMenifee1, ChinoMajesticHeritage, ChinoMajesticHeritageSP)
rm(ls = DaraIndustrial1, DaraIndustrialProject, Durst, HesperiaCC2, HesperiaCC2SP, HesperiaCommerce, HesperiaCommerce1)
rm(ls = I15_industrial_park, I15_industrial_park_polygon, Industrial_Redlands, L_H_S_P)
rm(ls = LegacyHighlands, Legacy_Highlands_SP, LegacyPhaseII, M_T_Ind_Redlands, MajesticFreeway, MajesticFreeway1)
rm(ls = MerrilCommerce, MerrilCommerce1, MountainViewIndustrial, MountainViewIndustrialSP, OliveAvenue1, OliveAvenue)
rm(ls = OntarioRanch, OntarioRanch1, OntarioRanch2, OntarioRanchSub, OrchardLogistics)
rm(ls = NinthandVineyard, OrchardLogistics1, PEPPERAVE, PotreroLogistics, PotreroLogistics1)
rm(ls = ProjectViento, ProjectVientoSP, SierraSummit, SierraSummit1, SOLC, SOLC1, SoOntLogisticsCenterP_1)
rm(ls = SunsetCrossroads, SunsetCrossroads1, landing_coords, landing_polygon, RenaissanceRanchComerceCenter, RenaissanceRanchCCSP)


