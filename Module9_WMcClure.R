###Module #9 Data Vis in R
##LIS 4370
#Wayne McCLure


#load libraries

library(readr)
library(tidyverse)
library(lattice)
library(RColorBrewer)
library(sqldf)


##Data used is Police stop records
MplsStops <- read_csv("MplsStops.csv")
View(MplsStops)
sum(is.na(MplsStops$race))
#Main use in this instance is the race and traffic stop type. I will fill in NA values with "Unknown" 
#Unknown already exists as a value and is valid for nulls in this instance

MplsStops$race[is.na(MplsStops$race)] = "Unknown"

sum(is.na(MplsStops$race))

##number of unique values in race column plus setting up table for nonnumeric values
sqldf("select count(distinct(race)) from MplsStops")
tb <- table(MplsStops$race, MplsStops$policePrecinct)



##Base R Histogram of race stops by precinct 
coul <- brewer.pal(8,"Spectral")
barplot(tb,col = coul,main = "Race Stops by Precinct" ,beside = TRUE, legend = TRUE)

##Same visual by Lattice library

barchart( race~ policePrecinct, data= MplsStops, main = "Race Stops by Precinct", col = coul)


#Same visual in ggplot



ggplot(MplsStops) +
 aes(x = race, fill = race) +
 geom_bar() +
 scale_fill_brewer(palette = "Dark2", direction = 1) +
 theme_gray() +
 theme(legend.position = "top") +
 facet_wrap(vars(policePrecinct))

