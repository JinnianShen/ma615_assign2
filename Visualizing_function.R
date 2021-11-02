#Load the useful packages
library(tidyverse)
library(tidyr)
library(kableExtra)
library(knitr)
library(ggplot2)

#Read the selected data set from local
x<- read.csv(file = "/Users/jinnianshen/Desktop/hdi_human_development_index.csv")
y<- read.csv(file = "/Users/jinnianshen/Desktop/total_health_spending_per_person_international_dollar.csv")

#bind them into one data
data<- merge(x,y,by="country", all=TRUE)
view(data)

#We only select the years that both data sets have(2000-2010)
part1<- data[,c(1)]
part2<- data[,c(12:22)]
part3<- data[,c(36:46)]
newdata<-cbind (part1,part2,part3)
view(newdata)

###########################
#' In the original visualization_function.R, there does not exist a real function.
#' Hence, I choose to modify the author's visualization to a function.
#' Here is my modified function to plot the curve that of hdi index vs health spending for a country
###########################
function_vs <- function(data, country){
  # data = newdata
  # take China as an example, which is in data[36,]
  country <- newdata[36,] # this number can be changed depending on which country you want to analyze
  country1 <- country[,c(1:12)]
  country2<-country[,c(1,13:23)]
  country_1<- pivot_longer(country1,X2000.x:X2010.x,names_to = "hdi",values_to = "index")
  country_2<- pivot_longer(country2,X2000.y:X2010.y,names_to = "health",values_to = "spending")
  country_21<-country_2[,-1]
  countrytt<-cbind(country_1,country_21)
  ggplot(countrytt, aes(index, spending)) + geom_line()
}

###########################
#' Also, I add a new function for the author to explore the correlation of hdi index and health spending
###########################
dv <- function(data){
  # data = newdata
  data %>%
    count(index, spending) %>%
    ggplot(aes(x = index, y = spending)) + 
    geom_tile(mapping = aes(fill = n))
}