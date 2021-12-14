### ADVENT OF CODE - DAY 14 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input_sequence <- read_lines(here::here("2021","day_14","test_input_day14.txt"), n_max = 1)
#input_rules <- read_delim(here::here("2021","day_14","test_input_day14.txt"), delim = "->", 
#                          skip = 2, col_names = c("pair","insert")) %>% 
#  mutate(across(everything(), ~ str_trim(.x)))

input_sequence <- read_lines(here::here("2021","day_14","input_day14.txt"), 
                             n_max = 1)
input_rules <- read_delim(here::here("2021","day_14","input_day14.txt"), 
                          delim = "->",  skip = 2, 
                          col_names = c("pair","insert")) %>% 
  mutate(across(everything(), ~ str_trim(.x)))

rules <- input_rules %>% 
  mutate(pair_chars = str_split(pair, "")) %>% 
  unnest_wider(pair_chars, names_sep = "") %>% 
  mutate(new_pair1 = str_glue("{pair_chars1}{insert}"), 
         new_pair2 = str_glue("{insert}{pair_chars2}")) %>% 
  rowwise() %>% 
  mutate(new_pair = list(c(new_pair1, new_pair2))) %>% 
  select(pair, new_pair) %>% 
  ungroup()

pairs_from_string <- function(string) {
  ind_chars <- str_split(string, "") %>% 
    unlist()
  pairs <- head(str_glue("{ind_chars}{lead(ind_chars)}"), -1)
  return(pairs)
}

initial_pair_frequencies <- input_sequence %>% 
  pairs_from_string() %>% 
  as_tibble() %>% 
  rename(pair = value) %>% 
  count(pair, name = "freq")

apply_rules <- function(df) {
  
  out <- df %>% 
    inner_join(rules, by = "pair") %>% 
    unnest_longer(new_pair) %>% 
    group_by(new_pair) %>% 
    summarize(freq = sum(freq)) %>% 
    rename(pair = new_pair)
  return(out)
  
}

#-- Part 1 ------------------------

# Apply 10 steps of pair insertion to the polymer template and find the most and least common elements in the result. 
# What do you get if you take the quantity of the most common element and subtract the quantity of the least common element?

reduce(seq(10), ~ apply_rules(.x), .init = initial_pair_frequencies) %>% 
  separate_rows(pair, sep = "") %>% 
  filter(pair != "") %>% 
  group_by(pair) %>% 
  summarise(freq = ceiling(sum(freq) / 2)) %>% 
  ungroup() %>% 
  summarise(diff = max(freq) - min(freq)) %>% 
  pull(diff) %>% 
  print()

#-- Part 2 ------------------------

# Apply 40 steps of pair insertion to the polymer template and find the most and least common elements in the result. 
# What do you get if you take the quantity of the most common element and subtract the quantity of the least common element?

options(scipen = 999)

reduce(seq(40), ~ apply_rules(.x), .init = initial_pair_frequencies) %>% 
  separate_rows(pair, sep = "") %>% 
  filter(pair != "") %>% 
  group_by(pair) %>% 
  summarise(freq = ceiling(sum(freq) / 2)) %>% 
  ungroup() %>% 
  summarise(diff = max(freq) - min(freq)) %>% 
  pull(diff) %>% 
  print()
