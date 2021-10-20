#' ---
#' "Simple data wrangling"
 

#' R offers different options for inspecting, subsetting and manipulating data. We use the iris data that is contained in the R distribution
#' 
data(iris)

# Inspect the first five lines
head(iris)

# Inspect the last five lines
tail(iris)

# Check data structure:
str(iris)

#' 
#' # 1 - Extract data
#' 
#' We have already seen how to subset columns by indexing:
#' 
iris[, c('Petal.Length')]
summary(iris[, c('Petal.Length')])

#' 
#' Rows can also be extracted using indexing, or by using the function `subset()`. Here, we need the logical and relational operators mentioned earlier
# selecting rows using indexing
iris[iris$Species == 'virginica', ]
iris[iris$Species == 'virginica' & iris$Sepal.Length > 6.5, ]

# selecting rows using subset
subset(iris, Species == 'virginica')
subset(iris, Species == 'virginica' & Sepal.Length > 6.5)

#' 
#' # 2 - Join/merge data
#' When processing data, it is often necessary to join/merge different data sets. As a simple example, we create two data frames, one with a price list for groceries and one with our shopping list.
#' 
prices_market <- data.frame(product=c('apples', 'tomatoes', 'blueberries', 'strawberries'), price_per_kg = c(2.5, 3.5, 5.20, 4.50))
shopping_list <- data.frame(product = c('apples', 'strawberries', 'bananas'), amount_in_kg = c(1.5, 0.5, 2))

#' 
#' We now use the function `merge()` for joining the two data frames. Thereby, we have the option of ignoring non-matching entries or filling these up with NAs.
# The joined data frame contains only matching entries:
merge(prices_market, shopping_list, by = 'product')

# NAs will be added for the non-matching entries
merge(prices_market, shopping_list, by = 'product', all = TRUE)

#' 
#' # 3 - Family `apply`
#' If you want to do complex operations on matrices, data frames or lists, `apply()` and its derivates are most often the tool of choice as they run a lot faster than loops. This is what is often termed *vectorizing* your code.
#' 
#' `apply()` allows row-wise and column-wise execution of functions over matrices, data.frames and arrays. Thereby, the argument `MARGIN` refers to the dimension you want the operation to run over (1 means row-wise, 2 column-wise). Also you have to provide an argument `FUN` that specifies which function you want to run over the array. In the following examples, we calculate the mean.
# Build a numeric matrix
(Xmat = matrix(1:12, nrow = 4))

# Calculate the mean of all rows
apply(Xmat, 1, mean)

# Calculate the mean of all columns
apply(Xmat, 2, mean)

#' 
#' You can also define own *anonymous* functions in the form `FUN=function(x){...}`.
(Xdf <- data.frame(x = rep(1, 10), y = rep (3, 10)))

apply(Xdf, 1, FUN = function(x) {sum(x) ^ 2})

#' 
#' Also check out ``lapply()` and `sapply()` that are useful functions for operations over vectors or lists. 
#' 
#' ## 3.1 - rowSums(), rowMeans() etc
#' There are some convenient and fast implementations to form row and column sums and means for numeric matrices (or arrays) and data frames. They are equivalent to using the function `mean` or `sum` with `apply()` as above but probably easier to handle for you.
#' 
# Calculate the mean and sum of all rows
rowMeans(Xmat)
rowSums(Xmat)

# Calculate the mean and sum of all columns

colMeans(Xmat)
colSums(Xmat)

# Get unique entries (meaningful when you have recurring categories)

unique(Xmat[,1])


#' 
#' # 4 - Manipulate data
#' 
#' ## 4.1 - Analyse data by groups
#' `aggregate()` lets you calculate summaries of groups of your data. The grouping can be expressed with the `by` argument, but you can also use a formula syntax. In both cases, you can also summarize by multiple grouping variables. The function returns a data frame containing the calculated summaries for each group. You can think of the function as "summarizing variable x by groups Z, using function f".
#' 

# calculate standard deviation and mean of the petal length for each iris species

# grouping via "by" argument
aggregate(iris$Petal.Length, by = list(iris$Species), FUN = 'mean') # mean
aggregate(iris$Petal.Length, by = list(iris$Species), FUN = 'sd') # standard dev

# grouping via formula syntax
aggregate(Petal.Length ~ Species, data = iris, FUN = 'mean') # mean
aggregate(Petal.Length ~ Species, data = iris, FUN = 'sd') # mean

# user-defined function: calculating the percentage of flowers with petals longer than 4.5 cm within each species
aggregate(Petal.Length ~ Species, data = iris, FUN = function(x) length(which(x > 4.5))/length(x) * 100)


#' 
#' 
#' ## 4.2 - Manipulating character strings
#' 
#' Manipulation of strings is important for piecing together character strings, e.g. for automatically processing a list of files, for generating formulas, or when you want to add text or mathematical annotations to a plot. Here are some useful functions for string manipulations:
#' 
#' - `paste()`: Concatenate vectors after conversion to character
#' - `strsplit()`: Split characters strings into substrings
#' - `nchar`: Count number of characters
#' - `grep()`: Pattern matching
#' - `sub()`, `gsub`: Pattern replacement
#' - `substr()`, `substring`: Extract or replace substrings
#' - `toupper()`, `tolower()`: Translate characters from lower to upper case and vice versa
#' 
#' Let's take a look at some examples.
#' 
# make variable names
(varnames <- paste('Variable', 1:10, sep='_'))

# Split variable names at the underscore
strsplit(varnames[1:2],'_')

# Replace an expression
sub('Variable','Covariate',varnames)

# Find variable 10
grep('10', varnames) # finds index
grep('10', varnames, value=T) # returns name
