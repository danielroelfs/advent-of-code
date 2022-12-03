library(tidyverse)

input <- read_table(here::here("2022", "day_03", "input_day03.txt"), 
                    col_names = "rucksack")

priority_values <- tibble(char = c(letters, LETTERS)) |> 
  mutate(priority = seq(n()))

input |> 
  mutate(nitems = nchar(rucksack),
         comp1 = str_sub(rucksack, 1, nitems/2),
         comp2 = str_sub(rucksack, nitems/2 + 1, nitems),
         comp1_regex = map_chr(strsplit(comp1, ""), str_c, collapse = "|"),
         common = str_extract(comp2, comp1_regex)) |> 
  left_join(priority_values, by = c("common" = "char")) |> 
  summarise(sum = sum(priority)) |> 
  pull(sum) |> 
  print()
