library(tidyverse)

input <- read_table(here::here("2022", "day_03", "input_day03.txt"), 
                    col_names = "rucksack")

priority_values <- tibble(char = c(letters, LETTERS)) |> 
  mutate(priority = seq(n()))

input |> 
  mutate(group = rep(seq(unique(n())/3), each = 3)) |> 
  group_by(group) |> 
  summarise(group_items = str_c(rucksack, collapse = "-")) |> 
  separate(group_items, into = c("comp1", "comp2", "comp3")) |> 
  mutate(comp1_regex = map_chr(strsplit(comp1, ""), str_c, collapse = "|"),
         common_12 = str_extract_all(comp2, comp1_regex),
         comp12_regex = map_chr(common_12, str_c, collapse = "|"),
         common_all = str_extract(comp3, comp12_regex)) |> 
  left_join(priority_values, by = c("common_all" = "char")) |> 
  summarise(sum = sum(priority)) |> 
  pull(sum) |> 
  print()
