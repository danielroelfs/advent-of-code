library(tidyverse)

input_numbers <- read_csv("./2021/day_04/input_day04.txt", col_names = FALSE) %>% 
  slice(1) %>% 
  mutate(across(everything(), ~ as.numeric(.x))) %>% 
  as_vector()

boards <- read_table("./2021/day_04/input_day04.txt", skip = 2, 
                     col_names = FALSE, skip_empty_rows = TRUE) %>% 
  rename_with(~ str_glue("col{parse_number(.x)}")) %>% 
  group_by(board_no = ceiling(row_number()/5)) %>% 
  rownames_to_column("row_no")

n_boards <- boards %>%
  ungroup() %>% 
  slice_max(board_no) %>% 
  pull(board_no) %>% 
  unique()

boards_long <- boards %>% 
  pivot_longer(starts_with("col"), names_to = "col_no", values_to = "number") %>% 
  mutate(col_no = parse_number(col_no)) %>% 
  relocate(board_no, .after = last_col())

run_numbers <- function(df, in_number, n_boards = NULL) {
  
  if (any(str_detect(names(df),"final_number"))) {
    return(df)
    stop()
  }
  
  board_filt <- df %>% 
    filter(number != in_number)
  
  n_unique_rows <- board_filt %>% 
    count(row_no) %>% 
    count(board_no) %>% 
    pull(n)
  
  n_unique_cols <- board_filt %>% 
    count(col_no) %>% 
    count(board_no) %>% 
    pull(n)
  
  #print(in_number)
  
  if (sum(n_unique_rows * n_unique_cols) < n_boards * 5 * 5) {
    board_filt <- df %>% 
      mutate(final_number = in_number)
    return(board_filt)
  } else {
    return(board_filt)
  }
  
}

bingo_game <- reduce(input_numbers, ~ run_numbers(.x, .y, n_boards = n_boards), 
                     .init = boards_long)

winning_board <- bingo_game %>% 
  filter(number != final_number) %>% 
  summarise(nrow = length(unique(row_no)),
            ncol = length(unique(col_no))) %>% 
  filter(nrow * ncol < 25) %>% 
  pull(board_no)

bingo_game %>% 
  ungroup() %>% 
  filter(number != final_number,
         board_no == winning_board) %>% 
  summarise(sum_unmarked = sum(number),
            final_number = unique(final_number)) %>% 
  as_vector() %>% 
  prod() %>% 
  print()
