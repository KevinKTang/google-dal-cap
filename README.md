# Scenario

You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share
company in Chicago. The director of marketing believes the company’s future success
depends on maximizing the number of annual memberships. Therefore, your team wants to
understand how casual riders and annual members use Cyclistic bikes differently. From these
insights, your team will design a new marketing strategy to convert casual riders into annual
members. But first, Cyclistic executives must approve your recommendations, so they must be
backed up with compelling data insights and professional data visualizations.

# About the company

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown
to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations
across Chicago. The bikes can be unlocked from one station and returned to any other station
in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to
broad consumer segments. One approach that helped make these things possible was the
flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships.
Customers who purchase single-ride or full-day passes are referred to as _**casual riders.**_
Customers who purchase annual memberships are _**Cyclistic members**_.

Cyclistic’s finance analysts have concluded that annual members are much more profitable
than casual riders. Although the pricing flexibility helps Cyclistic attract more customers,
Moreno believes that maximizing the number of annual members will be key to future growth.
Rather than creating a marketing campaign that targets all-new customers, Moreno believes
there is a solid opportunity to convert casual riders into members. She notes that casual riders
are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into
annual members. In order to do that, however, the team needs to better understand how
annual members and casual riders differ, why casual riders would buy a membership, and how
digital media could affect their marketing tactics. Moreno and her team are interested in
analyzing the Cyclistic historical bike trip data to identify trends.

# 1. Ask

### Business task 
Through data analysis, determine how annual members and casual riders use Cyclistic bikes differently to aid in designing marketing strategies to convert casual riders into annual members.

### What is the problem you are trying to solve?
We are trying to solve how to effectively market to casual riders so they convert to annual members.

# 2. Prepare

### Where is your data located?

- The data source is located here - https://divvy-tripdata.s3.amazonaws.com/index.html

### How is the data organised?

- The data itself consisted of twelve CSV files from the 2023 calendar year
	- The naming scheme is as follows - 202301-divvy-tripdata.csv

### Are there issues with bias or credibility in this data? Does your data ROCCC?
- Reliable
	- For the purposes of the case study, the data is from a primary source since it is internal company historical data. 
- Original 
  - For the purposes of this case study, it is internal company historical data.
- Comprehensive
	- Looks to be.
- Current
 	- This is an analysis of historical data from 2023, so it is fairly current.
- Cited
	- It has been noted where the data originates from.

### How are you addressing licensing, privacy, security, and accessibility?
- Made available by Motivate International Inc. under the licence outlined here - https://divvybikes.com/data-license-agreement
- Personal information is not provided.

### How did you verify the data’s integrity?
- The raw data can be considered as internal company data so it is a primary source.
- Data was acquired directly from the source location.

### How does it help you answer your question?
- The data provides us rides undertaken by Cyclistic users and lists if they are a casual rider or annual member, we can compare how they use the service and how often.

### Are there any problems with the data?
- From an initial inspection of the csv files themselves, I found rows with null, duplicate, and invalid values. 

# 3. Process

I used a combination of Excel and R for data analysis. Excel was used initially to familiarise myself with the data and for initial sorting and column addition. I followed up with RStudio to merge the CSVs as a whole year, analysed it and created visualisations.   

### Microsoft Excel

The following steps were performed for each of the twelve CSV files - 

1. Added a new column 'ride_length_mins' which calculated the ride length in minutes using the following function (formatted as NUMBER) -
	- **=('ended_at' - 'started_at')\*24\*60** 
2. Added a new column 'day_of_week' which displayed the day using the following function (for the WEEKDAY function, 1 = Sunday) -
	- **=TEXT(WEEKDAY('started_at'), "dddd")**
3. Sorted the entire sheet by 'ride_length_mins' in ascending order.

### RStudio

You can find the full .R code [here.](https://github.com/KevinKTang/google-dal-cap/blob/main/code.R)

Overview - 

1. I installed and loaded necessary packages such as dplyr, tidyverse, lubridate.
2. I uploaded the raw data CSV files and then used read.csv() to save them as individual data frames i.e. jan23, feb23 etc.
3. Using rbind(), I merged the 12 separate data frames into a whole year dataframe i.e. year23.
4. Cleaned the data -
   - Removed any null/blank/NA observations using na.omit()
   - Removed any duplicate observations using distinct()
   - Removed any rows that had a ride length (mins) that was < 1 min or had a negative value.
5. Added new columns (variables) -
   - Date
   - Year
   - Month
   - Day
   - Season 
6. Performed calculations -
	- Number of Trips
   		- Overall
   		- by Rideable Type
   		- by Member Type
   		- by Month
   		- by Season
	- Average Ride Length
   		- Overall
   		- by Rideable Type
   		- by Member Type
   		- by Month
   		- by Season
7. Created visualisations -
	- Number of Trips - Member Type & Rideable Type
	- Number of Trips - Day of Week
	- Number of Trips - Month
 	- Number of Trips - Season
	- Average Ride Length - Rideable Type
	- Average Ride Length - Member Type
	- Average Ride Length - Month
	- Average Ride Length - Season

# 4. Analyse & 5. Share

We are interested in answering the following regarding the business task - 
1. How do casual riders and annual members differ in their use of Cyclistic during the week based on rideable type?
2. What is the utilisation of Cyclystic throughout the year based on seasons and individual months?
3. What is the average trip length between casual riders and annual members?

## Number of Trips

### Number of Trips - Member Type
The total number of trips during 2023 was 4,244,189. Casual riders made up 35.46% of total trips. Annual members were 64.54% of all trips.

![image](https://github.com/KevinKTang/google-dal-cap/assets/30889787/2efe75ae-fcbf-4326-b66a-842b345f85ae)

### Number of Trips - Member Type & Rideable Type
- Casual riders used all three rideable types -
	- 860,702 used classic bikes, 75,412 used docked  bikes, and 569,179 used electric bikes.
- On the other hand, annual members only used classic and electric bikes - 
	- 1,788,780 trips used classic bikes and 950,116 used electric bikes.
 
![image](https://github.com/KevinKTang/google-dal-cap/assets/30889787/70120493-2889-4aff-bd61-fdf0aa9d8cb1)

### Number of Trips - Season
- There is a noticeable increase in bike usage across both casual riders and annual members during the Summer season which accounted for 39.16% of total trips.

![image](https://github.com/KevinKTang/google-dal-cap/assets/30889787/13c50e24-2128-4a94-8174-fce4a4d37676)

### Number of Trips - Month
- July was the busiest month for both casual riders and annual members.

![image](https://github.com/KevinKTang/google-dal-cap/assets/30889787/aca67e2a-c5a7-44ad-bde0-6d3b60cf85aa)

### Number of Trips - Day of Week
- On average, across an entire week, annual member usage is consistent. On the other hand, casual rider usage is lowest on Monday and stays relatively low throughout the week, but spikes on weekends.

![image](https://github.com/KevinKTang/google-dal-cap/assets/30889787/1b88ac5d-807c-436b-b617-8281211e9ef5)

## Average Ride Length

### Average Ride Length - Member Type

The average ride length for annual members was 12 minutes, while for casual riders it was 23 minutes.

![image](https://github.com/KevinKTang/google-dal-cap/assets/30889787/345366a9-8331-4fe5-a8f2-8691d087e6b0)

### Average Ride Length - Season

Average ride length is mostly consistent across seasons, however, there is a dip in usage during Winter, casual rider average ride length drops to 16 minutes.

![image](https://github.com/KevinKTang/google-dal-cap/assets/30889787/c9efe203-b627-4ad5-97ee-34874efa02c4)

## Average Ride Length - Month

Average ride length throughout the year for annual members is consistent and only ranges from 10 to 13 minutes.

![image](https://github.com/KevinKTang/google-dal-cap/assets/30889787/d00090bb-ebfe-4930-86cd-806d61dbc5d6)

# 6. Act

### Conclusion

- The most popular rideable type among both casual riders and annual members was the 'classic' bicycle.
- The docked bicycle rideable type only accounted for 1.78% of trips in 2023.
- The average ride length was 23 minutes for casual riders but on average rode 12 minutes longer than annual members. 
- The busiest day for annual members was Wednesday, and it was Saturday for casual riders.
- Summer was the busiest season of 2023 for both casual riders and annual members.

### Recommendations

- Offer discounted annual plan upgrade pricing to casual riders for their first year.
- During marketing, focus on added benefits of annual memberships such as "Ride with a friend" feature for free twice a month. It may also be worth partnering with local businesses to offer discounts through the annual membership accessible via the Cyclistic mobile application. 
- Cyclistic should allot most of their marketing resources during early Spring and Summer where casual riders are most prevalent. They should also focus on advertising during the weekends.
- Implement referral code bonuses for existing annual members so they may be incentivised to advertise via word of mouth to their colleagues, friends and familes.
  
### Resources

Inspiration was taken from - 
- [Kelly Adam](https://www.kellyjadams.com/post/google-capstone-project#viewer-41dce)
- [Usman Aftab Khan](https://medium.com/codex/exploratory-data-analysis-cyclistic-bike-share-analysis-case-study-1b1a00475a4f)
- [Joe Yong](https://medium.com/@joeanselmyz/google-data-analytics-case-study-1-using-rstudio-7c552ab63aa3)

