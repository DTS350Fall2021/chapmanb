---
title: 'Case Study #9'
author: "Blayne Chapman"
date: "11/4/2021"
output:
  html_document:
    theme: united
    keep_md: True
    code_folding: 'hide'
---


```r
#Load in packages 
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.3     v purrr   0.3.4
## v tibble  3.1.0     v dplyr   1.0.5
## v tidyr   1.1.3     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(lubridate)
```

```
## 
## Attaching package: 'lubridate'
```

```
## The following objects are masked from 'package:base':
## 
##     date, intersect, setdiff, union
```

```r
library(downloader)
library(ggplot2)
```


```r
#Bring in the data 
sales_csv <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/sales.csv", sales_csv, mode = "wb")
sale_data <- read_csv(sales_csv)
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Name = col_character(),
##   Type = col_character(),
##   Time = col_datetime(format = ""),
##   Amount = col_double()
## )
```

```r
head(sale_data)
```

```
## # A tibble: 6 x 4
##   Name       Type           Time                Amount
##   <chr>      <chr>          <dttm>               <dbl>
## 1 Tacontento Food(prepared) 2016-05-16 19:01:00    3  
## 2 Tacontento Food(prepared) 2016-05-16 19:01:00    1.5
## 3 Tacontento Food(prepared) 2016-05-16 19:04:00    3  
## 4 Tacontento Food(prepared) 2016-05-16 19:04:00    3  
## 5 Tacontento Food(prepared) 2016-05-16 19:04:00    1.5
## 6 Tacontento Food(prepared) 2016-05-16 19:04:00    1
```

```r
str(sale_data)
```

```
## spec_tbl_df [15,656 x 4] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ Name  : chr [1:15656] "Tacontento" "Tacontento" "Tacontento" "Tacontento" ...
##  $ Type  : chr [1:15656] "Food(prepared)" "Food(prepared)" "Food(prepared)" "Food(prepared)" ...
##  $ Time  : POSIXct[1:15656], format: "2016-05-16 19:01:00" "2016-05-16 19:01:00" ...
##  $ Amount: num [1:15656] 3 1.5 3 3 1.5 1 3 3 1.5 3 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   Name = col_character(),
##   ..   Type = col_character(),
##   ..   Time = col_datetime(format = ""),
##   ..   Amount = col_double()
##   .. )
```


```r
#Creat Aggrogate time
sales_times <- sale_data %>%
  with_tz(tzone = 'Us/Mountain') %>%
  mutate(hour = round_date(Time, "hour"),
         day = round_date(Time, "day"),
         week = round_date(Time, "week"),
         month = round_date(Time, "month"))
head(sales_times)
```

```
## # A tibble: 6 x 8
##   Name  Type  Time                Amount hour                day                
##   <chr> <chr> <dttm>               <dbl> <dttm>              <dttm>             
## 1 Taco~ Food~ 2016-05-16 13:01:00    3   2016-05-16 13:00:00 2016-05-17 00:00:00
## 2 Taco~ Food~ 2016-05-16 13:01:00    1.5 2016-05-16 13:00:00 2016-05-17 00:00:00
## 3 Taco~ Food~ 2016-05-16 13:04:00    3   2016-05-16 13:00:00 2016-05-17 00:00:00
## 4 Taco~ Food~ 2016-05-16 13:04:00    3   2016-05-16 13:00:00 2016-05-17 00:00:00
## 5 Taco~ Food~ 2016-05-16 13:04:00    1.5 2016-05-16 13:00:00 2016-05-17 00:00:00
## 6 Taco~ Food~ 2016-05-16 13:04:00    1   2016-05-16 13:00:00 2016-05-17 00:00:00
## # ... with 2 more variables: week <dttm>, month <dttm>
```

```r
tail(sales_times)
```

```
## # A tibble: 6 x 8
##   Name  Type  Time                Amount hour                day                
##   <chr> <chr> <dttm>               <dbl> <dttm>              <dttm>             
## 1 Froz~ Food~ 2016-07-09 17:58:00   5    2016-07-09 18:00:00 2016-07-10 00:00:00
## 2 Froz~ Food~ 2016-07-09 18:33:00   5    2016-07-09 19:00:00 2016-07-10 00:00:00
## 3 Froz~ Food~ 2016-07-09 18:37:00   5    2016-07-09 19:00:00 2016-07-10 00:00:00
## 4 Froz~ Food~ 2016-07-09 18:47:00   5    2016-07-09 19:00:00 2016-07-10 00:00:00
## 5 Miss~ Miss~ 2016-06-17 15:12:00 150    2016-06-17 15:00:00 2016-06-18 00:00:00
## 6 Miss~ Miss~ 2016-04-20 13:01:00  -3.07 2016-04-20 13:00:00 2016-04-21 00:00:00
## # ... with 2 more variables: week <dttm>, month <dttm>
```


```r
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
```

![](Case-Study--9_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```r
##From this graph we can break down all of the companies total sales, we can ##see from this 
##that Missing is struggling the most out of all the companies.  lets look ##deeper in everyday sales and see what is going on. 
```


```r
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
```

```
## `summarise()` has grouped output by 'Name'. You can override using the `.groups` argument.
```

![](Case-Study--9_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
# we can gather alot of information from this graph, like what day during the week should stores be open
# from what the graphs show us, we can conclude that Monday and Tuesday Sales are the slowest,
# and Saturday and Sunday are the highest, we can conlude that if the compnaies were to let there 
#employee have 2 days off a week they should close the stores Monday and Tueday, due to little or no saels on those day. I believe for a store like Missing it should only be open Thursday-Sunday
#there are no sales until friday and what sales they do have they are minimal.
```


```r
#we are going to track Sales per month, to see who has the highest monthy avg
sales_times %>%
  mutate(Month = month(month)) %>%
  group_by(Name,Month) %>%
  summarise(across(Amount, sum)) %>%
  ggplot(aes(x = Month, y = Amount, color = Name)) +
  geom_point() +
  geom_line() +
  facet_wrap(~Name, scales = 'free') +
  labs(x = 'Months of the YEar', y = 'Sales', title = 'Company Sales per Month')+
  scale_x_continuous(limits = c(1, 12),breaks = seq(1, 12, 1)) +
  theme_bw() 
```

```
## `summarise()` has grouped output by 'Name'. You can override using the `.groups` argument.
```

![](Case-Study--9_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

```r
  ## I ran into some trouble on this graph, cause i could get the plot to scale out tto 1-12 so could see each month
  ##from what the graphs show us we can see that month 5-9 seem to be the only part in the year that sales are made
  #so it is seasonal, from that i would conclude LaBelle would be the best business to purchase 
  ## it has the most sales per month than any other competitor, and rivals Hotdiggity dor toal sales throughout the year
```

