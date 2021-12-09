library(tidyverse)

input <- read_table(here::here("2021","day_09","input_day09.txt"), 
                    col_names = FALSE) %>%
  rename(value = X1)

data_long <- input %>% 
  rowid_to_column("row_no") %>% 
  separate_rows(value, sep = "", convert = TRUE) %>% 
  filter(!is.na(value)) %>% 
  group_by(row_no) %>% 
  mutate(col_no = row_number()) %>% 
  ungroup() %>% 
  select(value, row_no, col_no)

tidygraph::create_lattice(c(100, 100)) %>%
  mutate(!!!data_long) %>%
  filter(value != 9) %>%
  mutate(group = tidygraph::group_components()) %>%
  as_tibble() %>%
  count(group, sort = TRUE) %>%
  head(3) %>%
  pull(n) %>%
  prod()
