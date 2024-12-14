### ADVENT OF CODE - DAY 14 ########################

# -- Libraries -------------------------

library(tidyverse)

# -- Load data ------------------------

input <- read_delim(
  here::here("2024", "day_14", "input_day14.txt"),
  delim = " ",
  col_names = c("pos", "vel")
)

input <- input |>
  mutate(
    starts = str_extract_all(pos, "\\d+"),
    velocities = str_extract_all(vel, "-?\\d+")
  )

starts <- input |>
  pull(starts) |>
  map(as.numeric)

velocities <- input |>
  pull(velocities) |>
  map(as.numeric)

dims <- c(101, 103)

# -- Part 1 ------------------------

# What will the safety factor be after exactly 100 seconds have elapsed?

safety_factor <- function(starts, velocities, dims, times) {
  end_pos <- map2(
    starts,
    velocities,
    \(x, y, dims, times) (x + y * times) %% dims,
    dims = dims,
    times = times
  )
  do.call(rbind, end_pos) |>
    as_tibble(.name_repair = "unique") |>
    rename(x = "...1", y = "...2")
}

safety_factor(starts, velocities, dims, times = 100) |>
  mutate(
    quadrant = case_when(
      x < (dims[1] - 1) / 2 & y < (dims[2] - 1) / 2 ~ 1,
      x < (dims[1] - 1) / 2 & y > (dims[2] - 1) / 2 ~ 2,
      x > (dims[1] - 1) / 2 & y < (dims[2] - 1) / 2 ~ 3,
      x > (dims[1] - 1) / 2 & y > (dims[2] - 1) / 2 ~ 4,
    )
  ) |>
  filter(!is.na(quadrant)) |>
  count(quadrant) |>
  pull(n) |>
  prod() |>
  print()

# -- Part 2 ------------------------

# What is the fewest number of seconds that must elapse for the robots to display the Easter egg?

# This part took some looping in batches
second_range <- seq(8000, 8100)

safety_factors <- map(
  second_range,
  ~ safety_factor(starts, velocities, dims, times = .x) |>
    mutate(
      second = .x,
      quadrant = case_when(
        x < (dims[1] - 1) / 2 & y < (dims[2] - 1) / 2 ~ 1,
        x < (dims[1] - 1) / 2 & y > (dims[2] - 1) / 2 ~ 2,
        x > (dims[1] - 1) / 2 & y < (dims[2] - 1) / 2 ~ 3,
        x > (dims[1] - 1) / 2 & y > (dims[2] - 1) / 2 ~ 4,
      )
    )
) |>
  bind_rows()

min_iterations <- safety_factors |>
  group_by(second) |>
  summarise(
    var_x = var(x),
    var_y = var(y)
  ) |>
  arrange(var_x, var_y) |>
  slice_head(n = 1) |>
  pull(second)

print(min_iterations)

safety_factors |>
  filter(second == min_iterations) |>
  ggplot(aes(x = x, y = y)) +
  geom_tile(fill = "white", color = "grey80", size = 0.1) +
  scale_y_reverse() +
  coord_equal() +
  theme_void() +
  theme(
    plot.margin = margin(rep(2, 4), unit = "mm"),
    plot.background = element_rect(
      fill = "#0f0f23",
      color = "transparent"
    )
  )

ggsave(
  here::here("2024", "day_14", "plot_day14_pt2.png"),
  last_plot(),
  height = 5, width = 10, dpi = 300, bg = "transparent"
)
