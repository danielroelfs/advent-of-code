library(tidyverse)

input <- read_delim(here::here("2023", "day_04", "input_day04.txt"),
  delim = ":",
  col_names = c("card", "numbers")
) |>
  mutate(numbers = str_trim(numbers))

input |>
  separate_wider_delim(
    numbers,
    delim = "|", names = c("winning", "hand")
  ) |>
  mutate(
    across(everything(), str_trim),
    across(everything(), ~ str_extract_all(.x, "\\d+")),
    match = map2(winning, hand, intersect),
    n_match = lengths(match)
  ) |>
  filter(n_match > 0) |>
  summarise(
    points = sum(2^(n_match - 1))
  ) |>
  pull(points) |>
  print()
