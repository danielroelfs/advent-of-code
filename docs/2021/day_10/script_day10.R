### ADVENT OF CODE - DAY 10 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_table(here::here("2021","day_10","test_input_day10.txt"), col_names = "syntax")
input <- read_table(here::here("2021","day_10","input_day10.txt"), 
                    col_names = "syntax")

full_patterns <- c("\\(\\)", "\\[\\]", "\\{\\}", "\\<\\>")

symbols <- tibble(symbol = c("(", "[", "{", "<", ")", "]", "}", ">"),
                  open = c(rep(TRUE, 4), rep(FALSE, 4)))

#-- Part 1 ------------------------

# Find the first illegal character in each corrupted line of the navigation subsystem. 
# What is the total syntax error score for those errors?

points <- c(")" = 3, "]" = 57, "}" = 1197, ">" = 25137) %>% 
  enframe()

input %>% 
  mutate(nchar = max(nchar(syntax))) %>% 
  mutate(syntax = reduce(seq(nchar), .init = syntax,
                         ~ str_remove_all(.x, str_c(full_patterns, 
                                                    collapse = "|")))) %>% 
  mutate(symbol = str_split(syntax, "")) %>% 
  unnest(symbol) %>%
  group_by(syntax) %>% 
  mutate(position = row_number()) %>% 
  left_join(symbols, by = "symbol") %>% 
  filter(!open) %>% 
  slice_min(position) %>% 
  ungroup() %>% 
  left_join(points, by = c("symbol" = "name")) %>% 
  summarise(total = sum(value)) %>% 
  pull(total) %>% 
  print()

#-- Part 2 ------------------------

# Find the completion string for each incomplete line, score the completion strings, and sort the scores. 
# What is the middle score?

points <- c(")" = 1, "]" = 2, "}" = 3, ">" = 4) %>% 
  enframe()

full_patterns <- c("\\(\\)","\\[\\]","\\{\\}","\\<\\>")

pairs <- tibble(sym_open = c("(","[","{","<"),
                sym_close = c(")","]","}",">"))

calc_score <- function(scores) {
  
  tot_score <- reduce(seq_along(scores), ~ .x * 5 + scores[.y], .init = 0)
  return(tot_score)
  
}

input %>% 
  mutate(nchar = max(nchar(syntax))) %>% 
  mutate(syntax = reduce(seq(nchar), .init = syntax,
                         ~ str_remove_all(.x, str_c(full_patterns, 
                                                    collapse = "|")))) %>% 
  mutate(symbol = str_split(syntax, "")) %>% 
  unnest(symbol) %>%
  group_by(syntax) %>% 
  left_join(symbols, by = "symbol") %>% 
  filter(all(open)) %>% 
  mutate(inv_symbol = rev(symbol)) %>% 
  left_join(pairs, by = c("inv_symbol" = "sym_open")) %>% 
  left_join(points, by = c("sym_close" = "name")) %>% 
  select(syntax, value) %>% 
  nest(score = value) %>% 
  mutate(score = map(score, ~ as_vector(.x)),
         tot_score = map_dbl(score, ~ calc_score(.x))) %>% 
  ungroup() %>% 
  summarise(median_score = median(tot_score)) %>% 
  pull(median_score) %>% 
  print()
