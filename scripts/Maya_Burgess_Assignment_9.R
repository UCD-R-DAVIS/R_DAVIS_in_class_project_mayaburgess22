## Maya L Burgess
## Assignment 9
## December 3, 2024
## Thank you for all your patience. 


## In this assignment, you’ll attempt to use the iteration skills we built in the course to apply functions to an entire dataset.

##Let’s load the surveys dataset:
library(tidyverse)
library(ggplot2)
library(tidyselect)
library(lubridate)
  
surveys <- read.csv("data/portal_data_joined.csv")


## Using a for loop, print to the console the longest species name of each taxon. Hint: the function nchar() gets you the number of characters in a string.

#part 1
for(i in unique(surveys$taxa)){
  mytaxon <- surveys[surveys$taxa == i,]
  longestnames <- mytaxon[nchar(mytaxon$species) == max(nchar(mytaxon$species)),] %>% select(species)
  print(paste0("The longest species name(s) among ", i, "s is/are: "))
  print(unique(longestnames$species))
}


## Next let’s load the Mauna Loa dataset from last week.

mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

## Part 2 - Use the map function from purrr to print the max of each of the following columns: “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”.

### how do you print? Is that just another command for 'see'?
## What do you mean here???


#part 2
mycols <- mloa %>% select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")
mycols %>% map(max, na.rm = T)


## Part 3 - Make a function called C_to_F that converts Celsius to Fahrenheit. Hint: first you need to multiply the Celsius temperature by 1.8, then add 32. Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”. Bonus: can you do this by using map_df? Don’t forget to name your new columns “temp_F…” and not “temp_C…”!


#part 3
C_to_F <- function(x){
  x * 1.8 + 32
}

## naming the columns
mloa$temp_F_2m <- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m <- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop <- C_to_F(mloa$temp_C_towertop)

#Bonus: Hope to go over this in class to help explain?
mloa %>% select(c("temp_C_2m", "temp_C_10m", "temp_C_towertop")) %>% map_df(C_to_F) %>% rename("temp_F_2m"="temp_C_2m", "temp_F_10m"="temp_C_10m", "temp_F_towertop"="temp_C_towertop") %>% cbind(mloa)

#challenge: you lost me here...well above too...but not sure this should look like? 
surveys$genusspecies <- lapply(1:length(surveys$species), function(i){
  paste0(surveys$genus[i], " ", surveys$species[i])
})

