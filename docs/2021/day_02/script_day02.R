### ADVENT OF CODE - DAY 2 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#commands <- read_table("./2021/day_02/test_input_day02.txt", col_names = c("direction", "value"))
commands <- read_table("./2021/day_02/input_day02.txt", 
                       col_names = c("direction","value"))

#-- Part 1 ------------------------

# What do you get if you multiply your final horizontal position by your final depth?

final_position <- commands %>% 
  mutate(value_bin = case_when(direction == "up" ~ value * -1,
                               TRUE ~ value),
         direction_bin = case_when(direction == "forward" ~ "x",
                                   TRUE ~ "y")) %>% 
  group_by(direction_bin) %>% 
  summarise(pos = sum(value_bin)) %>% 
  ungroup()

final_position %>% 
  summarise(mult = prod(pos)) %>% 
  pull(mult) %>% 
  print()

#-- Part 2 ------------------------

# What do you get if you multiply your final horizontal position by your final depth?

aim <- depth <- 0
for (i in seq(nrow(commands))) {
  
  t_direction <- commands %>% 
    slice(i) %>% 
    pull(direction)
  t_value <- commands %>% 
    slice(i) %>% 
    pull(value)
  
  if (t_direction == "forward") {
    depth <- depth + (aim * t_value)
  } else if (t_direction == "down") {
    aim <- aim + t_value
  } else if (t_direction == "up") {
    aim <- aim - t_value
  }
  
}

final_position %>% 
  filter(direction_bin == "x") %>% 
  pull(pos) %>% 
  prod(., depth) %>% 
  print()





