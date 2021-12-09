library(tidyverse)
library(showtext)

input <- read_csv(here::here("2021", "day_05","input_day05.txt"), 
                  col_names = FALSE) %>% 
  rename(x1 = X1,
         y2 = X3) %>% 
  separate(X2, into = c("y1","x2")) %>% 
  mutate(across(everything(), ~ as.numeric(.x)))

font_add_google("Josefin Sans", family = "google")
showtext_auto()

input %>% 
  rowid_to_column("segment_no") %>% 
  mutate(x_steps = map2(x1, x2, .f = seq),
         y_steps = map2(y1, y2, .f = seq)) %>% 
  select(segment_no, x_steps, y_steps) %>% 
  unnest(c(x_steps, y_steps)) %>% 
  count(x_steps, y_steps) %>% 
  count(overlapping_segments = n > 1) %>% 
  filter(overlapping_segments) %>% 
  pull(n) %>% 
  print()
