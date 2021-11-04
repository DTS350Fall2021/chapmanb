#Load in packages 
library(tidyverse)
library(lubridate)
library(downloader)
library(ggplot2)

#Bring in the data 
sales_csv <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/sales.csv", sales_csv, mode = "wb")
sale_data <- read_csv(sales_csv)

head(sale_data)
str(sale_data)

#Creat Aggrogate time
sales_times <- sale_data %>%
  with_tz(tzone = 'Us/Mountain') %>%
  mutate(hour = round_date(Time, "hour"),
         day = round_date(Time, "day"),
         week = round_date(Time, "week"),
         month = round_date(Time, "month"))
head(sales_times)
tail(sales_times)
 

#Total sales for each company 
total_sales <- sales_times %>%
  group_by(Name) %>%
  summarise(across(Amount, sum))

total_sales %>%
  mutate(Name = as.factor(fct_reorder(Name, Amount))) %>%
  arrange(desc(Amount)) %>%
  ggplot(aes(x = Name, y = Amount, fill = Name)) +
  geom_col() +
  labs(x = 'Company', y = 'Total Sales', title = 'Total Sales for Each Company') +
  theme_bw() 
##From this graph we can break down all of the companies total sales, we can see from this 
##that Missing is struggling the most out of all the companies.  lets look deeper in everyday sales and see what is going on. 

#Sales per day of each company
#HAd to put in a scale for the x-axis that way it stsnds for each day of the week.
sales_times %>%
  mutate(Day = wday(day)) %>%
  group_by(Name,Day) %>%
  summarise(across(Amount, sum)) %>%
  ggplot(aes(x = Day, y = Amount, color = Name)) +
  geom_point() +
  geom_line() +
  facet_wrap(~Name, scales = 'free') +
  labs(x = 'Day of the Week', y = 'Number of Sales', title = 'Company Sales per Day') +
  scale_x_continuous(limits = c(1, 7),breaks = seq(1, 7, 1)) +
  theme_bw() 
  
# we can gather alot of information from this graph, like what day during the week should stores be open
# from what the graphs show us, we can conclude that Monday and Tuesday Sales are the slowest,
# and Saturday and Sunday are the highest, we can conlude that if the compnaies were to let there 
#employee have 2 days off a week they should close the stores Monday and Tueday, due to little or no saels on those day. I believe for a store like Missing it should only be open Thursday-Sunday
#there are no sales until friday and what sales they do have they are minimal.

#we are going to track Sales per month, to see who has the highest monthky avg
sales_times %>%
  mutate(Month = month(month)) %>%
  group_by(Name,Month) %>%
  summarise(across(Amount, sum)) %>%
  ggplot(aes(x = Month, y = Amount, color = Name)) +
  geom_point() +
  geom_line() +
  facet_wrap(~Name, scales = 'free') +
  labs(x = 'Months of the YEar', y = 'Sales', title = 'Company Sales per Month')
  scale_x_continuous(limits = c(1, 12),breaks = seq(1, 12, 1)) ++
  theme_bw() 
  
  ## I ran into some trouble on this graph, cause i could get the plot to scale out tto 1-12 so could see each month
  ##from what the graphs show us we can see that month 5-9 seem to be the only part in the year that sales are made
  #so it is seasonal, from that i would conclude LaBelle would be the best business to purchase 
  ## it has the most sales per month than any other competitor, and rivals Hotdiggity dor toal sales throughout the year
