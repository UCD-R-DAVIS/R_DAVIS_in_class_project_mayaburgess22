library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")


# To get the population difference between 2002 and 2007 for each country, it would probably be easiest to have a country in each row and a column for 2002 population and a column for 2007 population.

# Notice the order of countries within each facet. You’ll have to look up how to order them in this way.

# Also look at how the axes are different for each facet. Try looking through ?facet_wrap to see if you can figure this one out.

pg <- gapminder %>% 
  select(country, year, pop, continent) %>% 
  filter(year > 2000) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% 
  mutate(pop_change_0207 = `2007` - `2002`)

# The color scale is different from the default- feel free to try out other color scales, just don’t use the defaults!
## ??can't figure out how to make the country names clear or smaller???


#The axis labels are rotated! Here’s a hint: angle = 45, hjust = 1. It’s up to you (and Google) to figure out where this code goes!

pg %>% 
  filter(continent != "Oceania") %>% 
  ggplot(aes(x = reorder(country, pop_change_0207), y = pop_change_0207)) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~continent, scales = "free" ) +
  theme_get() +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle = 80, hjust = .9, size = 3.5, color = "black"), 
        legend.position = "right") +
  xlab("Country") +
  ylab("Change in Population Between 
       2002 and 2007")
