getwd()
#Exercise 2.1
boulder.df <- read.csv("Boulder_2.csv", header = 1)
View(boulder.df)

#Plot Time Series
boulder.ts <- ts(boulder.df$Temperature,start=c(1991,1),frequency=12) 
plot(boulder.ts)

#Boulder Seasonal Plot
install.packages("forecast")
library("forecast")
help(forecast)
ts.l4y <- window(boulder.ts,start=c(2012,1))
plot(ts.l4y)  
seasonplot(ts.l4y,col=c(1:4),year.labels.left=T,ylab="average temperature, boulder, CO")

#Exercise 2.2
sales <- read.csv("US_Retail_sales_2.csv")
#Time Series Plot
sales.df <- ts(sales$Sales,start = c(2001, 1),frequency=12)
plot(sales.df)

#Seasonal Plot for the last 4 years
sales.df1 <- data.frame(Week=1:7, Sales=c(15,10,12,16,9,8,14))
sales.l4y <- window(sales.df)
plot(sales.l4y)
seasonplot(sales.l4y,col=c(1:4),year.labels.left=T, ylab="monthly sales")

#Exercise 2.5
matrix.ts <- matrix(boulder.ts,ncol=12,byrow=T)
matrix.ts
dim(matrix.ts)
colnames(matrix.ts) <- month.abb
rownames(matrix.ts) <- c(1991:2015)
matrix.ts
#apply function
median_bym <-apply(matrix.ts,2,mean)
median_bym
median_bym <- apply(matrix.ts, 2, median)
median_bym
mad_bym <- apply(matrix.ts, 2, mad)
mad_bym
sd_bym <- apply(matrix.ts, 2, sd)
sd_bym

#--- Comment: ---
#### In terms of mean and median of temperature each month, the values are 
#### very close throughout the year, which suggests that the distribution
#### is close to a normal distribution.
#### The variation of the temparature is great throughout the year:
#### lowest temparature in winter months (December - February),
#### warmer in Spring (March-May), hottest in Summer months (June-August), and
#### cooling down in Fall (September-November).

## Calculating summary statistics across all values doesn't make sense here
## and will be meaningless since variable temperature has variations
## in each season of the year 



