# Task 1: Create a sample with `n = 1000` draws from the log-normal distribution. <!-- This makes them think about another distribution, they will have to figure out how to parametrize (if there are no defaults) and draw a sample. -->
  
s <- rlnorm(n=1000) # default parameters
x <- 1:100

curve(dlnorm(x), 0, 100, col = "red",lwd = 2) # default parameters
hist(s, add = TRUE, col = NULL, freq = FALSE)

# Task 2: Use the sample to estimate the parameters of the density function you applied for the random draw. Do these estimated parameters differ from the ones you specified to draw the sample? (Hint: you can use the R documentation for the log-normal function or try google to work out how to calculate the parameters from your samples)

mean(log(s)) # the mean of the logs, should approximate 1
sd(log(s)) # the sd of the logs, should approximate 0

