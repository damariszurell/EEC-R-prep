# Task 1 - Dowload and import the hb_bird.txt data.
hb_bird <- read.delim("data/hb_bird.txt", sep=",")

###
# Task 2 -  Explore the data set (Hint: use str() to understand how the data set is structured).
str(hb_bird)

# How many bird species are included in the hb_bird data?
  # Answer:36 

# Missing data are indicated by a “t”. Find these and replace them with an NA.

for (i in 2:ncol(hb_bird)){
  row_index <- grep("t", hb_bird[,i])     # finds rows with "t"
  hb_bird[row_index,i] <- NA              # replaces t with NA
  hb_bird[,i] <- as.numeric(hb_bird[,i])  # turns column into numeric values
}

summary(hb_bird) 

# In which year do you have the most NAs?
# Answer: 2004 has 8 NAs

# Which bird species has the highest average abundance? Hint: use rowMeans() and take care to ignore NA by adding the argument na.rm=T in the function call.
rowMeans(hb_bird[,-1], na.rm=TRUE) 
max(rowMeans(hb_bird[,-1], na.rm=TRUE)) # use this to find the highest value faster
# another useful function:
which.max(rowMeans(hb_bird[,-1], na.rm=TRUE)) # this gives you the exact row with the highest value
# Answer: Red-eyed Vireo

###
# Task 3 - Visualise bird abundance 
library(ggplot2)
# 1) Plot the abundance over time for the bird species with the highest average abundance and the bird species with the lowest average abundance.

# max: red-eyed Vireo (row 22)
# min: Pileated Woodpecker (row 3)
min(rowMeans(hb_bird[,-1], na.rm=TRUE))

# still missing

# 2) Select three years (e.g. 1970, 1990, and 2010) and plot the abundances of all species in boxplots.

# still missing

# 3) Do the same data wrangling and visualisation for another bird dataset. Compare, for example the difference in total species numbers.

# still missing


