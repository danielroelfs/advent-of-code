library(tidyverse)

input <- read_table(here::here("2021","day_10","input_day10.txt"), 
                    col_names = "syntax")

full_patterns <- c("\\(\\)","\\[\\]","\\{\\}","\\<\\>")

symbols <- tibble(symbols = c("(","[","{","<",")","]","}",">"),
                  valid = c(rep(TRUE, 4), rep(FALSE, 4)))

points <- c(")" = 1, "]" = 2, "}" = 3, ">" = 4) %>% 
  enframe()

full_patterns <- c("\\(\\)","\\[\\]","\\{\\}","\\<\\>")

pairs <- tibble(open = c("(","[","{","<"),
                close = c(")","]","}",">"))

calc_score <- function(scores) {
  
  tot_score <- reduce(seq_along(scores), ~ .x * 5 + scores[.y], .init = 0)
  return(tot_score)
  
}

input %>% 
  mutate(syntax = reduce(seq(100), .init = syntax,
                         ~ str_remove_all(.x, str_c(full_patterns, 
                                                    collapse = "|")))) %>% 
  mutate(symbols = str_split(syntax, "")) %>% 
  unnest(symbols) %>%
  group_by(syntax) %>% 
  left_join(symbols) %>% 
  filter(all(valid)) %>% 
  mutate(inv_symbols = rev(symbols)) %>% 
  left_join(pairs, by = c("inv_symbols" = "open")) %>% 
  mutate(close_syntax = str_c(close, collapse = "")) %>% 
  left_join(points, by = c("close" = "name")) %>% 
  select(syntax,value) %>% 
  nest(scores = value) %>% 
  mutate(scores = map(scores, ~ as_vector(.x)),
         tot_score = map_dbl(scores, ~ calc_score(.x))) %>% 
  ungroup() %>% 
  summarise(median_score = median(tot_score)) %>% 
  pull(median_score) %>% 
  print()
