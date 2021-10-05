# Load in our packages
library(tidyverse)
library(gridExtra)
library(dplyr)

#load in data 
?diamonds
str(diamonds)
head(diamonds)
tail(diamonds)

#Creat the x,y,z plots (length, width, depth)
# X plot
ggplot(diamonds, aes(x)) +
  geom_histogram(color = 'green', fill = 'gray') +
  labs(x = 'Length (mm)', y = 'Diamond Observations', title = 'Graph X Length Distribution') +
  coord_cartesian(xlim = c(3,10),ylim = c(0, 12000)) +
  theme_bw()
#Y plot
ggplot(diamonds, aes(y)) +
  geom_histogram(color = 'yellow', fill = 'gray', binwidth = .25) +
  labs(x = 'Width (mm)', y = 'Diamond Observations', title = 'Graph Y Width Distribution') +
  coord_cartesian(xlim = c(3,10),ylim = c(0, 7000)) +
  theme_bw()
#Z plot
ggplot(diamonds, aes(z)) +
  geom_histogram(color = 'red', fill = 'gray', binwidth = .25) +
  labs(x = 'Depth (mm)', y = 'Diamond Observations', title = 'Graph Z Depth Distribution') +
  coord_cartesian(xlim = c(.5,8.5),ylim = c(0, 12000)) +
  theme_bw()

#Creat the Dirstbution of price
#plot $$
ggplot(diamonds, aes(price)) +
  geom_histogram(color = 'blue', fill = 'gray') +
  labs(x = 'Price in US Dollar', y = 'Diamond Observations', title = 'Graph $$ Price Distribution') +
  theme_bw()
##Notes: We can notice some simple factors by looking at the distribution,
## As the graph goes left to right we notice there are far more cheaper diamonds as 
## there are exepnsive. We also say that the majority of the the diamonds in the data
## Set are less than $5000.

#Creat a Distribution compareing price and carat
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  geom_smooth() +
  labs(x = 'Carat (Weight)', y = "Price In US Dollar", title = "Prices Vs Carat Distribution") +
  theme_bw()
#general trend is the the heavier the diamond the more expensive it will be.

#Creat a Distribution that compared Price and Cut
ggplot(diamonds, aes(cut, carat)) +
  geom_boxplot(aes(fill = cut)) +
  labs(x = 'Diamond Cut', y = 'Carat (Weight)', title = 'Carat Vs Cut Distribution') +
  theme_bw()
#based on the distribution as cut increased carat decreased showing a overall negative 
#correlation. we can correlate the finer the cut the diamond has the less its weighs.
 
#Creat a graph by breaking down price and compareing it to carat
diamonds %>%
  mutate(price_group =
           case_when(
             price >= 0 & price <= 3000 ~ '0-3000',
             price >= 3001 & price <= 6000 ~ '3001-6000',
             price >= 6001 & price <= 9000 ~ '6001-9000',
             price >= 9001 & price <= 12000 ~ '9001-12000',
             price >= 12001 & price <= 15000 ~ '12001-15000',
             price >= 15001 & price <= 18000 ~ '15001-18000',
             price >= 18001 & price <= 21000 ~ '18001-21000'),
         price_group = fct_relevel(price_group,'0-3000','3001-6000','6001-9000','9001-12000','12001-15000','15001-18000','18001-21000')) %>%
  ggplot(aes(carat, price, fill = price_break)) +
  geom_boxplot() +
  labs(x = 'Carat (Weight)', y = 'Price In US Dollar', title = 'Carat grouped by Price') +
  theme_bw()
#Compares the size of diamonds to price
Lplot <- diamonds %>%
  filter(carat >= 4) %>%
  ggplot(aes(price)) +
  geom_histogram(color = 'grey', fill = 'red') +
  labs(x = 'Price In US Dollars', y = 'Diamond Observations', title = 'Large Diamond Plot') +
  theme_bw()
Splot <- diamonds %>%
  filter(carat <= 1) %>%
  ggplot(aes(price)) +
  geom_histogram(color = 'grey', fill = 'blue') +
  labs(x = 'Price In US Dollars', y = 'Diamond Observations', title = 'Small Diamond Plot') +
  theme_bw()
grid.arrange(Lplot, Splot, nrow = 2)

#Larger diamonds cost more than small diamonds.

#Combined plot
ggplot(diamonds, aes(x = carat, y = price, fill = cut)) +
  geom_col() +
  coord_cartesian(xlim = c(0,3), ylim = c(0, 2500000)) +
  facet_wrap(~cut) +
  labs(x = 'Carat (Weight)', y = 'Price In US Dollars', title = 'Plot Compareing Cut, Carat, and Price') +
  theme_bw()

## Conclusion We can conlsude the bigger and heavier the diamond the more it will cost
## Small diamonds with a good cut can still be quiet expensive but a diamond 
## that is heavier and/or bigger wont be affected by weight.