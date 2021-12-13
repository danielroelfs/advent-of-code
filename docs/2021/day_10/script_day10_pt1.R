library(tidyverse)

input <- read_table(here::here("2021","day_10","input_day10.txt"), 
                    col_names = "syntax")

full_patterns <- c("\\(\\)","\\[\\]","\\{\\}","\\<\\>")

symbols <- tibble(symbols = c("(","[","{","<",")","]","}",">"),
                  valid = c(rep(TRUE, 4), rep(FALSE, 4)))

points <- c(")" = 3, "]" = 57, "}" = 1197, ">" = 25137) %>% 
  enframe()

input %>% 
  mutate(nchar = max(nchar(syntax))) %>% 
  mutate(syntax = reduce(seq(nchar), .init = syntax,
                         ~ str_remove_all(.x, str_c(full_patterns, 
                                                    collapse = "|")))) %>% 
  mutate(symbols = str_split(syntax, "")) %>% 
  unnest(symbols) %>%
  group_by(syntax) %>% 
  mutate(position = row_number()) %>% 
  left_join(symbols) %>% 
  filter(!valid) %>% 
  slice_min(position) %>% 
  ungroup() %>% 
  left_join(points, by = c("symbols" = "name")) %>% 
  summarise(total = sum(value)) %>% 
  pull(total) %>% 
  print()
