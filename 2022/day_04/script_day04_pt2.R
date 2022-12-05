library(tidyverse)

input <- read_table(here::here("2022", "day_04", "input_day04.txt"), 
                    col_names = "pairs")

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
