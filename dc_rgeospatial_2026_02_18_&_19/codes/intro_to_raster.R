# intro to raster

# load libraries
library(ggplot2)
library(dplyr)
library(terra)

describe('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif')

harv_metadata <- capture.output(describe('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif'))

dsm_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif')
dsm_harv
summary(dsm_harv)
summary(values(dsm_harv))

# visualise data
dsm_harv_df <- as.data.frame(dsm_harv, xy = TRUE)
str(dsm_harv_df)
class(dsm_harv_df)
class(dsm_harv)

ggplot() +
  geom_raster(data = dsm_harv_df, aes(x = x, y = y, fill = HARV_dsmCrop)) +
  scale_fill_viridis_c() +
  coord_quickmap()

crs(dsm_harv,proj=TRUE)

minmax(dsm_harv)
min(values(dsm_harv))
max(values(dsm_harv))

nlyr(dsm_harv)

ggplot() +
  geom_histogram(data = dsm_harv_df, aes(HARV_dsmCrop),bins = 40)






