### ADVENT OF CODE - DAY 7 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_csv(here::here("2021","day_07","test_input_day07.txt"), col_names = FALSE) %>% 
input <- read_csv(here::here("2021","day_07","input_day07.txt"), 
                  col_names = FALSE) %>% 
  unname() %>% 
  as_vector()

#-- Part 1 ------------------------

# Determine the horizontal position that the crabs can align to using the least fuel possible. 
# How much fuel must they spend to align to that position?

# This could have been a one-liner but wanted to calculate every option anyway.
#sum(abs(input - median(input)))

calc_fuel <- function(x, pos) {
  fuel <- tibble(
    position = pos,
    consumption = sum(abs(input - pos))
  ) 
  return(fuel)
}

fuel <- map_dfr(seq(0, max(input)), ~ calc_fuel(input, .x))

fuel %>% 
  slice_min(consumption) %>% 
  pull(consumption) %>% 
  print()

#-- Part 2 ------------------------

# Determine the horizontal position that the crabs can align to using the least fuel possible so they can make you an escape route! 
# How much fuel must they spend to align to that position?

calc_fuel <- function(x, pos) {
  
  consumption <-  abs(input - pos) %>% 
    map_dbl(., ~ sum(seq(.x)))
  
  fuel <- tibble(
    position = pos,
    consumption = sum(consumption)
  ) 
  return(fuel)
}

fuel <- map_dfr(seq(0, max(input)), ~ calc_fuel(input, .x))

fuel %>% 
  slice_min(consumption) %>% 
  pull(consumption) %>% 
  print()
