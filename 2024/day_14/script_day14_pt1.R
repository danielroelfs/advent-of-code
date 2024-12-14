library(tidyverse)

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
