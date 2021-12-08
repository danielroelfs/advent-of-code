### ADVENT OF CODE - DAY 5 ########################

#-- Libraries -------------------------

library(tidyverse)
library(showtext)

#-- Load data ------------------------

#input <- read_csv(here::here("2021", "day_05","test_input_day05.txt"), col_names = FALSE) %>% 
input <- read_csv(here::here("2021", "day_05","input_day05.txt"), 
                  col_names = FALSE) %>% 
  rename(x1 = X1,
         y2 = X3) %>% 
  separate(X2, into = c("y1","x2")) %>% 
  mutate(across(everything(), ~ as.numeric(.x)))

font_add_google("Josefin Sans", family = "google")
showtext_auto()

#-- Part 1 ------------------------

# Consider only horizontal and vertical lines. At how many points do at least two lines overlap?

input %>% 
  filter(x1 == x2 | y1 == y2) %>% 
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

input %>% 
  filter(x1 == x2 | y1 == y2) %>% 
  rowid_to_column("segment_no") %>% 
  ggplot() +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2, color = segment_no),
               size = 1.5, alpha = 0.6, lineend = "round") + 
  labs(title = "**Advent of Code - Day 5**",
       color = "**Hydrothermal vent n<sup>o</sup>**") +
  scico::scale_color_scico(palette = "batlow", breaks = c(1,seq(100,nrow(input), 100)), 
                           guide = guide_colorbar(title.position = "top", title.hjust = 0.5, 
                                                  barwidth = 10, barheight = 0.75, ticks = FALSE)) +
  scale_y_reverse() +
  theme_void() + 
  theme(text = element_text(family = "google", color = "grey90", size = 8),
        plot.title = ggtext::element_markdown(hjust = 0.5, size = 28,
                                              margin = margin(rep(5,4), unit = "pt")),
        legend.title = ggtext::element_markdown(size = 12, margin = margin(b = -2, unit = "pt")),
        legend.text = element_text(margin = margin(t = -2, "pt")),
        legend.position = "bottom",
        plot.margin = margin(rep(10,4), unit = "mm"),
        plot.background = element_rect(fill = "#0f0f23"))

ggsave(here::here("2021", "day_05", "plot_day05.png"), last_plot(), 
       height = 6, width = 8, dpi = 300)

#-- Part 2 ------------------------

# Consider all of the lines. At how many points do at least two lines overlap?

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

