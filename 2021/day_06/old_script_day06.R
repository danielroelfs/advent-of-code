### ADVENT OF CODE - DAY 6 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

input <- read_csv("day_06/test_input_day06.txt", col_names = FALSE) %>% 
  #input <- read_csv("day_06/input_day06.txt", col_names = FALSE) %>% 
  unname() %>% 
  as_vector()


#-- Part 1 ------------------------

# Find a way to simulate lanternfish. How many lanternfish would there be after 80 days?

n_days <- 80

data <- tibble(day = 0, fish = list(input), n_fish = length(input))

gen_fish <- function(x, day) {
  
  print(str_glue("Day: {day}"))
  
  old_fish <- x %>% 
    slice_tail(n = 1) %>% 
    pull(fish) %>% 
    unlist()
  
  n_new <- x %>% 
    slice_tail(n = 1) %>% 
    mutate(n_end = map_dbl(fish, ~ sum(.x == 0))) %>% 
    pull(n_end)
  
  new_fish <- rep(8,n_new)
  
  old_fish_repl <- replace(old_fish - 1, old_fish - 1 < 0, 6)
  
  new_data_row <- tibble(
    day = day,
    fish = list(c(old_fish_repl, new_fish)),
    n_fish = length(c(old_fish_repl, new_fish))
  )
  
  x <- x %>% 
    add_row(new_data_row)
  
  n_fish <- x %>% 
    slice_tail(n = 1) %>% 
    pull(n_fish)
  
  print(str_glue("Day {day}: {n_fish} fish"))
  
  return(x %>% slice_tail(n = 1))
  
}

fish_simulation <- reduce(seq(n_days), ~ gen_fish(.x, .y), .init = data)

fish_simulation %>% 
  slice_tail(n = 1) %>% 
  pull(n_fish)


#-- Part 2 ------------------------

# How many lanternfish would there be after 256 days?

n_days <- 256

fish_simulation <- reduce(seq(n_days), ~ gen_fish(.x, .y), .init = data)

