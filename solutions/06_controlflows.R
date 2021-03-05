# Task 1: Write a simple function that returns the number of months after which an annual streaming subscription becomes cheaper than paying monthly, for any monthly and annual subscription price.


no_months <- function(annual, monthly){
  return(floor(annual/monthly))
}
no_months(annual = 120, monthly = 32)

# Task 2: Use the lognormal default parameters to make 10 draws each of sizes `n = 500`, `n = 50` and `n = 5`. For each random draw, calculate the distribution parameters (this is called *bootstrapping*). Compare the parameters estimated from your draws with the default parameters. What do you observe between different sample sizes? (hint: you can use a for loop to make draws and estimate parameters for each draw. Think about a good way to store the *estimated* parameters so you can compare them easily with the ones you initially *specified*). <!-- This teaches them to build a for loop for a very simple bootstrapping routine and come up with a simple data structure to store results.-->

result <- matrix(NA, nrow = 50, ncol = 6)
ndraws <- c(5, 10, 500)

for(i in 1:50){
  
  # n = 5
  draw <- rlnorm(5)
  result[i,1] <- mean(log(draw))
  result[i,2] <- sd(log(draw))
  
  # n = 10
  draw <- rlnorm(10)
  result[i,3] <- mean(log(draw))
  result[i,4] <- sd(log(draw))
  
  # n = 500
  draw <- rlnorm(500)
  result[i,5] <- mean(log(draw))
  result[i,6] <- sd(log(draw))
}

# Get the differences of the means of the estimated pars from the defualts
abs(round(c(0, 1) - colMeans(result), 3))
