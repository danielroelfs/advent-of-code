library(tidyverse)

data <- read_table("./2021/day_01/input_day01.txt", col_names = "depth")

data %>% 
  slider::slide(., ~.x, .after = 2, .f = ~sum(.x)) %>% 
  enframe(name = "window_no", value = "depth") %>% 
  unnest(depth) %>% 
  mutate(depth_lag = lag(depth),
         diff = depth - depth_lag,
         diff_bin = diff / abs(diff),
         diff_bin_label = case_when(diff_bin == -1 ~ "Smaller than last",
                                    diff_bin == 1 ~ "Larger than last",
                                    TRUE ~ "No measurement/no difference")) %>% 
  count(diff_bin_label) %>% 
  filter(str_detect(diff_bin_label, "Larger")) %>% 
  pull(n) %>% 
  print()
