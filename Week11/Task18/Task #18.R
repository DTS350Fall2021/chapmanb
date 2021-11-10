#The stock market is overflowing with data. There are many packages 
#in R that allow us to get quick access to information on publicly traded 
#companies. Imagine that you and a friend each purchased about $1,000 of stock 
#in three different stocks at the start of October last year, and you want to 
#compare your performance up to this week. Use the stock shares purchased and 
#share prices to demonstrate how each of you fared over the period you were 
#competing (assuming that you did not change your allocations).

#My Business
#Business 1 = Garmin Ltd GRMN
#Business 2 = Apple Inc APPL
#Business 3 = Microsoft Corporation MSFT
#Friends Business
#Business 1 = Alphabet inc GOOGL
#Business 2 = Dell Technologies DELL
#Business 3 =  Intel Corporation INTC
 
#Load in Packages
install.packages("timetk")
library(tidyquant) 
library(tidyverse) 
library(lubridate)
library(dygraphs)
library(timetk)
library(future)

#Make the timeframe. 1 year
start <- today() - years(1)
end<- today()

#load in My Business's 
(Garmin <- tq_get("GRMN", get = "stock.price", from = start, to = end))
(Apple <- tq_get("AAPL", get = "stock.price", from = start, to = end))
(Microsoft <- tq_get("MSFT", get = "stock.price", from = start, to = end))

#load in Friends Business's
(Google <- tq_get("GOOGL", get = "stock.price", from = start, to = end))
(Dell <- tq_get("DELL", get = "stock.price", from = start, to = end))
(Intel <- tq_get("INTC", get = "stock.price", from = start, to = end))

#plug all of this data into one.
all_stocks <- tq_get(c("GRMN","AAPL","MSFT","GOOGL","DELL","INTC"), get = "stock.price", from = start, to = end)
head(all_stocks)
tail(all_stocks)
str(all_stocks)

#Now that we compare them lets build graphs to show who won.
#How do i Adjust the it so the graph shoes different colors for Microsoft and Dell?
who_won <- all_stocks %>%
  select(symbol, date, adjusted)%>%
  pivot_wider(names_from = symbol, values_from = adjusted)%>%
  tk_xts(date_var = date)

dygraph(who_won)

#Google  was the highest one and seemd to have the most increase over time.
#Creat a graph for Google
all_stocks %>%
  filter(symbol == "GOOGL")%>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line() +
  labs(title = "Winning Chart", 
       y = "Closing Price", x = "Time") + 
  coord_x_date(xlim = c(start, end)) +
  theme_tq()
#I choose to use a line graph just to show how google has grown over time 
#you can tell in that one year how much growth google had, there stock prices went up 
# a little more than a thousand in one year is very impressive.
#So in the Contest i technically did not lose to mu friend because he spent more 
#Money then i did. When chooseing our companies we dcided we wnated to find 
#the best Technologie companies, we found that google has been the most successful.