### ADVENT OF CODE - DAY 17 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_lines(here::here("2021","day_17","test_input_day17.txt")) %>% 
#  str_extract_all("-?[0-9]+", simplify = TRUE) %>% 
#  as.numeric() %>% 
#  enframe() %>% 
#  mutate(pos = c('xmin', 'xmax', 'ymin', 'ymax'))

input <- read_lines(here::here("2021","day_17","input_day17.txt")) %>% 
  str_extract_all("-?[0-9]+", simplify = TRUE) %>% 
  as.numeric() %>% 
  tibble(value = .) %>% 
  mutate(pos = c('xmin', 'xmax', 'ymin', 'ymax')) %>% 
  pivot_wider(names_from = pos, values_from = value)

#-- Part 1 ------------------------

# What is the highest y position it reaches on this trajectory?

input %>% 
  mutate(ylim = (abs(ymin) - 1) * abs(ymin) / 2) %>% 
  pull(ylim) %>% 
  print()

#-- Part 2 ------------------------

# How many distinct initial velocity values cause the probe to be within the target area after any step?

positions <- crossing(vx = seq(0, input[["xmax"]]), 
                      vy = seq(input[["ymin"]], 250), 
                      s = seq(0, 500)) %>%
  mutate(dx = pmax(vx - s, 0),
         dy = vy - s) %>% 
  group_by(vx, vy) %>% 
  mutate(x = cumsum(dx),
         y = cumsum(dy)) %>% 
  ungroup()

positions %>%
  filter(x >= input[["xmin"]] & x <= input[["xmax"]] & 
           y >= input[["ymin"]] & y <= input[["ymax"]]) %>%
  distinct(vx, vy) %>% 
  count() %>% 
  pull(n) %>% 
  print()
