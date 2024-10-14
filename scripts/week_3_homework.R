## Maya Burgess
## Homework Week 3 

## Problem 1 - load data

surveys <- read.csv("data/portal_data_joined.csv")

str(surveys)
colnames(surveys)

## create new data frame - this is how!! 

surveys_base <- surveys ## create data frame 

## first 5000 rows only
surveys_base <- surveys[1:5000, c(6,9,13)] ## 



## convert to factors
surveys_base$species_id <- factor(surveys_base$species_id)

surveys_base$plot_type <- factor(surveys_base$plot_type)

## remove NAs
na.omit(surveys_base$species_id)

levels(surveys_base$species_id)

typeof(surveys_base$species_id)

class(surveys_base$species_id)

summary(surveys_base)

## other questions....
## factors are used to represent category datas and 
## are stored as integers and have labels. 
## Factors look like vectors _ and behave similarly but are really integers too.
## Git hub says to be careful when treating them like "strings"
## benefits might be they are away to add or remove labels - but I am not completely sure.


## challenge create a second data frame called challenge_base with items 
## from surveys_base greater than >150g
## first step create the data frame - just type name challenge_base from <- surveys_base 
## the use brackets to remove columns less than 150 

## create
challenge_base <- surveys_base
## amend
challenge_base <- surveys_base[surveys_base[, 2]>150,]

## not sure where it shows....in the environment? now 577 of 3?? from 5000 of 3.

