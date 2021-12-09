### ADVENT OF CODE - DAY 9 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_table(here::here("2021","day_09","test_input_day09.txt"), col_names = FALSE) %>%
input <- read_table(here::here("2021","day_09","input_day09.txt"), 
                    col_names = FALSE) %>%
  rename(value = X1)

#-- Part 1 ------------------------

# What is the sum of the risk levels of all low points on your heightmap?

full_table <- input %>% 
  separate(value, into = str_glue("coord{seq(0,10)}"), sep = "") %>% 
  mutate(across(everything(), ~ as.numeric(.x))) %>% 
  rowid_to_column("row_no") %>% 
  add_row(tibble(row_no = c(0, nrow(.) + 1))) %>% 
  mutate(across(everything(), ~ replace_na(.x, Inf)),
         coord_last = Inf) %>% 
  arrange(row_no)

row_wise_table <- full_table %>% 
  pivot_longer(starts_with("coord"), names_to = "column_no") %>% 
  group_by(column_no) %>% 
  mutate(lag_value = lag(value),
         lead_value = lead(value),
         low_point_row = ifelse(value < lag_value & value < lead_value, 
                                yes = TRUE, no = FALSE)) %>%
  select(row_no, column_no, value, low_point_row)

col_wise_table <- full_table %>% 
  pivot_longer(starts_with("coord"), names_to = "column_no") %>% 
  group_by(row_no) %>% 
  mutate(lag_value = lag(value),
         lead_value = lead(value),
         low_point_col = ifelse(value < lag_value & value < lead_value, 
                                yes = TRUE, no = FALSE)) %>% 
  select(row_no, column_no, value, low_point_col)


inner_join(col_wise_table, row_wise_table) %>%
  filter(low_point_col, low_point_row) %>% 
  ungroup() %>% 
  mutate(value = value + 1) %>% 
  summarise(sum = sum(value)) %>% 
  pull(sum) %>% 
  print()

#-- Part 2 ------------------------

# What do you get if you multiply together the sizes of the three largest basins?

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
