#Load the useful packages
library(tidyverse)
library(tidyr)
library(kableExtra)
library(knitr)

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

#Select China to do analyze
China<- newdata[36,]
view(China)
China1<-China[,c(1:12)]
China2<-China[,c(1,13:23)]
Chinap1<- pivot_longer(China1,X2000.x:X2010.x,names_to = "hdi",values_to = "index")
Chinap2<- pivot_longer(China2,X2000.y:X2010.y,names_to = "health",values_to = "spending")
Chinap21<-Chinap2[,-1]
Chinatt<-cbind(Chinap1,Chinap21)

#Select Canada to do analyze
Canada<- newdata[31,]
view(Canada)
Canada1<-Canada[,c(1:12)]
Canada2<-Canada[,c(1,13:23)]
Canada1<- pivot_longer(Canada1,X2000.x:X2010.x,names_to = "hdi",values_to = "index")
Canada2<- pivot_longer(Canada2,X2000.y:X2010.y,names_to = "health",values_to = "spending")
Canada21<-Canada2[,-1]
Canadatt<-cbind(Canada1,Canada21)

#ggplot
#plot the curve that of hdi index verse health spending(China)
library(ggplot2)
ggplot(Chinatt,aes(index,spending))+geom_line()

#plot the curve that of hdi index verse health spending(Canada)
library(ggplot2)
ggplot(Canadatt,aes(index,spending))+geom_line()
