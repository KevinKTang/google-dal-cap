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
   
# 4. Analyse

# 5. Share

# 6. Act
