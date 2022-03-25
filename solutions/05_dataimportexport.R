# Task 1: Download the file `data/surveys_.csv_pract3.txt` and save it in the data folder of your R-project. The data set contains survey data with information about the month, day, year, plot_id, species_id, sex, hindfoot_length and weight.

# Read the file to your workspace (hint: separator? header?) and inspect the data set (e.g. str(), summary()). 
# Solution: add year header before reading.
survey_data <- read.table(file.path("data", "surveys_pract3.txt"), header = TRUE, sep = "\t", row.names = NULL)
str(survey_data)


# Are the data types of the columns correct? (hint: categorical variables should be `factor` and not `character`)  
# Do you notice something about the `sex` column?  
  
# Make sure that all columns have the correct type and missing values are filled with `NA`. 
survey_data <- read.table("data/surveys_pract3.txt", header = TRUE, sep = "\t", na.strings = "", stringsAsFactors = TRUE, row.names = NULL)

write.table(survey_data, file = "data/surveys_pract3_correct.csv", sep = ",")
