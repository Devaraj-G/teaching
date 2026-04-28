# load, plot vectors

# load
library(sf) # simple features
library(terra)
library(ggplot2)
library(dplyr)

aoi_boundary_harv <- st_read(
  "data/2009586/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")

st_geometry_type(aoi_boundary_harv)
st_crs(aoi_boundary_harv)
st_bbox(aoi_boundary_harv)

aoi_boundary_harv
class(aoi_boundary_harv)

ggplot() +
  geom_sf(data = aoi_boundary_harv, size = 2, color = 'red', fill = 'cyan') +
  ggtitle('aoi boundary plot') +
  coord_sf(datum = NULL)

point_harv <- st_read('data/2009586/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp')
lines_harv <- st_read('data/2009586/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp')

class(aoi_boundary_harv)
class(point_harv)
class(lines_harv)
st_crs(aoi_boundary_harv)
st_crs(point_harv)
st_crs(lines_harv)

st_geometry_type(aoi_boundary_harv)
st_geometry_type(point_harv)
st_geometry(lines_harv)

names(lines_harv)
head(lines_harv)
lines_harv$TYPE
unique(lines_harv$TYPE)

footpath_harv <- lines_harv %>%
  filter(TYPE == 'footpath')
nrow(footpath_harv)

ggplot() +
  geom_sf(data = footpath_harv) +
  ggtitle('NEON Harvard Forest', subtitle = 'footpaths') +
  coord_sf()

ggplot() +
  geom_sf(data = footpath_harv,
          aes(color = factor(OBJECTID), linewidth = 1.5)) +
  labs(color = 'footpath id') +
  ggtitle('NEON Harvard Forest', subtitle = 'footpaths') +
  coord_sf()

boardwalk_harv <- lines_harv %>%
  filter(TYPE == 'boardwalk')
nrow(boardwalk_harv)

ggplot() +
  geom_sf(data = boardwalk_harv,
          aes(color = factor(OBJECTID), linewidth = 1.5)) +
  labs(color = 'boardwalk id') +
  ggtitle('NEON Harvard Forest', subtitle = 'boardwalk') +
  coord_sf()

stonewall_harv <- lines_harv %>%
  filter(TYPE == 'stone wall')
nrow(stonewall_harv)

ggplot() +
  geom_sf(data = stonewall_harv,
          aes(color = factor(OBJECTID), linewidth = 1.5)) +
  labs(color = 'stonewall id') +
  ggtitle('NEON Harvard Forest', subtitle = 'stone wall') +
  coord_sf()

ggplot() +
  geom_sf(data = stonewall_harv,
          aes(color = OBJECTID , linewidth = 1.5)) +
  labs(color = 'stonewall id') +
  ggtitle('NEON Harvard Forest', subtitle = 'stone wall') +
  coord_sf()

unique(lines_harv$TYPE) # 4 types
road_colors <- c('blue','green', 'navy', 'purple')
line_widths <- c(1,2,3,4)

ggplot() +
  geom_sf(data = lines_harv,
          aes(color = TYPE, linewidth = TYPE)) +
  scale_color_manual(values = road_colors) +
  labs(color = 'road type') +
  scale_linewidth_manual(values = line_widths) +
  ggtitle('Neon HARVARD forest field site', subtitle = 'roads & trails') +
  coord_sf()

ggplot() +
  geom_sf(data = lines_harv,
          aes(color = TYPE, linewidth = TYPE)) +
  scale_color_manual(name = 'Road Type', values = road_colors) +
  labs(color = 'road type') +
  scale_linewidth_manual(name = 'Road Type', values = line_widths) +
  ggtitle('Neon HARVARD forest field site', subtitle = 'roads & trails') +
  coord_sf()

ggplot() +
  geom_sf(data = lines_harv,
          aes(color = TYPE, linewidth = TYPE)) +
  scale_color_manual(name = 'Road Type', values = road_colors) +
  labs(color = 'road type') +
  scale_linewidth_manual(name = 'Road Type', values = line_widths) +
  theme(legend.text = element_text(size = 10),
        legend.box.background = element_rect(linewidth = 1)) +
  ggtitle('Neon HARVARD forest field site', subtitle = 'roads & trails') +
  coord_sf()

# challenge: only roads where bicycles and horses are allowed
lines_biho <- lines_harv %>%
  filter(BicyclesHo == 'Bicycles and Horses Allowed')
lines_bihono <- lines_harv %>%
  filter(BicyclesHo == 'Bicycles and Horses NOT ALLOWED')
ggplot() +
  geom_sf(data = lines_biho, color = 'red', linewidth = 2) +
  geom_sf(data = lines_bihono, color = 'black')


# multiple vectors plotting
ggplot() +
  geom_sf(data = aoi_boundary_harv, fill = 'grey', color = 'black') +
  geom_sf(data = lines_harv, aes(color = TYPE), size = 1)+
  geom_sf(data = point_harv) +
  ggtitle('roads and tower') +
  coord_sf()

ggplot() +
  geom_sf(data = aoi_boundary_harv, fill = 'grey', color = 'black') +
  geom_sf(data = point_harv, aes(fill = Sub_Type), show.legend = 'line', size = 1) +
  geom_sf(data = lines_harv, aes(color = TYPE), size = 1)+
  scale_color_manual(name = 'roads', values = road_colors) +
  scale_fill_manual(name = 'tower location', values = 'yellow') +
  ggtitle('roads and tower') +
  coord_sf()

# challenge: soil types
# imprt data
plot_locations <-
  st_read("data/2009586/NEON-DS-Site-Layout-Files/HARV/PlotLocations_HARV.shp")
#explore data
str(plot_locations)
names(plot_locations)
nrow(plot_locations)
unique(plot_locations$soilTypeOr) # 2 types

blue_orange <- c('orange','red')

plot_locations$soilTypeOr <- as.factor(plot_locations$soilTypeOr)
levels(plot_locations$soilTypeOr)
ggplot() +
  geom_sf(data = lines_harv, aes(color = TYPE))+
  geom_sf(data = plot_locations, aes(fill = soilTypeOr), shape = 21) +
  scale_color_manual(name = 'road type', values = road_colors,
                     guide = guide_legend(override.aes = list(linetype = 'solid', shape = NA))) +
  scale_fill_manual(name = 'soil type', values = blue_orange, guide = guide_legend(override.aes = list(linetype = 'blank', color = 'black'))) +
  coord_sf()

ggplot() +
  geom_sf(data = lines_harv, aes(color = TYPE))+
  geom_sf(data = plot_locations, aes(fill = soilTypeOr), shape = 21) +
  scale_color_manual(name = 'road type', values = road_colors) +
  scale_fill_manual(name = 'soil type', values = blue_orange) +
  coord_sf()

ggplot() +
  geom_sf(data = lines_harv, aes(color = TYPE))+
  geom_sf(data = plot_locations, aes(fill = soilTypeOr, shape = soilTypeOr)) +
  scale_shape_manual(name = 'soil type', values = c(21,22)) +
  scale_color_manual(name = 'road type', values = road_colors) +
  scale_fill_manual(name = 'soil type', values = blue_orange) +
  coord_sf()

# overlay vectors on top of a raster
# load data
dtm_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif')
dtm_harv_df <- as.data.frame(dtm_harv, xy = TRUE)

dsm_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif')
dsm_harv_df <- as.data.frame(dsm_harv, xy = TRUE)

# CHM straightaway subtraction
chm_harv <- dsm_harv - dtm_harv
chm_harv_df <- as.data.frame(chm_harv, xy = TRUE)

ggplot() +
  geom_raster(data = chm_harv_df, aes(x = x, y = y, fill = HARV_dsmCrop)) +
  scale_fill_gradientn(colors = terrain.colors(10))

ggplot() +
  geom_raster(data = chm_harv_df, aes(x = x, y = y, fill = HARV_dsmCrop)) +
  geom_sf(data = lines_harv, color = 'black') +
  geom_sf(data = aoi_boundary_harv, fill = NA,  size = 1) +
  geom_sf(data = point_harv, pch = 8) +
  scale_fill_viridis_c() +
  ggtitle('Harvard Roads on top of canopy') +
  coord_sf()

# reprojecting vectors

state_boundary_us <- st_read(
  'data/2009586/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-State-Boundaries-Census-2014.shp') %>% st_zm()
st_crs(state_boundary_us)

ggplot() +
  geom_sf(data = state_boundary_us) +
  ggtitle('continuous US state boundaries') +
  coord_sf()

us_outline <- st_read('data/2009586/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-Boundary-Dissolved-States.shp') %>% st_zm()
st_crs(us_outline)


ggplot() +
  geom_sf(data = state_boundary_us, color = 'gray60') +
  geom_sf(data = us_outline, color = 'black', size = 2, alpha = 0.1) +
  ggtitle('map of continguous US state boundaries') +
  coord_sf()

st_crs(us_outline)$proj4string

