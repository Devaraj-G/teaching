# plot raster data
# ggplot: use it for all plotting

# plot data with breaks

# plot with data continuous
ggplot() +
  geom_raster(data = dsm_harv_df, aes(x = x, y = y, fill =HARV_dsmCrop)) +
  scale_fill_viridis_c() +
  coord_quickmap()

dsm_harv_df <- dsm_harv_df %>%
  mutate(fct_elevation = cut(HARV_dsmCrop, breaks = 3))
str(dsm_harv_df)

ggplot() +
  geom_bar(data = dsm_harv_df, aes(fct_elevation))

unique(dsm_harv_df$fct_elevation)

dsm_harv_df %>% count(fct_elevation)

custom_bins <- c(300,350,400,450)

dsm_harv_df <- dsm_harv_df %>%
  mutate(fct_elevation_2 = cut(HARV_dsmCrop, breaks = custom_bins))
unique(dsm_harv_df$fct_elevation_2)

ggplot() +
  geom_bar(data = dsm_harv_df, aes(fct_elevation_2))

ggplot() +
  geom_raster(data = dsm_harv_df, aes(x = x, y = y, fill = fct_elevation_2)) +
  coord_quickmap()

terrain.colors(3)

ggplot() +
  geom_raster(data = dsm_harv_df, aes(x = x, y = y, fill = fct_elevation_2)) +
  scale_fill_manual(values = terrain.colors(3)) +
  coord_quickmap()

ggplot() +
  geom_raster(data = dsm_harv_df, aes(x = x, y = y, fill = fct_elevation_2)) +
  scale_fill_manual(values = c('red','blue', 'yellow')) +
  coord_quickmap()

# some styling
my_colors <- terrain.colors(3)

ggplot() +
  geom_raster(data = dsm_harv_df, aes(x = x, y = y, fill = fct_elevation_2)) +
  scale_fill_manual(values = my_colors, name = 'elevation') +
  theme(axis.title = element_blank()) +
  coord_quickmap()

# challenge
# make 6 cuts
dsm_harv_df <- dsm_harv_df  %>%
  mutate(fct_elevation_6 = cut(HARV_dsmCrop, breaks = 6))
# make 6 colors
my_colors <- terrain.colors(6)
# plot
ggplot() +
  geom_raster(data = dsm_harv_df, aes(x = x, y = y, fill = fct_elevation_6)) +
  scale_fill_manual(values = my_colors, name = 'elevation') +
  ggtitle('classified elevation map') +
  xlab('utm easting (m)') +
  ylab('utm northing (m)') +
  coord_quickmap()

# layering rasters
# one raster on top another

dsm_hill_harv <- rast('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_DSMhill.tif')
dsm_hill_harv

dsm_hill_harv_df <- as.data.frame(dsm_hill_harv, xy = TRUE)
str(dsm_hill_harv_df)

ggplot() +
  geom_raster(data = dsm_hill_harv_df,
              aes(x = x, y = y, alpha = HARV_DSMhill)) +
  scale_alpha(range = c(0.15,0.65), guide = 'none') +
  coord_quickmap()

ggplot() +
  geom_raster(data = dsm_harv_df,
              aes(x = x, y = y, fill = HARV_dsmCrop)) +
  geom_raster(data = dsm_hill_harv_df,
              aes(x = x, y = y, alpha = HARV_DSMhill)) +
  scale_fill_viridis_c() +
  scale_alpha(range = c(0.15,0.65), guide = 'none') +
  ggtitle('elevation with hillshade') +
  coord_quickmap()

ggplot() +
  geom_raster(data = dsm_harv_df,
              aes(x = x, y = y, fill = HARV_dsmCrop)) +
  scale_fill_viridis_c() +
  ggtitle('elevation with hillshade') +
  coord_quickmap()










































