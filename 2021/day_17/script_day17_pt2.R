library(tidyverse)

input <- read_lines(here::here("2021","day_17","input_day17.txt")) %>% 
  str_extract_all("-?[0-9]+", simplify = TRUE) %>% 
  as.numeric() %>% 
  tibble(value = .) %>% 
  mutate(pos = c('xmin', 'xmax', 'ymin', 'ymax')) %>% 
  pivot_wider(names_from = pos, values_from = value)

positions <- crossing(vx = seq(0, input[["xmax"]]), 
                      vy = seq(input[["ymin"]], 250), 
                      s = seq(0, 500)) %>%
  mutate(dx = pmax(vx - s, 0),
         dy = vy - s) %>% 
  group_by(vx, vy) %>% 
  mutate(x = cumsum(dx),
         y = cumsum(dy)) %>% 
  ungroup()

positions %>%
  filter(x >= input[["xmin"]] & x <= input[["xmax"]] & 
           y >= input[["ymin"]] & y <= input[["ymax"]]) %>%
  distinct(vx, vy) %>% 
  count() %>% 
  pull(n) %>% 
  print()
