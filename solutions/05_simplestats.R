# Task 1: Create a sample with `n = 1000` draws from the log-normal distribution. <!-- This makes them think about another distribution, they will have to figure out how to parametrize (if there are no defaults) and draw a sample. -->
  
s <- rlnorm(n=1000) # default parameters
x <- 1:100

curve(dlnorm(x), 0, 100, col = "red",lwd = 2) # default parameters
hist(s, add = TRUE, col = NULL, freq = FALSE)

# Task2: Make a random subset of the iris data set. 
# Randomly sample n=30 rows. Hints: make a sequence ranging from 1 to the number of rows in ìris, 
# use sample to draw a random subset and use the resulting vector as index vector to subset the rows of iris.

# create index vector
A <- sample(1:150, size=30)

# create subset using the predefined rows
iris_30 <- iris[A,]
