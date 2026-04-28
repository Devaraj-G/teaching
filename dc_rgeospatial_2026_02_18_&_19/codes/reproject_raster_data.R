# Reproject raster

dtm_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif')
dtm_hill_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_DTMhill_WGS84.tif')
dtm_harv_df <- as.data.frame(dtm_harv, xy = TRUE)
dtm_hill_harv_df <- as.data.frame(dtm_hill_harv, xy = TRUE)

# overlay dtm and hill shade
ggplot() +
  geom_raster(data = dtm_harv_df,
              aes(x = x, y = y, fill = HARV_dtmCrop)) +
  geom_raster(data = dtm_hill_harv_df,
              aes(x = x, y = y, alpha = HARV_DTMhill_WGS84)) +
  scale_fill_gradientn(name = 'elevation', colors = terrain.colors(10)) +
  coord_quickmap()

# plot dtm
ggplot() +
  geom_raster(data = dtm_harv_df,
              aes(x = x, y = y, fill = HARV_dtmCrop)) +
  scale_fill_gradientn(name = 'Elevation', colors = terrain.colors(10)) +
  coord_fixed()

# plot hill shade
ggplot() +
  geom_raster(data = dtm_hill_harv_df,
              aes(x = x, y = y, alpha = HARV_DTMhill_WGS84)) +
  coord_fixed()

# CRS Coordinate Reference System
# CRS ~ SRS Spatial Reference System
# WGS World Geodetic System
# Horizontal datum/ Vertical Datum
# PROJ PROJection
# GCS Geographical Coordinate System (on the sphere, degrees)
# PCS Projected coordinates System
# EPSG European Petroleum Survey Group
# OGC Oopen Geography Consortium
# WKT Well Known Text
# UTM Universal Transverse Mercator
# https://kartoweb.itc.nl/geometrics/Map%20projections/mappro.html


describe(dtm_harv)
# CRS: WGS 84 / UTM zone 18N (PROJCRS)
# Resolution: Pixel Size = (1.000000000000000,-1.000000000000000)
# LENGTHUNIT[\"metre\",1]]
# Cartesian

describe(dtm_hill_harv)
# CRS: WGS 84 (GEOGCRS)
# Resolution: Pixel Size = (0.000012200000000,-0.000008990000000)
# ANGLEUNIT[\"degree\",0.0174532925199433]]
# Ellipsoidal

crs1 <- crs(dtm_harv, parse = TRUE)
crs1
crs2 <- crs(dtm_hill_harv, parse = TRUE)
crs2

# reproject with crs
# changes the value of coordinates
dtm_hill_utm_harv = project(dtm_hill_harv, crs(dtm_harv)) # wgs 84 -> UTM 18N
crs3 <- crs(dtm_hill_utm_harv, parse = TRUE)
crs3

# spatial extent
ext(dtm_harv)
ext(dtm_hill_harv)
ext(dtm_hill_utm_harv)

# resolution
res(dtm_harv) # 1m
res(dtm_hill_harv) # rad
res(dtm_hill_utm_harv) # 1m? 1.001061 m

# reproject with crs & res
dtm_hill_utm_harv <- project(dtm_hill_harv,
                             crs(dtm_harv),
                             res = res(dtm_harv))
res(dtm_hill_utm_harv) # changed to 1m from 1.001061m

dtm_hill_utm_harv_df <- as.data.frame(dtm_hill_utm_harv, xy = TRUE)
ggplot() +
  geom_raster(data = dtm_harv_df,
              aes(x = x, y = y, fill = HARV_dtmCrop)) +
  geom_raster(data = dtm_hill_utm_harv_df,
              aes(x = x, y = y, alpha = HARV_DTMhill_WGS84)) +
  scale_fill_gradientn(name = 'Elevation', colors = terrain.colors(10)) +
  coord_fixed()



