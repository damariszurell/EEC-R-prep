# solutions:
# load required library
library(ggplot2) # not needed if you only work with base plots

# Task 1 -----------------------------------------------------------------------

# Create a subset for *I. versicolor* and plot correlation between petal width and length with base r graphics. Include a regression line and make sure axis titles are meaningful.  
# Add points for I. setosa and I. virginica. (hint: when you add values the x and y-axis range isn't adjusted and some values might not be shown. Adjust the x and y axis ranges to make sure all values are shown. Use the `ylim` argument in the `plot()` function for this.)
# Add a legend

# create subsets for all species 
versicolor <- subset(iris, Species == "versicolor")
setosa <- subset(iris, Species == "setosa")
virginica <- subset(iris, Species == "virginica")

plot(x = versicolor$Petal.Width, y = versicolor$Petal.Length, pch = 19, col = 'salmon',
     xlab = 'Petal width [cm]', ylab = 'Petal length [cm]',
     main = 'Relationship between I. versicolor petal width and length',
     xlim = c(0,max(versicolor$Petal.Width)),
     ylim = c(0,max(versicolor$Petal.Length)))

# add regression line
abline(lm(versicolor$Petal.Length ~ versicolor$Petal.Width), col = 'salmon3', lwd = 2)

# add points for the other species
# remember: you'll learn how to work wothout attach() later on
points(x = setosa$Petal.Width, y = setosa$Petal.Length, col = 'CornFlowerBlue', pch = 19)

points(x = virginica$Petal.Width, y = virginica$Petal.Length, col = 'darkgrey', pch = 19)

# add a legend
legend("bottomright", 
       legend = c("I. setosa", "I. virginica", "I. versicolor"), 
       col = c("CornFlowerBlue", "darkgrey", "salmon"), 
       pch = c(19, 19, 19))

# ggplot version
ggplot(iris, aes(x = Petal.Width, y = Petal.Length, col = Species)) +
  geom_point() +
  xlab("Petal width") +
  ylab("Petal length")+
  theme_bw() # you can change the background etc. with different theme settings
  

# Task 2 -----------------------------------------------------------------------
# Take a look at the built-in data set ChickWeight. Plot the results of the experiment in a way that shows 
# the potential effect of diet on the early growth of chicks. Hint: use a boxplot!

data("ChickWeight")

# check out the data set 
str(ChickWeight)

# ggplot version
# be careful to spell the column names the same way as they are written within the data set! 
ggplot(ChickWeight, aes(x = Diet, y = weight, fill = Diet))+
  geom_boxplot()
  
# base plot version:
boxplot(weight~Diet, data=ChickWeight) 
