# Session 2: Operators and objects


# Task 1: 

data(iris)
str(iris)

# three iris species
str(iris$Species)

# What were the longest and shortest sepal lengths measured in the survey?
min(iris$Sepal.Length)
max(iris$Sepal.Length)
summary(iris)

# Task 2:
# airquality

# What is the structure of the data set? Which variables were measured? 
str(airquality)

# In which city and year were these variables measured? Add this information as additional columns `city` and `year`
airquality$city <- "New York"
airquality$year <- 1973

# Are there any missing values? Select only those measurements where you have information on all variables and store it in another object.
airquality2 <- na.omit(airquality)

# Calculate the mean ozone concentration with and without accounting for missing values.
mean(airquality$Ozone)
mean(airquality2$Ozone)

# What was the mean temperature in May? Was it colder or warmer than in September?
mean(airquality$Temp[airquality$Month == 5])
mean(airquality$Temp[airquality$Month == 9])

