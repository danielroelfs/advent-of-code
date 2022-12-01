### ADVENT OF CODE - DAY 1 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_table(here::here("2022", "day_01", "test_input_day01.txt"), col_names = "calories", skip_empty_rows = FALSE)
input <- read_csv(here::here("2022", "day_01", "input_day01.txt"), 
                  col_names = "calories", skip_empty_rows = FALSE)

#-- Part 1 ------------------------

# How many Calories is the Elf carrying the most Calories carrying?

input |> 
  mutate(empty = ifelse(is.na(calories), 1, 0),
         elf = cumsum(empty)) |> 
  drop_na() |> 
  group_by(elf) |> 
  summarise(total_calories = sum(calories)) |>
  slice_max(total_calories) |> 
  pull(total_calories) |> 
  print()

#-- Part 2 ------------------------

# How many calories are carried by the Elves carrying the top 3 most calories?

input |> 
  mutate(empty = ifelse(is.na(calories), 1, 0),
         elf = cumsum(empty)) |> 
  drop_na() |> 
  group_by(elf) |> 
  summarise(total_calories = sum(calories)) |>
  slice_max(total_calories, n = 3) |> 
  summarise(total_calories = sum(total_calories)) |> 
  pull(total_calories) |> 
  print()

