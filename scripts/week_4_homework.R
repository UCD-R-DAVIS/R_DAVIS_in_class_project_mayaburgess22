# Maya Lewis Burgess
# R Davis Homework Assignment 4
# October 21 2024

## Full disclosure I am still using the notes to help me get 
## through the assignments.


## Create a tibble (this is another word for data frame) 
## named surveys from the portal_data_joined.csv file.

## this creates the data frame from the CSV file
surveys <- read.csv("data/portal_data_joined.csv")

## this creates/sources the "package" for piping

library(tidyverse)


##Subset surveys using Tidyverse methods (pipe) to keep rows with weight between
## 30 and 60, and print out the first 6 rows.

surveys %>% filter(weight > 30 & weight < 60)
## not sure I see the 'printing' part?? 

##Create a new tibble (this is another subset DATA FRAME) showing the maximum
## weight for each species + sex combination and name it biggest_critters. 
## Sort the tibble to take a look at the biggest and smallest species + sex 
## combinations. 
## HINT: it’s easier to calculate max if there are no NAs in the dataframe…
## that's where the filter comes in.

biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarise(max_weight = max(weight))

biggest_critters %>% arrange(max_weight)

##Try to figure out where the NA weights are concentrated in the data- 
## is there a particular species, taxa, plot, or whatever, where there
## are lots of NA values? Not sure...kind of lost me here.
## There isn’t necessarily a right or wrong answer here, but 
## manipulate surveys a few different ways to explore this. 
## Maybe use tally and arrange here.???


surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally() %>% 
  arrange(desc(n))


##Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight.

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n))


##Take surveys_avg_weight and add a new column called above_average 
## that contains logical values stating whether or not a row’s weight 
## is above average for its species+sex combination 
## (recall the new column we made for this tibble). 
## ?? Discuss this in office hours??


surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species_id, sex, weight, avg_weight)

surveys_avg_weight

## or

surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight > avg_weight)

surveys_avg_weight


.__C__.environment
