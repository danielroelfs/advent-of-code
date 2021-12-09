library(tidyverse)


input <- read_table(here::here("2021","day_09","input_day09.txt"), 
                    col_names = FALSE) %>%
  rename(value = X1)

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
