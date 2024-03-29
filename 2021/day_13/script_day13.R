### ADVENT OF CODE - DAY 13 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input_paper <- read_csv(here::here("2021","day_13","test_input_day13.txt"), col_names = c("x","y"), n_max = 18)
#input_folds <- read_delim(here::here("2021","day_13","test_input_day13.txt"), delim = "=", col_names = c("fold_direction", "fold_loc"), skip = 19) %>% 
#  mutate(fold_direction = str_extract(fold_direction, "[x|y]"))

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

#-- Part 1 ------------------------

# How many dots are visible after completing just the first fold instruction on your transparent paper?

fold_paper(input_paper, input_folds) %>% 
  count() %>% 
  pull(n) %>% 
  print()

#-- Part 2 ------------------------

# What code do you use to activate the infrared thermal imaging camera system?

reduce(seq(nrow(input_folds)), ~ fold_paper(.x, input_folds, step = .y), 
       .init = input_paper) %>% 
  mutate(dot = "#") %>% 
  ggplot(aes(x = x, y = y)) +
  geom_tile(fill = "#f2f2f2") +
  geom_text(aes(label = dot), color = "#b3b3b3", size = 8) +
  scale_y_reverse() +
  coord_equal() + 
  theme_void() + 
  theme(plot.margin = margin(rep(10,4), unit = "mm"),
        plot.background = element_rect(fill = "#0f0f23"))

ggsave(here::here("2021", "day_13", "plot_day13_pt2.png"), last_plot(), 
       height = 3, width = 8, dpi = 300)

