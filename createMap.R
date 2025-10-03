library(ggplot2)
library(sf)
library(dplyr)
library(purrr)

# join maps together
countries_map <- sf::st_read("countries_map") |>
  dplyr::rename(region = "CTRY21NM") |>
  dplyr::filter(region != "England") |>
  dplyr::select(!c("CTRY21CD", "CTRY21NMW"))
regions_map <- sf::st_read("regions_map") |>
  dplyr::rename(region = "RGN24NM") |>
  dplyr::select(!c("RGN24CD"))
map <- countries_map |>
  dplyr::union_all(regions_map)

# ireland
# contron negre per dividirho tot
# min and max of the scale

# data to visualise (EDIT IT or LOAD YOUR OWN DATA)
data <- dplyr::tribble(
  ~ region, ~ value,
  "Northern Ireland", 10,
  "Scotland", 20,
  "Wales", 30,
  "North East", 25,
  "North West", 20,
  "Yorkshire and The Humber", 15,
  "East Midlands", 18,
  "West Midlands", 25,
  "East of England", 30,
  "London", 33,
  "South East", 22,
  "South West", 18
)

# add data to map
map_with_data <- map |>
  dplyr::left_join(data, by = "region") |>
  mutate(label = gsub(pattern = " ", replacement = "\n", x = region))

map_with_data <- map_with_data |>
  mutate(lon=map_dbl(geometry, ~st_centroid(.x)[[1]]),
         lat=map_dbl(geometry, ~st_centroid(.x)[[2]]))

ggplot2::ggplot() +
  geom_sf(data = map_with_data, mapping = aes(fill = value), lwd = 0) +
  ggplot2::theme_void() +
  ggplot2::theme(
    plot.background = ggplot2::element_rect(fill = "white", color = NA),
    panel.background = ggplot2::element_rect(fill = "white", color = NA)
  ) +
  ggplot2::scale_fill_continuous(
    # edit colour scale, you can add as many colours that you want.
    # you need at least two for min and max
    palette = c("#FEE0D2", "#FC9272", "#DE2D26"),
    # title
    name = "My value"
  ) +
  # remove this line if you dont want names
  geom_text(
    data = map_with_data,
    mapping = aes(x = lon, y = lat, label = label),
    size = 2
  )
