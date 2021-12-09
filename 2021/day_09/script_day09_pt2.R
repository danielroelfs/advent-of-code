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
