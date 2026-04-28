# raster calculations

# load libraries
library(terra)
library(ggplot2)
library(raster)

# Calculate CHM
# CHM = DSM - DTM

# load data
dtm_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif')
dtm_harv_df <- as.data.frame(dtm_harv, xy = TRUE)

dsm_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif')
dsm_harv_df <- as.data.frame(dsm_harv, xy = TRUE)

# plot dtm
ggplot() +
  geom_raster(data = dtm_harv_df,
              aes(x = x, y =y, fill = HARV_dtmCrop)) +
  scale_fill_gradientn(name = 'elevation', colors = terrain.colors(10)) +
  coord_quickmap() +
  ggtitle('dtm')

# plot dsm
ggplot() +
  geom_raster(data = dsm_harv_df,
              aes(x = x, y =y, fill = HARV_dsmCrop)) +
  scale_fill_gradientn(name = 'elevation', colors = terrain.colors(10)) +
  coord_quickmap() +
  ggtitle('dsm')

res(dtm_harv)
res(dsm_harv)

minmax(dsm_harv)
minmax(dtm_harv)

# CHM straightaway subtraction
chm_harv <- dsm_harv - dtm_harv
minmax(chm_harv)

chm_harv_df <- as.data.frame(chm_harv, xy = TRUE)
ggplot() +
  geom_raster(data = chm_harv_df,
              aes(x = x, y = y, fill = HARV_dsmCrop)) +
  scale_fill_gradientn(name = 'canopy', colors = terrain.colors(10)) +
  coord_quickmap() +
  ggtitle('chm')

ggplot() +
  geom_histogram(data = chm_harv_df,
                 aes(x = HARV_dsmCrop),
                     bins = 6)

# CHM using lapp()
# outputraster <- lapp(x,fun = functionname)
# functionname < function(variable1, variable2, ..){what to do with var1 var 2..., what to return as output}
# since only 1 x is allowed, combine the rasters into 1 list
fn = function(r1,r2){return(r1-r2)}
chm_2_harv <- lapp(
  sds(list(dsm_harv, dtm_harv)),
  fun = function(r1,r2){return(r1-r2)}
)

all.equal(values(chm_harv),values(chm_2_harv))

chm_2_harv_df <- as.data.frame(chm_2_harv, xy = TRUE)
ggplot() +
  geom_raster(data = chm_2_harv_df,
              aes(x = x, y = y, fill = HARV_dsmCrop)) +
  scale_fill_gradientn(name = 'canopy', colors = terrain.colors(10)) +
  coord_quickmap() +
  ggtitle('chm2')

writeRaster(chm_2_harv,
             './figures/chm_harv.tiff',
             filetype = 'GTiff',
             overwrite = TRUE,
            NAflag = -9999)

