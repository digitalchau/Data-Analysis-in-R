setwd("~/UC/R Projects/BANA 4090/Week 4")
#Load Data
toyota <- read.csv("ToyotaCorolla.csv")
#EDA
dim(toyota)
summary(toyota)
colnames(toyota)
str(toyota)
#Pre-processing
########Splitting Data into Training and Validation Sets######
#dropping outlier in cc and omit variables that are not helpful predictors
toyota <- toyota[toyota$CC != 16000, -c(1:2, 6, 15)]
#sample 80% as training set and the rest as validation set
set.seed(1)
train.rows <- sample(rownames(toyota),nrow(toyota)*0.8)
toyota.train <- toyota[train.rows,]
valid.rows <- setdiff(rownames(toyota),train.rows)
toyota.valid <- toyota[valid.rows,]

########(Optional) Standardization######
#we are replacing the original values with z-score
#scale funtion to find z-score
toyota$sd.km <- scale(toyota$KM)

#Model Building
########Simple Linear Regression#####
#draw a scatter plot
plot(Price ~ Age_08_04, data = toyota.train)
#fit the simple linear regression
model0 <- lm(Price ~ Age_08_04, data=toyota.train)
model0
#add the resulting line to the scatter plot
abline(model0, col="red",lty=2,lwd=2)
#get the output of the scatter plot
sum.model0 <- summary(model0)
sum.model0
#looking at cor coefficients and adjusted r squared
model0$coefficients
sum.model0$adj.r.squared
#calculating confidence level
confint(model0)
#Predicting Price 
pred.model0 <- predict(model0, newdata = toyota.valid)
pred.model0
# Predict Price for Age_08_04 values of 10, 20, and 30
predict(model0, newdata = data.frame(Age_08_04 = c(10, 20, 30)), interval = "confidence")

Multiple Linear Regression
Model Assessment
In-sample Performance
Out-of-sample Prediction (Validation Error)
Cross-validation
Variable Selection
Compare Model Fit Manually
Exhaustive Search (Best Subsets)
Forward/Backward/Stepwise Regression Using AIC
Reducing Categories
Summary
Exercise
######Mulitple Linear Regression#####
model1 <- lm(Price ~ Age_08_04 + Mfg_Month + KM + Fuel_Type + HP + Met_Color + Color + Automatic +
               CC + Doors + Gears + Quarterly_Tax + Weight + Mfr_Guarantee + BOVAG_Guarantee + 
               Guarantee_Period + ABS + Airbag_1 + Airbag_2 + Airco + Automatic_airco + 
               Boardcomputer + CD_Player + Central_Lock + Powered_Windows + Power_Steering + 
               Radio + Mistlamps + Sport_Model + Backseat_Divider + Metallic_Rim + 
               Radio_cassette + Parking_Assistant + Tow_Bar, data = toyota.train)

# more efficient equivalent
model1 <- lm(Price ~ ., data = toyota.train)

# summary
summary(model1)