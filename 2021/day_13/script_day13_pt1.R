library(tidyverse)

input_paper <- read_csv(here::here("2021","day_13","input_day13.txt"), 
                        col_names = c("x","y"), n_max = 1004)
input_folds <- read_delim(here::here("2021","day_13","input_day13.txt"), 
                          delim = "=", 
                          col_names = c("fold_direction", "fold_loc"), 
                          skip = 1005) %>% 
  mutate(fold_direction = str_extract(fold_direction, "[x|y]"))

fold_paper <- function(df, instructions, step = 1) {
  
  dir <- instructions %>% 
    slice(step) %>% 
    pull(fold_direction)
  
  loc <- instructions %>% 
    slice(step) %>% 
    pull(fold_loc)
  
  folded_paper <- df %>% 
    mutate(x = if_else(x <= loc | dir == "y", x, 2 * loc - x),
           y = if_else(y <= loc | dir == "x", y, 2 * loc - y)) %>% 
    distinct(x, y)
  
  return(folded_paper)
  
}

fold_paper(input_paper, input_folds) %>% 
  count() %>% 
  pull(n) %>% 
  print()
