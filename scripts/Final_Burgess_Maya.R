## Maya L Burgess
## Final Fall 2024
## December 9 2024

# 1 Read in the file tyler_activity_laps_12-6.csv from the class github page. This file is at url https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.

library(tidyverse)
library(ggplot2)
library(lubridate)

url <- 'https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv'
laps_tyler <- read_csv(url)


## 2 Filter out any non-running activities. 9039 obs 12 vars

## 3We are interested in normal runningx. You can assume that any lap with a pace above 10 minutes_per_mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute_per_mile pace) and abnormally short records where the total elapsed time is one minute or less.

## 3 Next, Tyler often has to take walk breaks between laps right now because trying to change how you’ve run for 25 years is hard. You can assume that any lap with a pace above 10 minute-per-mile pace is walking, so remove those lap. You should also remove any abnormally fast laps (< 5 minute-per-mile pace) and abnormally short records where the total elapsed time is one minute or less.


running_laps <- laps_tyler %>% 
  filter(sport == 'running') %>%
  filter(total_elapsed_time_s >= 60) %>%
  filter(minutes_per_mile < 10 & minutes_per_mile > 5) %>%
  mutate(pace_cat = case_when(minutes_per_mile < 5 ~ 'fast',
                              minutes_per_mile >=6 & minutes_per_mile < 8 ~ 'medium',
                              T ~ 'slow'),
         form = case_when(year == 2024 ~ 'new form',
                          T ~ 'old form'))



## 4 Group observations into three time periods corresponding to pre-2024 running, Tyler’s initial rehab efforts from January to June of this year, and activities from July to the present.
## I don't remember how to do this??? 

laps_tyler %>%
  mutate(months = ifelse(month %in% 1:12,'pre-2024',
                         'January 2024 to June 2024',
                         'July 2024 to the present' )) %>%
  group_by(months) %>% 
  summarize()

# 5 Make a scatter plot that graphs SPM over speed by lap.
  
ggplot(laps_tyler, aes(x = steps_per_minute, y = total_elapsed_time_s)) +
  geom_point(aes(color = year, alpha = 0.2)) +
    geom_smooth(method = 'lm', color = 'blue', linetype = 'dashed') +
    theme_linedraw() +
  scale_alpha_binned() +
    ggtitle("Tyler's Normal Running") +
    theme(plot.title = element_text(hjust = 0.5)) + 
    xlab("Steps Per Minute") + ylab("Speed by Lap") 
  
# 6 Make 5 aesthetic changes to the plot to improve the visual!!!  
# 7 Add linear (i.e., straight) trendlines to the plot to show the relationship between speed and SPM for each of the three time periods (hint: you might want to check out the options for geom_smooth())

## This looks very strange...but it's a "plot" right? But it makes answering  question 8 below a little difficult because it's not correct. Nor did I have time to get to it if sticking to the 1 hour mark. 
  
# 8 Does this relationship maintain or break down as Tyler gets tired? Focus just on post-intervention runs (after July 1, 2024). Make a plot (of your choosing) that shows SPM vs. speed by lap. Use the timestamp indicator to assign lap numbers, assuming that all laps on a given day correspond to the same run (hint: check out the rank() function). Select only laps 1-3 (Tyler never runs more than three miles these days). Make a plot that shows SPM, speed, and lap number (pick a visualization that you think best shows these three variables).

## Thank you!! 
