## Maya L Burgess
## Mid Term Fall 2024
## October 30 2024

## 1 Read in the file tyler_activity_laps_10-24.csv from the class github page. This file is at url https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.


library(tidyverse)
url <- 'https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv'
lap_tyler <- read_csv(url)


## 2 Filter out any non-running activities. 6927 obs 14 vars

running_laps <- lap_tyler %>% 
  filter(sport == 'running') %>%
  filter(total_elapsed_time_s >= 60) %>%
  filter(minutes_per_mile < 10 & minutes_per_mile > 5) %>%
  mutate(pace_cat = case_when(minutes_per_mile < 6 ~ 'fast',
                              minutes_per_mile >=6 & minutes_per_mile < 8 ~ 'medium',
                              T ~ 'slow'),
         form = case_when(year == 2024 ~ 'new form',
                          T ~ 'old form'))

## ??? WHAT IS PACE_CAT again? 

## 3 Next, Tyler often has to take walk breaks between laps right now because trying to change how you’ve run for 25 years is hard. You can assume that any lap with a pace above 10 minute-per-mile pace is walking, so remove those lap. You should also remove any abnormally fast laps (< 5 minute-per-mile pace) and abnormally short records where the total elapsed time is one minute or less.

## and 4

## Create a new categorical variable, pace, that categorizes laps by pace: “fast” (< 6 minutes-per-mile), “medium” (6:00 to 8:00), and “slow” ( > 8:00). Create a second categorical variable, form that distinguishes between laps run in the year 2024 (“new”, as Tyler started his rehab in January 2024) and all prior years (“old”).

## and 5????

## 5 Identify the average steps per minute for laps by form and pace, and generate a table showing these values with old and new as separate rows and pace categories as columns. Make sure that slow speed is the second column, medium speed is the third column, and fast speed is the fourth column (hint: think about what the select() function does).

## ???? ew messy this all does this??? 


running_laps %>% group_by(form,pace_cat) %>% 
  summarize(avg_spm = mean(steps_per_minute)) %>%
  pivot_wider(id_cols = form,values_from = avg_spm,names_from = pace_cat) %>%
  select(form,slow,medium,fast)


## 6 Finally, Tyler thinks he’s been doing better since July after the doctors filmed him running again and provided new advice. Summarize the minimum, mean, median, and maximum steps per minute results for all laps (regardless of pace category) run between January - June 2024 and July - October 2024 for comparison.

running_laps %>% filter(form == 'new form') %>%
    mutate(months = ifelse(month %in% 1:6,'early 2024','late 2024')) %>%
    group_by(months) %>% 
    summarize(
      min_spm = min(steps_per_minute),
      median_spm = median(steps_per_minute),
      mean_spm = mean(steps_per_minute),
      max_spm = max(steps_per_minute))
  