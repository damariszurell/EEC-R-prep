# Task 1: 
# Select I. versicolor and plot correlation between petal width and length with base r graphics. Include a regression line and make sure axis titles are meaningful.  
# create subset for I. setosa
versicolor <- iris[iris$Species == "versicolor", ]

# explicitly provide x and y axis

plot(x = versicolor$Petal.Width, y = versicolor$Petal.Length, pch = 19, col = 'salmon',
     xlab = 'Petal width [cm]', ylab = 'Petal length [cm]',
     main = 'Relationship between I. versicolor petal width and length',
     xlim = c(0,max(iris$Petal.Width)),
     ylim = c(0,max(iris$Petal.Length)))

# add regression line
abline(lm(versicolor$Petal.Length ~ versicolor$Petal.Width), col = 'salmon3', lwd = 2)

# add other species
setosa <- iris[iris$Species == "setosa", ]
virginica <- iris[iris$Species == "virginica", ]

points(x = setosa$Petal.Width, y = setosa$Petal.Length, col = 'CornFlowerBlue', pch = 19)
points(x = virginica$Petal.Width, y = virginica$Petal.Length, col = 'darkgrey', pch = 19)

# add legend
legend("bottomright", 
       legend = c("I. setosa", "I. virginica", "I. versicolor"), 
       col = c("CornFlowerBlue", "darkgrey", "salmon"), 
       pch = c(19, 19, 19))


# Save the graphic in folder `/graphics`.  
# They can save the image, open a quartz window and sve that or export straight using pdf, png etc.
  
# Task 2: Load the survey data set `data/surveys_pract3_correct.csv`.  

survey_data <- read.csv(file.path("data", "surveys_pract3_correct.csv"), header = TRUE, sep = ",", stringsAsFactors = TRUE)


# How do you want to deal with `NA` values? (?complete.cases) 
any(!complete.cases(survey_data))
# Kick them out
survey_data <- na.omit(survey_data)

# What could be interesting relationships?  ggplot
require(ggplot2)
str(survey_data)
p <- ggplot(data = survey_data, mapping = aes(x = weight, y = hindfoot_length, color = species_id))
p + geom_point() + theme_classic() + xlab("weight [kg]") + ylab("hindfoot length [cm]")


# Task 3: Let's have a look at mobility data in 2020 and 2021 compared to 2019. Download the data sets for [long distance public transport](https://damariszurell.github.io/EEC-R-prep/data/mobility_public_transport.csv) and [general daily mobility in the federal states of Germany](https://damariszurell.github.io/EEC-R-prep/data/daily_mobility_germany.csv). <!-- NOTE: include ref: https://www.destatis.de/DE/Service/EXDAT/Datensaetze/mobilitaetsindikatoren-mobilfunkdaten.html -->

# * Investigate both data sets: What information can you find in these data sets? What differences are there in the data sets? 
mobility_daily <- read.csv("data/daily_mobility_germany.csv")
mobility_pt <- read.csv("data/mobility_public_transport.csv")
str(mobility_daily)
str(mobility_pt)

# Which transport type denoted the biggest decrease compared to the same day in 2019? On which days?
min(mobility_pt$Train, na.rm = TRUE)
min(mobility_pt$Road, na.rm = TRUE)
min(mobility_pt$Flight, na.rm = TRUE)

f_min <- min(mobility_pt$Flight, na.rm = TRUE)

mobility_pt$Day[mobility_pt$Flight == f_min]

# Plot the change in long distance public transport for all types of transports in one graph. Make sure to have meaningful titles for the x- and y-axis. Include a legend for the three different types of public transport. Do you need to transform the column for 'Day'? Check `str()`. Google is your friend for solving this problem.

# Base method

str(mobility_pt)
mobility_pt$Day <- as.Date(mobility_pt$Day)
plot(x = mobility_pt$Day, y = mobility_pt$Road, ylim = c(-100, 15), type = "l", xlab = "Date", ylab = "Diff same day 2019 [%]")
lines(x = mobility_pt$Day, y = mobility_pt$Flight, lty = 2)
lines(x = mobility_pt$Day, y = mobility_pt$Train, lty = 3)
legend("topright", c("road", "flight", "train"), lty = c(1,2,3))

# Are there differences in the daily mobility between the different federal states of Germany? Which federal state had the strongest decrease? Is there even a state which had a strong increase?  

boxplot(mobility_daily$Daily.mobility ~ mobility_daily$State) # Mc pom



# Plot the change in daily mobility for each state. Is there a way to have a multi-panel plot so each state will appear in a single subplot? (hint: use the ggplot2 cheatsheet)

require(ggplot2)
mobility_daily$Day <- as.Date(mobility_daily$Day)
ggplot(mobility_daily, aes(x = Day, y = Daily.mobility)) + geom_line() + facet_wrap(~State) + xlab("d")

