library(tidyverse)

commands <- read_table("./2021/day_02/input_day02.txt", 
                       col_names = c("direction","value"))

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
