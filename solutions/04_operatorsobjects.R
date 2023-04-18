# solutions:

# Task 1 -----------------------------------------------------------------------
# Take a look at the `iris` data set we worked with in the previous practical.
data(iris)
str(iris)

# What are the 3 different Iris species?    
unique(iris$Species)

# What were the longest and shortest sepal lengths measured in the survey? 
min(iris$Sepal.Length) 
max(iris$Sepal.Length) 
summary(iris) # different way

# Task 2 -----------------------------------------------------------------------
# Make a random subset of the `iris` data set. Randomly sample `n=30` rows. 
# Hints: make a sequence ranging from 1 to the number of rows in `ìris`, use `sample` to draw a random subset and use the resulting vector as index vector to subset the rows of `iris`. 

# sequence
# you can look up the number of rows in different ways:
# 1) check the number of observations for iris when you look in the environment tab
# 2) use str() to get the dimensions of the data set
# 3) look up possible function online to figure out the number of rows in a data set (-> nrow())

# there are, again, different ways to approach this.

# Long version:
# different ways to define the sequence:
seq_I <- seq(from = 1, to = 150, by = 1)        # named arguments
seq_I <- seq(1,150,1)                           # unnamed, be careful with the input order!
seq_I <- seq(from = 1, to = nrow(iris), by = 1) # use the output of nrow(iris) as direct input in the seq() function

# create index vector
A <- sample(seq_I, size = 30)

# create subset using the predefined rows
iris_30 <- iris[A,]


# shorter version
# create index vector
A <- sample(1:nrow(iris), size=30)
# create subset using the predefined rows
iris_30 <- iris[A,]


# Task 3 -----------------------------------------------------------------------
# airquality data set
data("airquality")

# What is the structure of the data set? Which variables were measured? 
str(airquality)
# or
names(airquality)

# In which city and year were these variables measured? Add this information as additional columns `city` and `year`
airquality$city <- "New York"
airquality$year <- 1973

# Are there any missing values? 
is.na(airquality$Ozone) # can be done for every column
# or
summary(airquality) # quicker way to get an overview

# Select only those measurements where you have information on all variables and store it in another object.
airquality2 <- na.omit(airquality)

# Calculate the mean ozone concentration with and without accounting for missing values.
mean(airquality$Ozone)
mean(airquality2$Ozone)

# What was the mean temperature in May? Was it colder or warmer than in September?
mean(airquality$Temp[airquality$Month == 5])
mean(airquality$Temp[airquality$Month == 9])
# or
mean(airquality$Temp[1:31])     # May (colder)
mean(airquality$Temp[124:153])  # September