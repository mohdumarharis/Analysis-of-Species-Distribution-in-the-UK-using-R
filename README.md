# Analysis-of-Species-Distribution-in-the-UK-using-R
 Conducted data analysis and visualization of UK species distribution. - Applied statistical tests and regression models to examine ecological changes. - Produced insights for conservation efforts.

Report on Species Distribution in the UK
Section I
## Data Exploration
The given CSV file contains cleaned data which contains columns for different species of
flora and fauna like ‘bees’, ‘birds’, ‘Vascular Plants’, etc. There are total 11 species given
which are considered as important species for preservation in UK. Other columns include
Location- which is a categorical value of name of grid in which areas are divided , Dominant
Land class- in which type of land is described , Period- which is from 1970 to 2000 and
2000-2013 , Easting and Northing (coordinates for latitude and longitude), and Ecological
Status which contains mean of the population of all Species.
Total rows are 5280 containing 2640 distinct Locations, 45 different types of areas and two
periods. The data is collected to generate insights about species distribution among the area
and decreasing population of species from P70 to P00.
We create a separate data frame containing 7 given species and other columns and consider
that for further analysis. Categorical variables are converted into factors as those can be used
into analysis. The population given in this data is normalized as to make it easy to observe
and analyse. We add a column with ecological status for the given 7 species by taking mean
for that species.
Then we create a Table containing Species Name, their Mean, Standard Deviation, Skewness,
Kurtosis, Range Min and Range Max.
Here are some insights that can be drawn from this table:
• The mean values range from 0.55 for Isopods to 0.887 for Birds. This indicates that
Birds have the highest average value, while Isopods have the lowest.
• The standard deviation values range from 0.101 for Vascular plants to 0.311 for Bees.
This suggests that the data for Bees is more spread out than the data for Vascular
plants.
• "Skewness is a measure of the symmetry of the distribution." (“3.1. Discuss why you
did or did not create a bar chart for...”) A skewness value of 0 indicates a perfectly
symmetrical distribution. The skewness values in this table range from -1.507 for 

Birds to 0.958 for Bees. This indicates that the distribution of data for Birds is highly
skewed to the left, while the distribution for Bees is moderately skewed to the right.
• Kurtosis is a measure of the "peakedness" of the distribution. A kurtosis value of 0
indicates a perfectly normal distribution. The kurtosis values in this table range from -
1.139 for Macromoths to 7.052 for Birds. This indicates that the data for Birds has a
very high peak, while the data for Macromoths is relatively flat.
• The range of values for each type of animal/plant varies. For example, the range of
values for Birds is much larger (7.052) than the range for Isopods (2.355). This
suggests that there is more variability in the data for Birds than for Isopods.
The Box-Plots are plotted for each species for observing the distribution of data and the
information on the outliers present.
The species Richness in each area can also be calculated by grouping the data on the basis of
location and counting the observations.
## CORRELATION
Correlation can be calculated on the numerical columns of the dataset and a corrplot can be
plotted. The correlation table that shows the correlation coefficients between different
variables.
Some Insights from the table-
• Bees, bird, and Macromoths have higher correlations with ecological Status and
selected_ecostatus, indicating that these species may be important indicators of
ecosystem health.
• Carabids and Crickets have higher correlations with each other, as well as with
Isopods, suggesting that these species may share similar habitat requirements.
• Vascular plants, Easting, and Northing have low correlations with most of the other
variables, indicating that they may not strongly influence the distribution or
abundance of the animal species.
• There is a small difference seen in correlation
of new variable of ecological status and old
variable of ecological status with species which
shows that removing the data of other four
species have resulted in significant changes
in the value of new ecological status.

## Hypothesis Tests
To perform two distinct types of hypothesis tests, we need to formulate two hypotheses and
choose appropriate statistical tests.
1. Here is the First TestHypothesis 1: There is a significant difference in mean ecological status between the two
periods (Y70 vs Y00 ).
Null Hypothesis: There is no significant difference in mean ecological status between the two
periods.
Alternative Hypothesis: There is a significant difference in mean ecological status between
the two periods.
Statistical Test: Two-sample t-test for independent samples.
The first hypothesis test is a two-sample t-test that compares the mean ecological status of the
species between two different periods: P70-P00 and P00-P13. The null hypothesis is that
there is no significant difference in the mean ecological status between the two periods, while
the alternative hypothesis is that there is a significant difference in the mean ecological status
between the two periods.
The result of the t-test shows that the t-value is 9.6309 with 5278 degrees of freedom, and the
p-value is less than 2.2e-16, which is extremely small. This means that we can reject the null
hypothesis and conclude that there is a significant difference in the mean ecological status
between the two periods. The sample means of ecological status for period1 and period2 are
0.7174392 and 0.6866247, respectively.
The 95 percent confidence interval for the difference in means between the two periods is
[0.02454204, 0.03708694]. This indicates that the mean ecological status in the later period
(P00-P13) is lower than that in the earlier period (P70-P00) by an amount ranging from
0.02454204 to 0.03708694.
This result suggests that there has been a significant decline in the ecological status of the
species between the two periods, indicating a potential decrease in the population of the
species. It could be due to a variety of factors such as habitat loss, climate change, pollution,
and other anthropogenic activities. Further investigation is required to determine the exact
cause of this decline and to develop appropriate conservation measures to prevent further
decline in the population of these species.

2. Here is the Second TestHypothesis test for correlation between two variables:
Null hypothesis: There is no correlation between the number of bees and the number of bird
species.
Alternative hypothesis: There is a correlation between the number of bees and the number of
bird species.
ResultThe Pearson's correlation test result shows that there is a significant positive correlation
(correlation coefficient, r = 0.3759451) between the population of bees and birds in the given
dataset. The p-value obtained is less than the significance level of 0.05, which indicates that
the correlation is statistically significant, and we reject the null hypothesis that the true
correlation is equal to zero.
P value is less than 2.2e-16.
The 95% confidence interval (0.3525459, 0.3988744) suggests that we can be 95% confident
that the true correlation between bees and birds population in the population lies within this
interval.
These insights suggest that the population of bees and birds might be positively associated,
meaning that an increase in the population of bees may lead to an increase in the population
of birds. This information can be useful for conservation efforts, as increasing the population
of bees can have a positive impact on the population of birds and other species that depend on
them.
Section III
Simple Linear Regression
Applying linear regression on BD7 and BD11.
Results-
• The regression equation is given by:
BD11 = 0.090938 + 0.889447*BD7
Green Line is Regression line

• The intercept of 0.090938 is the expected value of BD11 when BD7 is equal to zero.
The coefficient of 0.889447 indicates that for every unit increase in BD7, BD11 is
expected to increase by 0.889447 units.
• The p-value of the F-statistic is less than 2.2e-16, which is highly significant. This
indicates that the model as a whole is significant and the predictor variable BD7 has a
strong relationship with the response variable BD11.
• The multiple R-squared value of 0.9315 indicates that the model explains 93.15% of
the variation in BD11, while the adjusted R-squared value is the same as the multiple
R-squared value because there is only one predictor variable.
• The residual standard error of 0.02828 indicates that the model has a good fit to the
data, and the residuals have a mean of zero and constant variance.
In conclusion, the model suggests a strong positive relationship between BD11 and BD7,
indicating that the ecological status of the selected 7 species has a strong association with the
ecological status of all 11 species.
Then we apply regression on the ecological status data separated by periods ,

The results show the regression analysis of the relationship between BD7 and BD11 for two
different time periods - Y00 and Y70.
For the Y00 period, the intercept and coefficient estimates are 0.109660 and 0.872912,
respectively. The coefficient is statistically significant with a very low p-value of < 2.2e-16,
indicating a strong positive linear relationship between BD7 and BD11 during this period.
The R-squared value is 0.9348, indicating that BD7 can explain 93.48% of the variation in
BD11 during this period.
Similarly, for the Y70 period, the intercept and coefficient estimates are 0.053950 and
0.930733, respectively. The coefficient is also statistically significant with a very low p-value
of < 2.2e-16, indicating a strong positive linear relationship between BD7 and BD11 during
this period. The R-squared value is 0.9394, indicating that BD7 can explain 93.94% of the
variation in BD11 during this period.
Reg No. 2205006
Overall, the results suggest that there is a strong positive linear relationship between BD7 and
BD11, and this relationship holds for both periods analyzed.
