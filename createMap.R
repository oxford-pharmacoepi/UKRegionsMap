library(ggplot2)
library(sf)
library(dplyr)
library(purrr)
library(here)

# join maps together
countries_map <- st_read("countries_map") |>
  rename(region = "CTRY21NM") |>
  filter(region != "England") |>
  select(!c("CTRY21CD", "CTRY21NMW"))
regions_map <- st_read("regions_map") |>
  rename(region = "RGN24NM") |>
  select(!c("RGN24CD"))
map <- countries_map |>
  union_all(regions_map)

# ireland
# contron negre per dividirho tot
# min and max of the scale

# data to visualise (EDIT IT or LOAD YOUR OWN DATA)
data <- tribble(
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
  left_join(data, by = "region") |>
  mutate(label = gsub(pattern = " ", replacement = "\n", x = region))

map_with_data <- map_with_data |>
  mutate(
    lon=map_dbl(geometry, ~st_centroid(.x)[[1]]),
    lat=map_dbl(geometry, ~st_centroid(.x)[[2]])
  )

p <- ggplot() +
  # lwd controls the size of the line, use 0 to eliminate it
  geom_sf(data = map_with_data, mapping = aes(fill = value), lwd = 0.25) +
  theme_void() +
  theme(
    plot.background = ggplot2::element_rect(fill = "white", color = NA),
    panel.background = ggplot2::element_rect(fill = "white", color = NA)
  ) +
  scale_fill_continuous(
    # edit colour scale, you can add as many colours that you want.
    # you need at least two for min and max
    palette = c("#FEE0D2", "#FC9272", "#DE2D26"),
    # title
    name = "My value"
  )

# visualise into the plot panel
p

# save it into a file
ggsave(filename = here("my_map.png"), plot = p)
# you can customise, dpi (resolution), width, height of the plot with the
# appropriate arguments

# to add names for the regions
# geom_text(
#   data = map_with_data,
#   mapping = aes(x = lon, y = lat, label = label),
#   size = 2
# )
