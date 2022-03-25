# solution:

# The package 'ggplot2' is often used to generate graphics. What is the command to plot a graphic with ggplot2? Is there a useful cheatsheet for ggplot2?    
install.packages("ggplot2")
ggplot2::ggplot()

# the "::" indicates, that you want to use the function "ggplot()" from the package "ggplot2"
# this is useful, in cases when multiple packages have functions with the same name (that don't actually do the same thing)

# ggplot2 cheatsheet
# https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf