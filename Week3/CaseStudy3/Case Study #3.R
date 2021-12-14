#Load in our data Gapminder
install.packages("gapminder")
library(gapminder)
library(tidyverse)
head(gapminder)

data1 <- filter(gapminder, country!='Kuwait')
view(data1)

#lets creat the plot.
ggplot(data=data1, aes (x=lifeExp, y=gdpPercap))+
  geom_point(aes(color = continent, size = pop))+
  facet_wrap(~ year, nrow = 1)+
  theme_bw()+
  scale_y_continuous(trans = 'sqrt') 

Weight_ggp <- data1 %>% 
  group_by(year, continent)%>%
  summarize(avg = weighted.mean(gdpPercap), population = pop/10000)

  #make a graph using line/point 
ggplot(data=data1, aes (x=year, y=gdpPercap))+
  geom_point(data=data1, aes(color = continent))+
  geom_line(data=data1, aes(color = continent, group = country))+
  geom_point(data=Weight_ggp, aes(x=year, y=avg, size=population))+
  geom_line(data=Weight_ggp, aes(x=year, y=avg))+
  facet_wrap(~ continent, nrow=1)+
  theme_bw()+
  scale_size_continuous(name = "Population (100k)")
  