### ADVENT OF CODE - DAY 4 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_table(here::here("2022", "day_04", "test_input_day04.txt"), 
#                    col_names = "pairs")
input <- read_table(here::here("2022", "day_04", "input_day04.txt"), 
                    col_names = "pairs")

#-- Part 1 ------------------------

# In how many assignment pairs does one range fully contain the other?

input |> 
  separate(pairs, sep = ",|\\-", into = c("section1_start","section1_end", 
                                      "section2_start", "section2_end")) |> 
  mutate(across(everything(), ~ as.numeric(.x)),
         overlap_1_2 = section1_start >= section2_start & 
           section1_end <= section2_end,
         overlap_2_1 = section2_start >= section1_start & 
           section2_end <= section1_end) |> 
  filter(overlap_1_2 | overlap_2_1) |>
  nrow() |> 
  print()

#-- Part 2 ------------------------

# In how many assignment pairs do the ranges overlap?

input |> 
  separate(pairs, sep = ",|\\-", into = c("section1_start","section1_end", 
                                      "section2_start", "section2_end")) |> 
  mutate(across(everything(), ~ as.numeric(.x)),
         section1 = map2(section1_start, section1_end, ~seq(.x,.y)),
         section2 = map2(section2_start, section2_end, ~seq(.x,.y)),
         intersect = map2(section1, section2, ~ intersect(.x, .y)),
         n_overlapping = lengths(intersect)) |>
  filter(n_overlapping > 0) |> 
  nrow() |> 
  print()
