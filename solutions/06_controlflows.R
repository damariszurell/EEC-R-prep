# Task 1 - Write a function that calculates degrees Fahrenheit from degrees Celsius, and another function for the other way around.

C_to_F <- function(c) { 
  c * 1.8 + 32
} 

F_to_C <- function(f){
  (f-32)/1.8
}

# Task 2 - Use a for-loop to add the following two vectors element-wise to each other:
vec1 <- 1:10
vec2 <- seq(10, 100, 10)

# two examples:

for (i in vec1){
  for (j in vec2){
    print(i+j)
  }
}

#OR

for (i in vec1) for (j in vec2){
  print(i+j)
}


