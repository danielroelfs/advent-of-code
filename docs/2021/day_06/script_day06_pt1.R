library(tidyverse)

input <- read_csv(here::here("2021", "day_06","input_day06.txt"), 
                  col_names = FALSE) %>% 
  unname() %>% 
  as_vector()

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
