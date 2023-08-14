if(!is.null(dev.list())) dev.off()  # clear out the past 
rm(list = ls())
cat("\014")
# loading the necessary packages
library(dplyr)
library(tidyr) 
library(moments)
library(reshape2)
library(flextable)

# names of the species given to me for analysis
selected_eco<-c('Bees','Bird','Carabids','Isopods','Macromoths','Grasshoppers_._Crickets','Vascular_plants')
# please change the file path name before running the code
data_main <-  read.csv("/Users/haris/Desktop/data_stat/proportional_species_richness_V3.csv")
names(data_main)

# creating a dataframe "given_data" and adding the selected data to it from the main dataframe
given_data <- data_main%>%select(Location,all_of(selected_eco),Easting,Northing,
                                 dominantLandClass,ecologicalStatus,period)
# checking the selected data
head(given_data)
names_eco <- names(given_data[,2:8])

pos_eco <-match(selected_eco,names(given_data))
# calculating mean for the given columns while leaving the na values uncounted
selected_mean <- rowMeans(given_data[,selected_eco],na.rm=TRUE)
# Adding a column for mean of the give 7 categories
given_data <- given_data%>%mutate(selected_ecostatus=selected_mean)

names(given_data)# confirming
# converting to factor for numerical analysis
given_data <- given_data %>% 
  mutate(period = as.factor(period),
         dominantLandClass = as.factor(dominantLandClass))

#############--Data Exploration--###########################
# create empty table
Analysis_table <- data.frame(Name = character(),
                    Mean = double(),
                    SD = double(),
                    Skewness = double(),
                    stringsAsFactors = FALSE)

# Creating Tables to explore the data
Analysis_table <- data.frame()
for(i in pos_eco){
  Analysis_table <- rbind(Analysis_table,
                 c(names_eco[i-1],
                   round(mean(given_data[,i],na.rm = TRUE),digits = 3),
                   round(sd(given_data[,i],na.rm = TRUE),digits = 3),
                   round(skewness(given_data[,i],na.rm = TRUE),digits = 3),
                   round(kurtosis(given_data[,i],na.rm = TRUE),digits = 3),
                   round(range(given_data[,i]),digits = 2)
                 ))}
colnames(Analysis_table) <- c("Names","Mean","Standard_deviation","skewness",
                              "Kurtosis","Range_min","Range_max")
print(Analysis_table%>%arrange(Standard_deviation,skewness))


# Observing distribution of data in each variable by plotting boxplot

boxplot(given_data$Bees, main="Distribution of Bee Population", xlab="Bee", ylab="Population")
# for bees

boxplot(given_data$Bird, main="Distribution of Bird Population", xlab="Bird", ylab="Population")
# for birds

boxplot(given_data$Carabids, main="Distribution of Carabid Population", xlab="Carabid", ylab="Population")
# for Carabids

boxplot(given_data$Isopods, main="Distribution of Isopods Population", xlab="Isopods", ylab="Population")
# for Isopods


boxplot(given_data$Macromoths, main="Distribution of Macromoths Population", xlab="Macromoths", ylab="Population")
# for Macromoths

boxplot(given_data$Grasshoppers_._Crickets, main="Distribution of Crickets Population", xlab="Crickets", ylab="Population")
# for Crickets

boxplot(given_data$Vascular_plants, main="Distribution of Vascular plants Population", xlab="Vascular plants", ylab="Population")
# for Vascular plants

# checking correlation among species

numeric_cols <- sapply(given_data, is.numeric)
cor_given_data <- round(cor(given_data[, numeric_cols],use="pairwise.complete.obs"),2)
corrplot(cor_given_data)
#_________
number_location <-length(unique(given_data$Location))
number_location
number_dominantLandClass <-length(unique(given_data$dominantLandClass))
number_dominantLandClass
number_period<- length(unique(given_data$period))
number_period

#__________________________________
# Hypothesis testing
names(given_data)
# first test
# Subset data by period
period1 <- subset(given_data, period == "Y70")
period2 <- subset(given_data, period == "Y00")

# Perform t-test
t.test(period1$selected_ecostatus, period2$selected_ecostatus, var.equal = TRUE)

# second test 

# Calculate correlation between bees and bird species
cor.test(given_data$Bees, given_data$Bird, method = "pearson")

#--------------------------------
# changing nthe name for ecological statuses
names(given_data)[12] <- "BD11"
names(given_data)[14] <- "BD7"
# Performing simple linear regression

# Perform simple linear regression for BD7 and BD11
lm_result <- lm(BD11 ~ BD7, data = given_data)

# Print summary of regression results
summary(lm_result)

plot(given_data$BD11~given_data$BD7)
abline(0,1,col="red")
abline(lm_result,col="green")

# Applying regression after splitting the data on the basis of period

# Split the data by period
data_by_period <- split(given_data, given_data$period)

# Perform separate linear regressions for each period
for (i in 1:length(data_by_period)) {
  lm_result <- lm(BD11 ~ BD7, data = data_by_period[[i]])
  print(paste0("Regression results for period ", unique(data_by_period[[i]]$period), ":"))
  print(summary(lm_result))
}

#--------------------------------------------
names(data_main)
names(given_data)
# Multiple linear regression
remaining_species<-c("Bryophytes","Butterflies","Hoverflies","Ladybirds")
# creating BD4
data_BD4 <- data_main%>%select(Location,all_of(remaining_species),Easting,Northing,
                                 dominantLandClass,ecologicalStatus,period)

BD4_mean <- rowMeans(data_BD4[,remaining_species],na.rm=TRUE)
# Adding a column for mean of the give 7 categories
data_BD4$BD4 <- BD4_mean
head(data_BD4)

# Also adding BD4 variable to the given_data data frame

given_data$BD4 <- data_BD4$BD4
head(given_data)

# now applying multiple linear regression 

# first applying regression model to all selected species

# Perform multiple linear regression
model <- lm(BD4 ~ Bees + Bird + Carabids + Isopods + Macromoths + 
              Grasshoppers_._Crickets + Vascular_plants, data = given_data)
#plot(model)
# Get p-values for each predictor variable
p_values <- summary(model)$coefficients[, 4]

# Perform feature selection by removing predictors with p-values above a certain threshold
threshold <- 6.592555e-34
significant_vars <- names(p_values[p_values < threshold])
final_model <- lm(BD4 ~ ., data = given_data[, c(significant_vars, "BD4")])
summary(final_model)
#plot(final_model)
library(MASS)
# Use stepwise regression with AIC as the criterion
step.model <- stepAIC(model, direction = "both", k = log(nrow(given_data)))

# View the summary of the final model
summary(step.model)

#_____________________________________________________

# Analyzing further data
hist(given_data$BD7)
round(sd(given_data$BD7),2)

Qs <- quantile(given_data$BD7,probs=seq(0,1,0.1))
str(Qs)

Best_eco <- given_data%>%filter(BD7>Qs[10])%>%
  group_by(dominantLandClass)%>%count()%>%arrange(desc(n))
boxplot(Best_eco$n)
Worst_eco <- given_data%>%filter(BD7<Qs[2])%>% 
  group_by(dominantLandClass)%>%count()%>%arrange(desc(n))
boxplot(Worst)


# there follows some analysis by land classification and period

mean_LC <- given_data%>%group_by(dominantLandClass)%>%
  summarise(LC_mean =mean(BD7))
hist(mean_LC$LC_mean)

given_data%>%group_by(dominantLandClass,period)%>%
  count()%>%arrange(desc(n))

area_dist <- given_data%>%group_by(dominantLandClass,period)%>%
  summarise(LC_mean =mean(BD7))%>%print(n=90)

library(tidyr) # for spliting on the period 
eco_changes <- given_data%>%group_by(dominantLandClass,period)%>%
  summarise(LC_mean =mean(BD7))%>%
  pivot_wider(names_from = period, values_from = LC_mean, values_fill = 0)

change_diver <- given_data%>%group_by(dominantLandClass,period)%>%
  summarise(LC_mean =mean(BD7))%>%
  pivot_wider(names_from = period, values_from = LC_mean, values_fill = 0)%>%
  mutate(eco_change=Y00-Y70)

given_data%>%group_by(dominantLandClass,period)%>%
  summarise(LC_mean =mean(BD7),.groups = 'drop')%>%
  pivot_wider(names_from = period, values_from = LC_mean, values_fill = 0)%>%
  mutate(eco_change=Y00-Y70)%>%
  arrange(desc(eco_change))%>%print(n=45)  # note 33 out of 45 eco_change< 0

# most of the data is below zero
boxplot(change_diver$eco_change)
mean(change_diver$eco_change)
#______________________________________

#calculating eco change country wise

given_data$country <- ifelse(grepl("e", given_data$dominantLandClass), "England",
                             ifelse(grepl("w", given_data$dominantLandClass), "Wales",
                                    ifelse(grepl("s", given_data$dominantLandClass), "Scotland", "")))

anyNA(given_data$country)

england_data <- subset(given_data,country=="England")
scotland_data <- subset(given_data,country=="Scotland")
Wales_data <- subset(given_data,country=="Wales")

change_diver_eng <- england_data%>%group_by(dominantLandClass,period)%>%
  summarise(LC_mean =mean(BD7))%>%
  pivot_wider(names_from = period, values_from = LC_mean, values_fill = 0)%>%
  mutate(eco_change=Y00-Y70)

change_diver_sco <- scotland_data%>%group_by(dominantLandClass,period)%>%
  summarise(LC_mean =mean(BD7))%>%
  pivot_wider(names_from = period, values_from = LC_mean, values_fill = 0)%>%
  mutate(eco_change=Y00-Y70)

change_diver_wal <- Wales_data%>%group_by(dominantLandClass,period)%>%
  summarise(LC_mean =mean(BD7))%>%
  pivot_wider(names_from = period, values_from = LC_mean, values_fill = 0)%>%
  mutate(eco_change=Y00-Y70)

boxplot(change_diver_eng$eco_change,xlab="England",ylab="Ecological Change")
a <-mean(change_diver_eng$eco_change)
points(a, col = "red", pch = 19)

boxplot(change_diver_sco$eco_change,xlab="Scotland",ylab="Ecological Change")
b<-mean(change_diver_sco$eco_change)
points(b, col = "red", pch = 19)

boxplot(change_diver_wal$eco_change,xlab="Wales",ylab="Ecological Change")
c<-mean(change_diver_wal$eco_change)
points(b, col = "red", pch = 19)

#mean loss of biodiversity in england , scotland and wales
round(a,3) ; round(b,3) ; round(c,3)

# percentage change in areas in terms of biodiversity

england_change <- sum(change_diver_eng$eco_change<0)/length(change_diver_eng$eco_change) *100

scotland_change <- sum(change_diver_sco$eco_change<0)/length(change_diver_sco$eco_change) *100

wales_change <- sum(change_diver_wal$eco_change<0)/length(change_diver_wal$eco_change) *100

############


# load required packages
library(ggplot2)

# creating a dataset data and changing variable in it to not change the data of the original variables
data <- given_data
data$easting <- data$Easting
data$northing <- data$Northing
data$species_richness <- data$BD7


# create scatterplot of species richness vs. easting and northing
map<-ggplot(data, aes(x = easting, y = northing, color = species_richness)) + 
  geom_point() + 
  scale_color_gradient(low = "green", high = "red") + 
  labs(title = "Species Richness by Location", x = "Easting", y = "Northing")
ggplotly(map)

# perform linear regression of ecological diversity against easting and northing
model <- lm(species_richness ~ easting + northing, data = data)
summary(model)


