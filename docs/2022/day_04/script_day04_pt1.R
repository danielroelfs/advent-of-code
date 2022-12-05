library(tidyverse)

input <- read_table(here::here("2022", "day_04", "input_day04.txt"), 
                    col_names = "pairs")

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
