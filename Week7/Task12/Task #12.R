# Load in Packages 
library(tidyverse)
library(downloader)
library(readxl)

# Read in the data and evaluate
fandango_score <- read_csv("fandango_score_comparison.csv")
str(fandango_score)
head(fandango_score)
tail(fandango_score)

# Creat Tidy table
Movie_data <- fandango_score %>%
  select(FILM, RT_user_norm, Metacritic_norm, IMDB_norm, Fandango_Ratingvalue) %>%
  pivot_longer(2:5, names_to = "Websites", values_to = "Ratings") %>%
  select(FILM, Websites, Ratings)
view(Movie_data)

# get the top 20
top20 <- head(Movie_data, n=20)

# plot
ggplot(data = top20, aes(x = Ratings, y = FILM, fill = FILM)) +
  geom_col() +
  facet_wrap(~ Websites) +
  theme_bw() 

#this graph gives a direct comparison of each movie on each website. I found it interesting how generally Fandango has high ratings across alll the movies. 
# So if a individual where to just look at that website they maybe tricked into seeing a bad movie. I was also suprised with what we see with the Rotten Tomato Norm col chart.
