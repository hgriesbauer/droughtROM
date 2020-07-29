# Combine CMI and drought hazard ratings

library(here)
library(tidyverse)
library(sf)
library(readxl)

# Load in CMI data
matData<-read_excel(here("data-raw","CMI","CMI","tsa16_mat2019.xlsm"),sheet="source_header")
cmiData<-read_excel(here("data-raw","CMI","CMI","tsa16_ground_samples_2019mar06.xlsm"),sheet="header")

# convert to points
matPoints = st_as_sf(matData, coords = c("longitude", "latitude"),crs = 4326)
cmiPoints = st_as_sf(cmiData, coords = c("longitude", "latitude"),crs = 4326)

# Load in shapefile
drought<-
  st_read(here("data-raw","droughtRating","BL_SX_MACK.shp")) %>% 
  st_transform(drought,crs=4326) # transform to WGS84

# Intersection
matDrought <- st_intersection(matPoints, drought)

