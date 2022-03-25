# Task 1 -----------------------------------------------------------------------
# Dowload and import the hb_bird.txt data 
hb_bird <- read.delim("data/hb_bird.txt", sep=",")



# Task 2 -----------------------------------------------------------------------
# Explore the data set (Hint: use str() to understand how the data set is structured).
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
colSums(is.na(hb_bird)) # for visual inspection
# Answer: 2004 has 8 NAs
which.max(colSums(is.na(hb_bird))) # gives you the column 
# Answer: column 37 (year 2004) has the most NAs

# Which bird species has the highest average abundance? Hint: use rowMeans() and take care to ignore NA by adding the argument na.rm=T in the function call.
rowMeans(hb_bird[,-1], na.rm=TRUE) 
max(rowMeans(hb_bird[,-1], na.rm=TRUE)) # use this to find the highest value faster

which.max(rowMeans(hb_bird[,-1], na.rm=TRUE)) # this gives you the exact row with the highest value
# Answer: Red-eyed Vireo



# Task 3 -----------------------------------------------------------------------
# Visualise bird abundance 
library(ggplot2)

# 1) Plot the abundance over time for the bird species with the highest average abundance and the bird species with the lowest average abundance.


which.min(rowMeans(hb_bird[,-1], na.rm=TRUE)) # exclude the first column from the calculation 
# max: red-eyed Vireo (row 22)
# min: Pileated Woodpecker (row 3)

# create a data frame with three columns containing the information you need for your plot:
  # species, year, abundance
# You need to make two separate data frames for the two species and then combine them using rbindng rbind
b_abun <- rbind(data.frame(species = "Pileated Woodpecker", year = seq(1969, 2015, by=1), abundance = as.numeric(hb_bird[3,-1])),
                data.frame(species = "Red-eyed Vireo", year = seq(1969, 2015, by=1), abundance = as.numeric(hb_bird[22,-1])))

b_abun <- rbind(data.frame(species = "Red-br. Nuthatch", year = seq(1969, 2015, by=1), abundance = as.numeric(hb_bird[13,-1])),
                data.frame(species = "Red-eyed Vireo", year = seq(1969, 2015, by=1), abundance = as.numeric(hb_bird[22,-1])))

# base R version

# create subsets 
b_wood <- subset(b_abun, species == "Pileated Woodpecker")
b_vireo <- subset(b_abun, species == "Red-eyed Vireo")

# plot the abundance for one species. Make sure to adjust the limit of the y scale 
plot(x = b_vireo$year, y = b_vireo$abundance, col = "salmon3", pch = 19,
     xlab = "year",
     ylab = "abundance",
     ylim=c(0,33))

# and add the other one
points(x = b_wood$year, y = b_wood$abundance, col = 'CornFlowerBlue', pch = 19)

### ggplot version
p <- ggplot(data = b_abun, mapping = aes(x = year, y = abundance)) +
  geom_line(aes(color = species)) 
  
p


# 2) Select three years (e.g. 1970, 1990, and 2010) and plot the abundances of all species in boxplots.

# prepare a data frame with the data you need. Make sure to include the years as factors to later on split them in the boxplot
b_years <- rbind(data.frame(year = as.factor(1970), abundance = hb_bird[,3]),
                 data.frame(year = as.factor(1990), abundance = hb_bird[,23]),
                 data.frame(year = as.factor(2010), abundance = hb_bird[,43]))

# base R version
boxplot(abundance ~ year, data = b_years) 

# ggplot version
(p2 <- ggplot(data = b_years, mapping = aes(x = year, y = abundance)) +
  geom_boxplot()) 
