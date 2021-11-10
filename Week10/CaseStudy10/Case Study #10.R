#Load in Packages
library(tidyquant) 
library(tidyverse) 
library(lubridate)
library(dygraphs)
library(timetk)
library(future)

#set up our time scale
start <- today() - years(5)
end<- today()

#Load in our Companies by there Tickers and get the prices
tickers_today <- c("CXW", "F", "GM", "KR", "WDC", "NKE","T", "WDAY", "WFC", "WMT")
all_tickers <- tq_get(tickers_today, get = "stock.price", from = start, to = end)
#check and see its loaded correctly
head(all_tickers)
tail(all_tickers)

# interactive graph
all_stocks <- all_tickers %>%
  select(symbol, date, adjusted)%>%
  pivot_wider(names_from = symbol, values_from = adjusted)%>%
  tk_xts(date_var = date)

dygraph(all_stocks)

#GGplot Graph
volume_stocks <- all_tickers  %>%
  ggplot(aes(x = date, y = volume)) +
  geom_line() +
  labs(title = "Volume Chart Over 5 years", 
       y = "volume", x = "time") + 
  coord_x_date(xlim = c(start, end)) +
  facet_wrap(~symbol)+
  theme_tq()
volume_stocks

#The first dygraph i found to be very helpful and easy to use and understand. Mu 
#second graph i had iissue with. my x a and y axis are not pretty. Overall we 
# asses that volume of stocks deals with a rising or falling of stock,
#that volume of stock is coming onto to off the market.# we can see in my first graph that,
#all the companies took a dip at the beggining of covid but shot back up, due to more people staying at home for work 
#i think has lead to a increase amount of people investing at home while they work, that way there money works for them.