# STA220 Week 4 R Code

# Creating Plots in R

# Follow the code created last week to read in the life expectancy dataset posted on Quercus
# Reminder: Set your working directory first!
life_exp <- read.csv("LifeExp.csv")

# This data has the following variables: 
# -> Country
# -> Region – One of: America, East Asia & Pacific, Europe & Central Asia, Middle East & North Africa, South Asia, Sub-Saharan Africa
# -> LifeExp — The country’s life expectancy in 2012, in years
# -> GDP — The country’s Gross Domestic Product per capita in 2012
# -> HIV – Percentage of adults aged 15-49 with HIV

# BOXPLOT
# Format: boxplot(a vector of data)
boxplot(life_exp$LifeExp)

# You can add more to this plot 
# -> ylab specifies the y-axis label
# -> ylim specifies the limits of the y-axis
# -> main specifies the title
# -> col specifies the colour (https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf)
# -> horizontal is a TRUE/FALSE to specify the orientation

boxplot(life_exp$LifeExp, ylab="Life Expectancy",ylim=c(0,86), 
        main="Boxplot for Life Expectancy", col='forestgreen')

# HISTOGRAM
# Format: hist(a vector of data)

# You can add more to this plot 
# -> xlab specifies the x-axis label
# -> ylab specifies the y-axis label
# -> xlim specifies the limits of the x-axis
# -> ylim specifies the limits of the y-axis
# -> main specifies the title
# -> col specifies the colour 
# -> breaks specifies the number of breaks, impacting the number of bins

hist(life_exp$LifeExp, xlab = "Life Expectancy (years)",
     main = "Histogram of Life Expectancies")


# BAR PLOT
# Format: barplot(vector of bar heights, vector of labels)

barplot(height = c(1,2,3,5), names.arg = c("Group 1", "Group 2", "Group 3", "Group 4"))

# With real data, the vector of bar heights and labels may need to be created first

#Step 1: Create the counts you want reflected on the bar plot
counts = table(life_exp$Region)

#Step 2: Create a vector of the labels
region_names = c("Americas", "E.Asia&Pc", "Eur&C.As",
                 "M.E&N.Afr","S.Asia", "S-S.Africa")

#Step 3: Create the bar plot
barplot(height = counts, names.arg = region_names,
        main = "World Regions: Bar Plot", xlab="Regions", ylab="Count")

# You can also create a vector of colours for the bars

col1 <- c("steelblue", "firebrick", "forestgreen", "steelblue", "firebrick", "forestgreen")
col2 <- rainbow(6)

barplot(height = counts, names.arg = region_names, col=col2,
        main = "World Regions: Bar Plot", xlab="Regions", ylab="Count")

# You can also rotate it using horiz=TRUE

barplot(height = counts, names.arg = region_names, col=col1,
        main = "World Regions: Bar Plot", ylab="Regions", xlab="Count", horiz = TRUE)
