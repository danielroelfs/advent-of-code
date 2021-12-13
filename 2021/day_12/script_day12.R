### ADVENT OF CODE - DAY 12 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

input <- read_delim(here::here("2021","day_12","test_input_day12.txt"), delim = "-", col_names = c("from","to"))

#-- Part 1 ------------------------

# How many paths through this cave system are there that visit small caves at most once?

input %>% 
  bind_rows(input %>% 
              mutate(tmp = from, 
                     from = to, 
                     to = tmp) %>% 
              select(-tmp))


#-- Part 2 ------------------------

# 


