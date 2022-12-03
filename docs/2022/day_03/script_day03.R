### ADVENT OF CODE - DAY 3 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_table(here::here("2022", "day_03", "test_input_day03.txt"), 
#                    col_names = "rucksack")
input <- read_table(here::here("2022", "day_03", "input_day03.txt"), 
                    col_names = "rucksack")

priority_values <- tibble(char = c(letters, LETTERS)) |> 
  mutate(priority = seq(n()))

#-- Part 1 ------------------------

# Find the item type that appears in both compartments of each rucksack. 
# What is the sum of the priorities of those item types?

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

#-- Part 2 ------------------------

# Find the item type that corresponds to the badges of each three-Elf group. 
# What is the sum of the priorities of those item types?

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


