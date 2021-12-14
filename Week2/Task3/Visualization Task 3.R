#Load packages
library(tidyverse)

#retrive iris and look at the dimension
dim(iris)
#look at the head of iris
head(iris)
summary(iris)

#try ad creat a scatter plot with a legend of the different species with
#different shapes and colors. 
#plot #1
#Based on our data what do we know about the comparison of sepal legnth and width?
ggplot(data=iris, aes (x=Sepal.Length, y=Sepal.Width))+
  geom_point(aes(color = Species, shape = Species))
 

#add a facet to split the Graphs and also change the axis.
#Plot#2
#which species has the biggest petals out of the data?
ggplot(data=iris, aes (x=Petal.Length, y=Petal.Width))+
  geom_point(aes(color = Species, shape = Species))+
  facet_wrap(~ Species)

#Make graph with points it and geom smooth line on it.
#Plot 3
#Would there be a way to to scale how mcuu bigger each species is compared to one another?
ggplot(data = iris) + 
  geom_point(mapping = aes(x = Petal.Length, y = Petal.Width, shape = Species, color = Species)) +
  geom_smooth(formula = y ~ x, method = "lm", mapping = aes(x=Petal.Length, y=Petal.Width))

#Creat a stacked bar chart by species 
#plot #4
#What Species had the biggest sepal length?
ggplot(data=iris, aes (x=Sepal.Length, fill = Species))+
  geom_bar(color = "black", stat = "bin", bins = 20)+
  geom_vline(aes(xintercept = mean(Sepal.Length)), linetype = "dashed", color = "black")
