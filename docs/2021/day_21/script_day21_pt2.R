library(tidyverse)

input <- read_delim(here::here("2021","day_21","input_day21.txt"), delim = ":", 
                    col_names = c("player","start_pos")) %>% 
  mutate(across(everything(), ~ parse_number(.x))) %>% 
  pull(start_pos)

