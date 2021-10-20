#' ---
#' "Visualising data"

#' 
#' # 1 - Base graphics in R 
#' 
#' R has many base functions for plotting graphics. So-called *high-level* graphic functions produce complete, independent graphics such as boxplots, histograms or scatterplots along with axes labels and titles. You can modify these according to your needs by optional arguments, e.g. labels, line widths, point symbols, colours.
#' 
#' The built-in iris data set contains 50 samples of the length and the width of sepals and petals of three iris species (Iris setosa, Iris virginica and Iris versicolor), in centimeters.
str(iris)

#' 
#' Now, make very simple scatterplots using only the data for I. setosa.
# create subset for I. setosa
setosa <- iris[iris$Species == "setosa", ]

# explicitly provide x and y axis
plot(x = setosa$Sepal.Width, y = setosa$Sepal.Length)

# formula method
plot(Sepal.Length ~ Sepal.Width, data = setosa)

#' 
#' You can customize the plot with various options. See `?par` for options.
plot(x = setosa$Sepal.Width, y = setosa$Sepal.Length, pch = 19, col = 'salmon',
     xlab = 'Sepal width [cm]', ylab = 'Sepal length [cm]',
     main = 'Relationship between I. setosa sepal width and length')

#' 
#' You can change the plot type using  the `type` argument.
plot(setosa$Sepal.Length, type = 'l')

#' 
#' Histograms and boxplots:
# open a new graphic device
# under Windows OS it should be "windows()", under linux "x11()"
quartz(w = 6, h = 6)

hist(setosa$Sepal.Length)
boxplot(iris$Sepal.Length ~ iris$Species) # (includes all species)

#' 
#' So-called *low-level* graphic functions let you add certain elements to existing plots, e.g. lines, labels, legends etc. Also, you can make mathematical annotations (`?plotmath`).
# Set the plot margin size; see "?par"
par(mar = c(5, 4, 4, 4) + 0.1)

plot(x = setosa$Sepal.Width, y = setosa$Sepal.Length, pch = 19, col = 'salmon',
     xlab = 'Width [cm]', ylab = 'Length [cm]',
     main = 'Relationship between I. setosa sepal width and length',
     ylim = c(0, max(setosa$Sepal.Length)),
     xlim = c(0, max(setosa$Sepal.Width))
)

# add regression line
abline(lm(setosa$Sepal.Length ~ setosa$Sepal.Width), col = 'salmon3', lwd = 2)

# add points
points(x = setosa$Petal.Width, y = setosa$Petal.Length, col = 'CornFlowerBlue', pch = 19)
abline(lm(setosa$Petal.Length ~ setosa$Petal.Width), col = 'blue3', lwd = 2)

# add legend
legend("bottomright", 
       legend = c("Sepals", "Petals"), 
       col = c("salmon", "CornFlowerBlue"), 
       pch = c(19, 19))


#' 
#' # 2 - Plotting with `ggplot2`
#' 
#' `ggplot2` is a visualisation library that allows more elegant and versatile plotting. It follows quite a different philosophy than base graphics. Plots are built step by step. This basic template can be used for different types of plots:
#' 
#' `ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()`
#' 
library(ggplot2)

#' 
#' The ggplot() function binds the plot to a specific data frame using the data argument.
#' 
ggplot(data = iris)		# this provides a blank ggplot object

#' 
#' Using the aesthetic function `aes()` we can define the geometric and statistical objects (color, size, shape, and position).
p <- ggplot(data = iris, mapping = aes(x = Sepal.Width, y = Sepal.Length))

#' 
#' Using the `geom_` functions, we can add the geometric shapes representing the data, e.g.:
#' - `geom_point()` for scatter plots, dot plots, etc.
#' - `geom_boxplot()` for boxplots
#' - `geom_line()` for trend lines, time series, etc.
#' 
p + geom_point()

# you can also do it in one go
ggplot(data = iris, mapping = aes(x = Sepal.Width, y = Sepal.Length)) + geom_point()


#' 
#' We can modify this plot by adding colours, transparency etc.
p + geom_point(color = 'salmon')

# add transparency:
p + geom_point(color = 'salmon', alpha = 0.5)

# assign different colours to different Iris species
p + geom_point(aes(color = Species))


#' 
# assign different symbols to Iris species:
p + geom_point(aes(color = Species, shape = Species))

#' 
#' Add a linear model or Loess smoother (only I. setosa):
# regression line:
p <- ggplot(data = setosa, mapping = aes(x = Sepal.Width, y = Sepal.Length))
p + geom_point() + geom_smooth(method="lm")

#' 
# smoother:
p + geom_point() + geom_smooth(method = "loess")

#' 
#' Boxplot:
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_boxplot()
