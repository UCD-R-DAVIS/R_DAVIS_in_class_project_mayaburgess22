## Maya Burgess
## Assignment 8
## November 20, 2024

##read the CSV directly from the R-DAVIS Github: mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

## Use the README file associated with the Mauna Loa dataset to determine in what time zone the data are reported:
## The sample collection date and time in UTC
## and how missing values are reported in each column. 
## With the mloa data.frame, remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s. Generate a column called “datetime” using the year, month, day, hour24, and min columns. Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()). 

## Then to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()). Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.


library(tidyverse)
library(ggplot2)
library(tidyselect)
library(lubridate)


mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

mloa2 = mloa %>%
  # Remove NA's
  filter(rel_humid != -99) %>%
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -999.9) %>%
  # Create datetime column (README indicates time is in UTC)
  mutate(datetime = ymd_hm(paste0(year,"-", 
                                  month, "-", 
                                  day," ", 
                                  hour24, ":", 
                                  min), 
                           tz = "UTC")) %>%
  # Convert to local time
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu"))

##plot (ish) - needed a lot of help here. Thank you!!
mloa2 %>%
  mutate(localMon = month(datetimeLocal, label = TRUE),
         localHour = hour(datetimeLocal)) %>%
  group_by(localMon, localHour) %>%
  summarize(meantemp = mean(temp_C_2m)) %>%
  # Plot
  ggplot(aes(x = localMon,
             y = meantemp)) +
  geom_point(aes(col = localHour)) +
  # Use a nice color ramp - I tried them all and I like this one best, sorry!
  scale_color_viridis_c() +
  xlab("Month") +
  ylab("Mean temperature (degrees C)") +
  theme_light()
