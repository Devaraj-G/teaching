# Multi-band rasters

# load libraries
library(terra)
library(ggplot2)

# import data
rgb_b_1_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif', lyrs = 1)
rgb_b_1_harv_df <- as.data.frame(rgb_b_1_harv, xy = TRUE)

ggplot() +
  geom_raster(data = rgb_b_1_harv_df,
              aes(x = x, y = y,
                  alpha = HARV_RGB_Ortho_1)) +
  coord_quickmap()

# all layers
rgb_stack_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif')
rgb_stack_harv
nlyr(rgb_stack_harv)

class(rgb_stack_harv) # terra
rgb_stack_harv_df <- as.data.frame(rgb_stack_harv, xy = TRUE)
class(rgb_stack_harv_df) # data.frame

str(rgb_stack_harv_df)

describe(rgb_stack_harv) # no info on order of RGB
crs(rgb_stack_harv, parse = TRUE)

ggplot() +
  geom_histogram(data = rgb_stack_harv_df, aes(HARV_RGB_Ortho_1))

ggplot() +
  geom_raster(data = rgb_stack_harv_df,
              aes(x = x, y = y, alpha = HARV_RGB_Ortho_2)) +
  coord_quickmap()

plotRGB(rgb_stack_harv,
        r = 1, g = 2, b =3)

plotRGB(rgb_stack_harv, r = 1, g = 2, b = 3, stretch = 'lin')
plotRGB(rgb_stack_harv, r = 1, g = 2, b = 3, stretch = 'hist')

# multiple datasets in 1 spatrasterDataset
rgb_sds_harv <- sds(list(rgb_stack_harv, rgb_stack_harv))
str(rgb_sds_harv)
rgb_sds_harv
rgb_sds_harv[1]
rgb_sds_harv[[1]]

# challenge

dsm_sjer <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmCrop.tif')
dtm_sjer <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmCrop.tif')

dsm_sjer_df <- as.data.frame(dsm_sjer)
dtm_sjer_df <- as.data.frame(dtm_sjer)

chm_sjer <- lapp(sds(list(dsm_sjer, dtm_sjer)),
                 fun = function(r1,r2){return(r1-r2)})

chm_sjer # -1.399 is -ve canopy
chm_sjer_df <- as.data.frame(chm_sjer, xy = TRUE)

ggplot() +
  geom_raster(data = chm_sjer_df,
              aes(x = x, y = y, fill = SJER_dsmCrop)) +
  scale_fill_gradientn(name = 'canopy', colors = terrain.colors(10)) +
  coord_quickmap()

ggplot() +
 geom_histogram(data = chm_sjer_df, aes(x = SJER_dsmCrop))

a <- ggplot() +
  geom_histogram(data = chm_sjer_df, aes(x = SJER_dsmCrop))
b <- ggplot() +geom_histogram(data = chm_sjer_df, aes(x = SJER_dsmCrop))

library(patchwork)
a+b
