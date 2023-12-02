### ADVENT OF CODE - DAY 2 ########################

# -- Libraries -------------------------

library(tidyverse)

# -- Load data ------------------------

# input <- read_delim(here::here("2023", "day_02", "test_input_day02.txt"),
#  delim = ":", col_names = c("game", "result")
# )
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

# -- Part 1 ------------------------

# Determine which games would have been possible if the bag had been loaded
# with only 12 red cubes, 13 green cubes, and 14 blue cubes.
# What is the sum of the IDs of those games?

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

# -- Part 2 ------------------------

# For each game, find the minimum set of cubes that must have been present.
# What is the sum of the power of these sets?

input_parsed |>
  inner_join(max_number, by = "color") |>
  group_by(game, color) |>
  summarise(number = max(number)) |>
  summarise(power = prod(number)) |>
  pull(power) |>
  sum() |>
  print()
