
# The recent R package `nycflights13` [@Wickham2019] contains data of all flights that departed New York in 2013. You can find some parts of the data set in the course repository in `/data`. Alternatively, the data is also available directly through the `nycflights13` package. 

# Task 1: Download and import the `flights` data. Explore the data set (Hint: use `str()` to understnad how the dat set is structured).
weather <- readRDS("data/nycflights13_weather.rds")
flights <- readRDS("data/nycflights13_flights.rds")
planes <- read.csv("data/nycflights13_planes.csv")
airlines <- read.table("data/nycflights13_airlines.txt")

#- How many NYC airports are covered in the data set?  
unique(flights$origin)

#  - How many domestic flights departed from each NYC airport? 
table(flights$origin)

#  - How many different airlines departed from New York? 
length(unique(flights$carrier))
nrow(airlines)

#  - What were the first and last recorded departure times on each NYC airport in 2013, which airlines conducted the respective flights and what where the destinations?  
# First
head(flights[flights$origin == "JFK",],1)
head(flights[flights$origin == "EWR",],1)
head(flights[flights$origin == "LGA",],1)

# Last, need to order first because of spetember
flights <- flights[order(flights$time_hour),]
tail(flights[flights$origin == "JFK",],1)
tail(flights[flights$origin == "EWR",],1)
tail(flights[flights$origin == "LGA",],1)

#  - Which airlines had the highest proportion of delayed flights? Which airports had the highest proportion of delayed flights? Which destinations were affected? (hint: you can define a function to calculate the proportion of delayed flights in all flights and apply that function to different groups of the data set, using `aggregate()`.

# First we need a funciton to calculate the proportion of delays

prop_delayed <- function(x) {
  length(which(x>0))/length(x)
}

# airlines
aggregate(flights$dep_delay, by = list(flights$carrier), FUN = prop_delayed)

# airports
aggregate(flights$dep_delay, by = list(flights$origin), FUN = prop_delayed)

# destinations
aggregate(flights$dep_delay, by = list(flights$dest), FUN = prop_delayed)

# Task 2: Visualise flight delays.  

# How did daily flight delays vary throughout the year 2013? Are there seasonal patterns? (hint: calculate the mean departure delay for each day, make a time series plot and add a smooth line to the plot)
flights_agr <- aggregate(flights$dep_delay, by = list(year = flights$year, month = flights$month, day = flights$day, airport = flights$origin), FUN = function(x) {mean(x[x>0], na.rm = TRUE)})
flights_agr$date <- as.Date(with(flights_agr, paste(year, month, day,sep="-")), "%Y-%m-%d")

ggplot(flights_agr, aes(x = date, y = x, col = airport)) + geom_point() + geom_smooth()

# plot a summary of delays for each airport. Are there differences?  (hint: which plot type provides statistical summaries of data?)
str(flights)
ggplot(flights_agr, aes(x = airport, y = x)) + geom_boxplot()

# plot a summary of delays for short-haul (less than 700 mi), medium-haul and long-haul (more than  3,000 mi) flights across all airports. Are there differences? (Hint: to group your data for plotting. You first need to create a column that flags which haul-category each flight belongs to.)  
flights$haul <- NA
flights$haul[which(flights$distance < 700)] <- 1
flights$haul[which(flights$distance >= 700 & flights$distance < 3000)] <- 2
flights$haul[which(flights$distance >= 3000)] <- 3

flights$haul <- as.factor(flights$haul)
ggplot(flights, aes(x = origin, y = log(dep_delay), col = haul)) + geom_boxplot()


# Task 3: What are factors influencing flight delays? (hint: you need to download and import other parts of the `nycflights13` data set, check the course repo)

flights_weather <- merge(flights, weather)
str(flights_weather)

ggplot(flights_weather, aes(x = wind_speed, y = dep_delay)) + geom_smooth()
ggplot(flights_weather, aes(x = temp, y = dep_delay)) + geom_smooth()
ggplot(flights_weather, aes(x = humid, y = dep_delay)) + geom_smooth()
ggplot(flights_weather, aes(x = visib, y = dep_delay)) + geom_smooth()

# Task 4: Useful functionss.

# - write a function that converts from miles to km  
mile_to_km <- function(x) {
  x * 1.60934
}

# - write a function that converts a value from Fahrenheit to Celsius 
f_to_c <- function(x) {
  (x - 32)/1.8
}

# - apply both functions to convert `distance` from miles to km and `temp` from Fahrenheit to Celsius (hint: you already learned about two ways to apply a function to a whole column and not just a single value)  

flights_weather$distance <- mile_to_km(flights_weather$distance)
flights_weather$temp <- f_to_c(flights_weather$temp)