library(tidyverse)


input <- read_csv(here::here("2021","day_07","input_day07.txt"), 
                  col_names = FALSE) %>% 
  unname() %>% 
  as_vector()

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
