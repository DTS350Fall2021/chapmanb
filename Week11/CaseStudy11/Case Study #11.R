#Load in the Packages
install.packages("USAboundaries")
install.packages("USAboundariesData", repos = "https://ropensci.r-universe.dev", type = "source")
library(USAboundaries)
library(tidyverse)
library(downloader)
library(plotly)

#Load in the Data 
csv_temp <- tempfile()
download("https://raw.githubusercontent.com/WJC-Data-Science/DTS350/master/permits.csv", csv_temp, mode = "wb")
permit_data <- read_csv(csv_temp)

#look at the Data and How it was brought in.
head(permit_data)
str(permit_data)
tail(permit_data)

#Merge the the two Dataframes
zip_codes <- state_codes %>%
  mutate(state = as.integer(state_code))

state_permits <- merge(permit_data, zip_codes,by = "state") %>%
  group_by(state_name,year) %>%
  summarise(across(value, sum))

head(state_permits)

# The first plot is to see the overall permit data by state
state_permit_plot <- ggplot(data = state_permits, aes(x = year, y = value/1000, color = state_name)) +
  geom_point(aes(text = paste("State:",state_name))) +
  geom_line() +
  geom_vline(xintercept = 2008, linetype = 'dotted') +
  labs(x = 'Time in (Years)', y = 'Number of Permits', title = 'Permits by State') +
  theme_bw()+
  theme(legend.position = 'none')
ggplotly(state_permit_plot)

#I wish there was a better way to graph the data without having it all on top of each other 
#I unerstand when we make it interactive we can see what each data point is from. 
#We can See that California sold the most in 1986. What I find interesting are the top three.
#when looking at the top three we can see that Florida, Texas, And California had a growning population 
# we should look how thay compare individually over time.


state_permits %>%
  filter(state_name == c('Florida', 'California', 'Texas')) %>%
  ggplot(aes(x = year, y = value/1000, color = state_name)) +
  geom_point() +
  geom_line() +
  geom_vline(xintercept = 2008, linetype = 'dotted') +
  labs(x = 'Time', y = 'Number of Permits', title = 'Top 3 Permit Sates') +
  theme_bw()
ggplotly(state_permits)  

## after adding in the 2008 Market crash to the data we can see that these three big states
#took a big hit. They all continued tp drop after the crash even though these three states have
# the highest populations in the united states. 