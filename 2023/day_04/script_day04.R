### ADVENT OF CODE - DAY 4 ########################

# -- Libraries -------------------------

library(tidyverse)

# -- Load data ------------------------

# input <- read_delim(here::here("2023", "day_04", "test_input_day04.txt"),
#  delim = ":",
#  col_names = c("card", "numbers")
# ) |>
#  mutate(numbers = str_trim(numbers))
input <- read_delim(here::here("2023", "day_04", "input_day04.txt"),
  delim = ":",
  col_names = c("card", "numbers")
) |>
  mutate(numbers = str_trim(numbers))

# -- Part 1 ------------------------

# How many points are they worth in total?

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

# -- Part 2 ------------------------

# How many total scratchcards do you end up with?

data_games <- input |>
  separate_wider_delim(
    numbers,
    delim = "|", names = c("winning", "hand")
  ) |>
  mutate(
    across(everything(), str_trim),
    across(everything(), ~ str_extract_all(.x, "\\d+")),
    card = as.numeric(unlist(card)),
    match = map2(winning, hand, intersect),
    n_match = lengths(match)
  ) |>
  rowwise() |>
  mutate(copies = ifelse(n_match > 0, list(card + seq(n_match)), NA)) |>
  ungroup()


cards <- data_games |> pull(card)
collect_scratchcards <- list()
while (!is.null(cards)) {
  collect_scratchcards <- append(collect_scratchcards, list(cards))
  cards <- data_games$copies[cards] |> unlist()
}

print(unlist(collect_scratchcards) |> length())
