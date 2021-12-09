library(tidyverse)

commands <- read_table("./2021/day_02/input_day02.txt", 
                       col_names = c("direction","value"))

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
