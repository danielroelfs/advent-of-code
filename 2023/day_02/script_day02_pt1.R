library(tidyverse)

input <- read_delim(here::here("2023", "day_02", "input_day02.txt"),
  delim = ":", col_names = c("game", "result")
)

input_parsed <- input |>
  mutate(
    result = str_trim(result),
    game = parse_number(game),
    cubes = str_extract_all(result, "\\d+ [a-z]+")
  ) |>
  unnest(cubes) |>
  separate(cubes, c("number", "color"), sep = " ", convert = TRUE)

max_number <- tribble(
  ~color, ~max_value,
  "red", 12,
  "green", 13,
  "blue", 14
)

input_parsed |>
  inner_join(max_number, by = "color") |>
  group_by(game) |>
  filter(!any(number > max_value)) |>
  distinct(game) |>
  pull(game) |>
  sum() |>
  print()
