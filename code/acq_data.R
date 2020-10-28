library(sf)
library(osmdata)
# library(ggplot2)
# library(ggmap)
library(dplyr)
#####input
#read zones
zonas <- st_read(dsn = "data/Cumunas- Zonas.shp")
st_crs(zonas) <- 32719
zonas <- zonas %>%  
  st_transform(4326)
#####query data
# available_features()
# available_tags(c("amenity", "goods", "tourism", "shop", "leisure", "religion", "social facility"))

mall <- opq(bbox = st_bbox(zonas)) %>%
  add_osm_feature(key = "shop", value = c("mall", "shopping_centre")) %>%
  osmdata_sf()

#data transformation
mall_pgn <- mall$osm_polygons %>%
  select(Nombre = name, tipo = shop) %>%
  mutate(Nombre = iconv(Nombre, from = "UTF-8", to = "UTF-8")) %>%
  filter(!is.na(tipo))

mall_pt <- st_transform(mall_pgn, 32719) %>%
  st_centroid(mall_pgn) %>%
  st_transform(4326)
# mall_pt <- mall$osm_points
#our background map
# mad_map <- get_map(c(-70.93142, -33.74651, -70.45642, -33.29388), 
#                    maptype = "toner-background")
# 
#final map
# ggmap(mad_map)+
#   geom_sf(data = building$osm_points,
#           inherit.aes = FALSE,
#           colour = "#238443",
#           fill = "#004529",
#           alpha = .5,
#           size = 1,
#           shape = 21)+
#   labs(x = "", y = "")
