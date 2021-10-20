#' ---
#'"Control flows - ifelse, loops and functions"

#' # 1 - Control flows
#' Control-flow constructs are among the most important *building blocks* in programming because they help structuring the workflow. We use loops for repeating workflows, and conditional expressions and switch statements for making choices between alternative control flows based on some conditions.
#' 
#' ## 1.1 If, else, ifelse
#' We use conditional expressions if specific computations and actions should only be performed under certain conditions. R knows three conditional expressions: 
#' 
#' - `if (condition) {command block}`
#' - `if (condition) {command block} else {alternative command block}` 
#' - `ifelse (condition, command block, alternative command block)` 
#' 
#' These functions always require a Boolean condition, meaning that it needs to evaluate to `TRUE` or `FALSE`. Single commands do not need to be surrounded by curly brackets. Still, for beginners, they facilitate overview. 

## -----------------------------------------------------------------------------------------------------------------------------
a <- 12

if (a >= 10)
{
  print("a is greater than or equal to 10")
}

## -----------------------------------------------------------------------------------------------------------------------------

a <- 12

if (a >= 10)
{
  print("a is greater than or equal to 10")
} else {
  print("a is smaller than 10")
}

#' 
#' Conditional expressions may be nested, meaning that another if-clause follows on an existing one (`else if`).
if (a > 10) {
  print("a is greater than 10")
} else
  if (a == 10) {
    print("a is equal to 10")
  } else {
  print("a is smaller than 10")
}


#' 
#' Another example:
# Should I renew my streaming subscription, and if so by one month for a whole year?

no_weeks <- 6 # number of remaining lockdown weeks
if (no_weeks < 4) {
  renew <- "No"
} else 
  if (no_weeks >= 4 & no_weeks < 8) {
    renew <- "By a month and then see"
  } else {
    renew <- "By a whole year"
  }

renew

#' 
#' The function `ifelse()` allows elementwise evaluation of the condition. 
age <- 31
ifelse (age <= 30, "I am 30 or younger", "I'm older than 30")


#' 
#' `ifelse()` is most useful for evaluating elements of a vector according to a specific condition. We illustrate this by just slightly changing above example to see how many participants in (a hypothetical) class are younger or older than 30 years.
(ages <- sample(22:35, 30, replace = TRUE))
(age_groups <- ifelse (ages <= 30, "Younger than or just 30", "Older than 30"))

# table() allows you to count how many entries in an object exist for unique cases
table(age_groups)

#' 
#' # 2 - For-Loops
#' You will often hear that loops should be avoided in R code wherever possible because in certain cases they can make your code slower. Nevertheless, they are an important element in programming. We use them, for example, for iterating (parts of) code blocks with different parameters or initial values. R offers three different loop structures: `repeat`, `while` and `for`, where the latter is the most commonly used.
#' 
#' The `for` loop iterates through all elements of a provided vector: `for (i in M) {command block}`. See the help page `?"for"`.
#' 
#' Below, we show two different ways of defining the vector that the `for` loop cycles through. In the first example, the vector is defined first and the loop cycles through each element of the vector. In the second example, we define the vector in the call of the `for` loop by `1:length(x)`. This expression means that we cycle through all indices of the vector `x` from index 1 to the last. (Note that the loop could also start at any other index value, e.g. `3:length(x)`)

x <- c(101:120)

# Option 1: cycle through each element of x
for (i in x) {
  print(i)
}

# Option 2: cycle through the indices of x
for (i in 1:length(x)){
  print(i)
}

#' 
#' Now, we use `for` loops to roll dices.

x <- c(1:100)
# roll a dice 100 times and print result into console
for (i in x) {
  print(sample(1:6, 1))
}

# roll a dice 100 times and build the cumulative sum of the faces. For this define an empty vector y that stored the comulative sums.
y <- numeric(length(x))
for (i in 1:length(x)){
  y[i] <- sample(1:6, 1) + y[i-1]
}
y

# Stop rolling the dice as soon as the cumulative sum is higher than 150
y <- numeric(length(x))
for (i in 1:length(x)){
  y[i] <- sample(1:6, 1) + y[i-1]
  if (y[i] >=150) {
    break
  }
}
y

# This does almost the same thing, but using a while loop. Look up the help page of ?tail

y <- 0
while(tail(y, 1) < 150){
  y <- c(y, tail(y, 1) + sample(1:6, 1))
}
y


#' 
#' # 3 - Functions
#' R and the contributed packages contain a myriad of built-in functions. Still, it might be useful to write your own functions at some point. For example, you can combine a number of consecutive commands under one name/function. This facilitates recurring computations and improves clarity of your scripts.
#' 
#' Function definitions always start with `function()` followed by a command block in curly brackets `{}`. Obligatory and optional arguments are defined in the round brackets (). You can define arguments with and without default settings, and the argument list may also be emtpy.
#' 
# function without arguments:
greetings <- function() {
  print('Hello world')
}
greetings()

# function with obligatory argument without default:
greetings <- function(name) {
  print(paste('Hello', name))
}
greetings('students')

#function with one obligatory argument and another argument with default
greetings <- function(name, greet = 'Hello') {
  print(paste(greet, name))
}
greetings('students')
greetings('students', 'Wake up')


#' 
#' Ideally, you write own functions to simplify calculations or workflows that you often need. Let's try an example for converting km to miles and vice versa.
#' 
# define the functions
km_to_miles <- function(km){
  km * 0.62137
}

miles_to_km <- function(mi){
  mi/0.62137 
}

# use the functions
km_to_miles(80)
miles_to_km(50)
