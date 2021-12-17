library(tidyverse)

input <- read_lines(here::here("2021","day_17","input_day17.txt")) %>% 
  str_extract_all("-?[0-9]+", simplify = TRUE) %>% 
  as.numeric() %>% 
  tibble(value = .) %>% 
  mutate(pos = c('xmin', 'xmax', 'ymin', 'ymax')) %>% 
  pivot_wider(names_from = pos, values_from = value)

input %>% 
  mutate(ylim = (abs(ymin) - 1) * abs(ymin) / 2) %>% 
  pull(ylim) %>% 
  print()
