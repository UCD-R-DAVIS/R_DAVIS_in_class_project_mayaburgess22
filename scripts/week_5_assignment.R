## Maya Lewis Burgess
## Assignment 5
## October 30, 2024

## 1 Create a tibble named surveys from the portal_data_joined.csv file. 

## 2 Then manipulate surveys to create a new dataframe called surveys_wide with a column for genus and a column named after every plot type, with each of these columns containing the mean hindfoot length of animals in that plot type and genus. 
## 3 So every row has a genus and then a mean hindfoot length value for every plot type. The dataframe should be sorted by values in the Control plot type column.

## 1
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% 
  summarise(mean_hindfoot = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>% 
  arrange(Control)

## 2
summary(surveys$weight)

surveys %>% 
  mutate(weight_cat = case_when(
    weight <= 20.00 ~ "small",
    weight > 20.00 & weight < 48.00 ~ "medium",
    T ~ "large"
  ))

## or try this??? same output

surveys %>% 
  mutate(weight_cat = case_when(
    weight <= 20.00 ~ "small",
    weight > 20.00 & weight < 48.00 ~ "medium",
    weight >= 48.00 ~ "large"
  ))

## or this??? many different ways
surveys %>% 
  mutate(weight_cat = ifelse(weight <= 20.00, "small",
                             ifelse(weight > 20.00 & weight < 48.00, "medium","large")))


## bonus only because it's here...still working through the principles

summ <- summary(surveys$weight)
# Remember our indexing skills from the first weeks? Play around with single and double bracketing to see how it can extract values
summ[[2]]

## and this

summ[[5]]

## Again lost me here. But putting in script for reference. But same output again??

surveys %>% 
  mutate(weight_cat = case_when(
    weight >= summ[[2]] ~ "small",
    weight > summ[[2]] & weight < summ[[5]] ~ "medium",
    weight >= summ[[5]] ~ "large"
  ))
