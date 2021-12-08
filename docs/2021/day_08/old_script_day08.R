numbers <- c("1" = 2, "4" = 4, "7" = 3, "8" = 7) %>% 
  enframe() %>% 
  rename(value = name,
         n_chars = value) %>% 
  mutate(value = as.numeric(value))

digit_defs <- read_delim(here::here("2021","day_08","digit_defs.txt"), delim = ":", 
                         col_names = FALSE) %>% 
  rename(segments = X1,
         value = X2) %>% 
  mutate(value = parse_number(value),
         n_segments = nchar(segments),
         segment_ind = str_split(segments, pattern = ""),
         segment_ind = map(segment_ind, ~ str_sort(.x)),
         segment_sort = map_chr(segment_ind, ~ str_c(.x, collapse = ""))) %>%
  arrange(value) %>% 
  select(segment_sort, value)

input %>% 
  select(output = X2) %>% 
  mutate(output = str_trim(output)) %>% 
  separate(output, into = str_glue("digit{seq(4)}")) %>% 
  rowid_to_column("row_no") %>% 
  pivot_longer(cols = starts_with("digit"), names_to = "digit_no", values_to = "segments") %>% 
  mutate(n_chars = nchar(segments),
         segment_ind = str_split(segments, pattern = ""),
         segment_ind = map(segment_ind, ~ str_sort(.x)),
         segment_sort = map_chr(segment_ind, ~ str_c(.x, collapse = ""))) %>% 
  left_join(digit_defs) %>% 
  left_join(numbers, by = "n_chars") %>% 
  janitor::clean_names() %>% 
  mutate(value_comb = coalesce(value_x, value_y)) %>% 
  select(row_no, digit_no, segments, value = value_comb) %>%
  pivot_wider(names_from = digit_no, values_from = value, id_cols = "row_no")
