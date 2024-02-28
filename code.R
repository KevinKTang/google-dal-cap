# Install necessary packages

install.packages("dplyr")
install.packages("tidyverse")
install.packages("lubridate")

# Load the packages

library(dplyr)
library(tidyverse)
library(ggplot2)
library(lubridate)

# Since raw data is located in a sub-folder, set that folder as the working directory

setwd("~/R Projects/Capstone/rawdata")

# Load the raw data csv files

jan23 <- read.csv('202301-divvy-tripdata.csv')
feb23 <- read.csv('202302-divvy-tripdata.csv')
mar23 <- read.csv('202303-divvy-tripdata.csv')
apr23 <- read.csv('202304-divvy-tripdata.csv')
may23 <- read.csv('202305-divvy-tripdata.csv')
jun23 <- read.csv('202306-divvy-tripdata.csv')
jul23 <- read.csv('202307-divvy-tripdata.csv')
aug23 <- read.csv('202308-divvy-tripdata.csv')
sep23 <- read.csv('202309-divvy-tripdata.csv')
oct23 <- read.csv('202310-divvy-tripdata.csv')
nov23 <- read.csv('202311-divvy-tripdata.csv')
dec23 <- read.csv('202312-divvy-tripdata.csv')

# Merge them into a single year data frame using the rbind function and clean it - https://data101.cs.rutgers.edu/laboratory/pages/rbind

year23 <- rbind(jan23,feb23,mar23,apr23,may23,jun23,jul23,aug23,sep23,oct23,nov23,dec23) %>% 
  clean_names() 

# Export the uncleaned year23 data frame as a CSV for future reference, re-read it if needed

write.csv(year23, "~/R Projects/Capstone/rawdata/year23_raw.csv", row.names=FALSE)
year23 <- read.csv('year23_raw.csv')

# Remove individual data frames to free memory in the environment 

remove(jan23,feb23,mar23,apr23,may23,jun23,jul23,aug23,sep23,oct23,nov23,dec23)

#----Cleaning----

# Replace any null/blank/NA observations with NA and then clear them using na.omit() - this reduces the data frame from 5,719,877 to 4,331,701 rows

year23 <- replace(year23, year23=="", NA) %>% 
  na.omit()

# Remove any rows with duplicate values - no change

year23 <- distinct(year23)

# Remove any rows with 'ride_length_mins' less than 1 minute  - there are now 4,244,189  rows

year23 <- year23[!(year23$ride_length_mins<1),]

# Write the df to a clean CSV and you can re-read it if needed

write.csv(year23, "~/R Projects/Capstone/rawdata/year23_clean.csv", row.names=FALSE)
year23_clean <- read.csv('year23_clean.csv')

#----Transforming the data----

# Created a date column and then separated it into year, month, and day columns

year23_clean$date <- as.Date(year23_clean$started_at)
year23_clean <- tidyr::separate(year23_clean, date, c('year', 'month', 'day'), sep = "-", remove=FALSE)

# Created a season column

year23_clean <- year23_clean %>% mutate(season= case_when(
                                                month == "01" ~ "Winter",
                                                month == "02" ~ "Winter",
                                                month == "03" ~ "Spring",
                                                month == "04" ~ "Spring",
                                                month == "05" ~ "Spring",
                                                month == "06" ~ "Summer",
                                                month == "07" ~ "Summer",
                                                month == "08" ~ "Summer",
                                                month == "09" ~ "Autumn",
                                                month == "10" ~ "Autumn",
                                                month == "11" ~ "Autumn",
                                                month == "12" ~ "Winter"))

# Save as a final CSV

write.csv(year23_clean, "~/R Projects/Capstone/rawdata/year23_final.csv", row.names=FALSE)
year23_final <- read.csv('year23_final.csv')

#----Number of Rides Calculations----

# Number of Rides

nrow(year23_final)

# Number of Rides - Rideable Type 
year23_final %>% 
  group_by(member_casual, rideable_type) %>% 
  count(rideable_type)

#Number of Rides - Member Type

year23_final %>% 
  group_by(member_casual) %>% 
  count(member_casual)

# Number of Rides - Day of Week

year23_final %>% 
  group_by(member_casual, day_of_week) %>% 
  count(day_of_week)

# Number of Rides - Month

year23_final %>% 
  group_by(member_casual, month) %>% 
  count(month) %>% 
  print(n=24)

year23_final %>% 
  group_by(member_casual, season) %>% 
  count(season)

#----Average Ride Length Calculations----

#Average Ride Length (mins)

avg_ride_length_mins <- mean(year23_final$ride_length_mins)
print(avg_ride_length_mins)

# Average Ride Length - Rideable Type

year23_final %>% 
  group_by(member_casual, rideable_type) %>% 
  summarise_at(vars(ride_length_mins),list(time = mean))

# Average Ride Length - Member Type

year23_final %>% 
  group_by(member_casual) %>% 
  avg_membertype <- summarise_at(vars(ride_length_mins),list(time = mean))

# Average Ride Length - Month

year23_final %>% 
  group_by(member_casual, month) %>% 
  summarise_at(vars(ride_length_mins),list(time = mean)) %>% 
  print(n=24)

# Average Ride Length - Season

year23_final %>% 
  group_by(member_casual, season) %>% 
  summarise_at(vars(ride_length_mins),list(time = mean)) 

#----Visualisations - Number of Rides----

# Number of Rides - Member Type

year23_final %>% 
  group_by(member_casual) %>% 
  dplyr::summarize(trip_count = n()) %>% 
  ggplot(aes(x="", y=trip_count, fill=member_casual)) +
    geom_col() +
    geom_text(face="bold", size=4, family ="Roboto", aes(label=scales::comma(trip_count)),  position=position_stack(vjust=0.5)) +
    coord_polar(theta = "y") +
    theme_void()

# Number of Rides - Member Type & Rideable Type 

year23_final %>% 
    group_by(member_casual, rideable_type) %>% 
    dplyr::summarize(trip_count = n()) %>% 
    ggplot(aes(x= rideable_type, y=trip_count, fill=member_casual, color=member_casual)) + 
      geom_bar(stat="identity", position="dodge") + 
      geom_text(size=3.5, family ="Roboto", aes(label=scales::comma(trip_count)),  position=position_dodge(width=0.9), vjust=-0.5) +
      scale_y_continuous(labels = comma, breaks=scales::breaks_extended(n=10)) +
      labs(title= "Number of Trips - Rideable Type", x= "Rideable Type", y= "Number of Trips") +    
      theme_bw() +
      theme(plot.title = element_text(face = "bold", size = 18), axis.title = element_text(face = "bold"))
            
# Number of Rides - Day of Week

year23_final %>% 
  group_by(member_casual, day_of_week) %>% 
  dplyr::summarize(trip_count = n()) %>% 
  ggplot(aes(x= factor(day_of_week, levels = c("Monday", "Tuesday", "Wednesday", "Thursday","Friday","Saturday", "Sunday")), y=trip_count, fill=member_casual, color=member_casual)) + 
  geom_bar(stat="identity", position="dodge") + 
  geom_text(size=3.5, family ="Roboto", aes(label=scales::comma(trip_count)),  position=position_dodge(width=0.9), vjust=-0.5) +
  scale_y_continuous(labels = comma, breaks=scales::breaks_extended(n=10)) +
  labs(title= "Number of Trips - Day Of Week", x= "Day Of Week", y= "Number of Trips") +    
  theme_bw() +
  theme(plot.title = element_text(face = "bold", size = 18), axis.title = element_text(face = "bold"))

# Number of Rides - Month 

year23_final %>% 
  mutate(month = factor(month.abb[month], levels = month.abb)) %>% 
  group_by(member_casual, month) %>% 
  dplyr::summarize(trip_count = n()) %>% 
  ggplot(aes(x= month, y=trip_count, fill=member_casual, color=member_casual)) + 
    geom_bar(stat='identity', position='dodge') +
    geom_text(size=2.8, family ="Roboto", aes(label=scales::comma(trip_count)),  position=position_dodge(width=0.95), vjust=-0.5) +
    scale_y_continuous(breaks=scales::breaks_extended(n=10)) +
    labs(title= "Number of Trips - Month", x= "Month", y= "Number of Trips") +    
    theme_bw() +
    theme(plot.title = element_text(face = "bold", size = 18), axis.title = element_text(face = "bold"))

# Number of Rides - Season 

year23_final %>% 
  group_by(member_casual, season) %>% 
  dplyr::summarize(trip_count = n()) %>% 
  ggplot(aes(x= factor(season, levels = c("Summer", "Autumn", "Winter", "Spring")), y=trip_count, fill=member_casual, color=member_casual))  + 
    geom_bar(stat='identity', position='dodge') +
    geom_text(size=3.75, family ="Roboto", aes(label=scales::comma(trip_count)),  position=position_dodge(width=0.9), vjust=-0.5) +
    theme_bw() +
    labs(title= "Number of Trips - Season", x= "Season", y= "Number of Trips") +    
    theme_bw() +
    theme(plot.title = element_text(face = "bold", size = 18), axis.title = element_text(face = "bold"))

#----Visualisations - Average Ride Length----

# Average Ride Length - Rideable Type

year23_final %>% 
  group_by(member_casual, rideable_type) %>% 
  summarise_at(vars(ride_length_mins),list(time = mean)) %>% 
  ggplot(aes(x= rideable_type, y=time, fill=member_casual, color=member_casual)) + 
    geom_bar(stat='identity', position='dodge') +
    geom_text(size=4, family ="Roboto", aes(label=scales::comma(time)),  position=position_dodge(width=0.95), vjust=-0.5) +
    scale_y_continuous(breaks= seq(0,60,5)) +
    labs(title= "Average Ride Length - Rideable Type", x= "Rideable Type", y= "Average Ride Length (mins)") +
    theme_bw() +
    theme(plot.title = element_text(face = "bold", size = 18), axis.title = element_text(face = "bold"))

# Average Ride Length - Member Type

year23_final %>% 
  group_by(member_casual) %>% 
  summarise_at(vars(ride_length_mins),list(time = mean)) %>% 
  ggplot(aes(x= member_casual, y=time, fill=member_casual, color=member_casual)) + 
    geom_bar(stat='identity', position='dodge') +
    geom_text(size=4, family ="Roboto", aes(label=scales::comma(time)),  position=position_dodge(width=0.95), vjust=-0.5) +
    labs(title= "Average Ride Length - Member Type", x= "Member Type", y= "Average Ride Length (mins)") +
    theme_bw() +
    theme(plot.title = element_text(face = "bold", size = 18), axis.title = element_text(face = "bold"))

# Average Ride Length - Month

year23_final %>% 
  mutate(month = factor(month.abb[month], levels = month.abb)) %>% 
  group_by(member_casual, month) %>% 
  summarise_at(vars(ride_length_mins),list(time = mean)) %>% 
  ggplot(aes(x= month, y=time, fill=member_casual, color=member_casual)) + 
    geom_bar(stat='identity', position='dodge') +
    geom_text(size=3, family ="Roboto", aes(label=scales::comma(time)),  position=position_dodge(width=0.925), vjust=-0.5) +
    labs(title= "Average Ride Length - Month", x= "Month", y= "Average Ride Length (mins)") +
    theme_bw() +
    theme(plot.title = element_text(face = "bold", size = 18), axis.title = element_text(face = "bold"))

# Average Ride Length - Season

year23_final %>% 
  group_by(member_casual, season) %>% 
  summarise_at(vars(ride_length_mins),list(time = mean)) %>% 
  ggplot(aes(x= factor(season, levels = c("Summer", "Autumn", "Winter", "Spring")), y=time, fill=member_casual, color=member_casual)) + 
    geom_bar(stat='identity', position='dodge') +
    geom_text(size=3.75, family ="Roboto", aes(label=scales::comma(time)),  position=position_dodge(width=0.95), vjust=-0.5) +
    labs(title= "Average Ride Length - Season", x= "Season", y= "Average Ride Length (mins)") +
    theme_bw() +
    theme(plot.title = element_text(face = "bold", size = 18), axis.title = element_text(face = "bold"))
