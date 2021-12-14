#simple Calculations
2+7
sin(pi/4)
x = 10/3
#names that are allowed and names that are not allowed
my_names <- (bob,john,casey,julie)
#this list does not work because it is not in string formatt
my_names <- ("bob", "john", "Casey", "Julie")
#these are allowed, they are in string formatt ("")

#Creat a Sequence 1-50 
MySequence <- seq(1,50,7)
MySequence

#Now creat a variable and name it.
My_vector <- c(1,5,12,31,19)
My_vector

#show an example what "==" means
7+5=12
7+5==12
#the difference between these two items is just one "=" is an assignent variable
#but with two equal signs it means that it will check see if its right or wrong
# True and False

#explain the result
(7+4=12)|(5-4=1)
#THe system is confused because we did not assign anything to it
#and 7+4 equals 11 not 12

#Problem 1
#the code does not work because the call name of the function is not spelled the same 

##problem 2
library(tidyverse)

ggplot(dota = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

fliter(mpg, cyl = 8)
filter(diamond, carat > 3)
## filter is misspelled and data it misppelled dota
## diamonds not diamond

#fixed
library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl = 8)
filter(diamonds, carat > 3)

# Problem 3
## all of my keyboard shortcuts pop up.
## this can also be displayed by going to tools then down to keyboard shortcuts.

##Missing Last two problems from worksheet.