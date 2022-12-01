library(tidyverse)

input <- read_csv(here::here("2022", "day_01", "input_day01.txt"), 
                  col_names = "calories", skip_empty_rows = FALSE)

input |> 
  mutate(empty = ifelse(is.na(calories), 1, 0),
         elf = cumsum(empty)) |> 
  drop_na() |> 
  group_by(elf) |> 
  summarise(total_calories = sum(calories)) |>
  slice_max(total_calories) |> 
  pull(total_calories) |> 
  print()
