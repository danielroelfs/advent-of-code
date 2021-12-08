library(tidyverse)


input <- read_delim(here::here("2021","day_08","input_day08.txt"), delim = "|", 
                    col_names = FALSE)

numbers <- c("1" = 2, "4" = 4, "7" = 3, "8" = 7)

input %>% 
  select(output = X2) %>% 
  mutate(output = str_trim(output)) %>% 
  separate(output, into = str_glue("digit{seq(4)}")) %>% 
  mutate(across(everything(), ~ nchar(.x))) %>% 
  pivot_longer(cols = everything(), names_to = "digit", 
               values_to = "n_segments") %>% 
  filter(n_segments %in% numbers) %>% 
  nrow() %>% 
  print()
