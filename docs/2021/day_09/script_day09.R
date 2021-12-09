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

directions <- tribble(
  ~direction, ~d_x, ~d_y,
  "right", 1, 0,
  "left", -1, 0,
  "bottom", 0, 1,
  "top", 0, -1
)

full_table_w_neighbors <- data_long %>% 
  inner_join(directions, by = character()) %>% 
  mutate(nb_x = row_no + d_x, nb_y = col_no + d_y) %>% 
  left_join(data_long, by = c("nb_x" = "row_no", "nb_y" = "col_no")) %>% 
  rename(value = value.x, 
         nb_value = value.y)

basin_edges <- full_table_w_neighbors %>% 
  filter(value != 9 & nb_value != 9 & !is.na(nb_value)) %>% 
  mutate(from = str_glue("{row_no};{col_no}"), to = str_glue("{nb_x};{nb_y}"))

graph_edges_for_igraph <- map2(basin_edges$from, basin_edges$to, ~ c(.x, .y)) %>% 
  unlist()
graph <- igraph::make_graph(graph_edges_for_igraph, directed = FALSE)

comps <- igraph::components(graph)
basin_sizes <- comps$csize

basin_sizes %>% 
  sort(decreasing = TRUE) %>% 
  head(3) %>% 
  prod() %>% 
  print()
