### ADVENT OF CODE - DAY 6 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_csv(here::here("2021", "day_06","test_input_day06.txt"), col_names = FALSE) %>% 
input <- read_csv(here::here("2021", "day_06","input_day06.txt"), 
                  col_names = FALSE) %>% 
  unname() %>% 
  as_vector()

#-- Part 1 ------------------------

# Find a way to simulate lanternfish. How many lanternfish would there be after 80 days?

n_days <- 80

gen_fish <- function(x, day) {
  
  n_new <- sum(x == 0)
  new_fish <- rep(8,n_new)
  
  old_fish_repl <- replace(x - 1, x - 1 < 0, 6)
  
  new_fish_vector = c(old_fish_repl, new_fish)
  
  n_fish <- length(new_fish_vector)
  
  #print(str_glue("Day {day}: {n_fish} fish"))
  
  return(new_fish_vector)
  
}

final_fish_vector <- reduce(seq(n_days), ~ gen_fish(.x, .y), .init = input)

print(length(final_fish_vector))

#-- Part 2 ------------------------

# How many lanternfish would there be after 256 days?

data <- tabulate(input, nbins = 8) %>% 
  c(0, .) %>% 
  as_tibble() %>% 
  rename(n = value) %>% 
  mutate(value = row_number() - 1) %>% 
  relocate(value, .before = 1)

get_fish_count <- function(x) {
  
  data_out <- x %>% 
    select(-n) %>% 
    full_join(x %>% mutate(value = value - 1), by = "value") %>% 
    mutate(n = replace_na(n, 0))
  
  data_out$n[data_out$value == 6] <- data_out %>% 
    filter(value %in% c(-1,6)) %>% 
    pull(n) %>% 
    sum()
  
  data_out$n[data_out$value == 8] <- data_out %>%
    filter(value == -1) %>% 
    pull(n)
  
  data_out <- data_out %>% filter(value >= 0)
  
  return(data_out)
}

final_fish_count <- reduce(seq(256), ~ get_fish_count(.x), .init = data)

options(scipen = 999)
final_fish_count %>% 
  summarise(total_fish = sum(n)) %>% 
  pull(total_fish) %>% 
  print()

