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
