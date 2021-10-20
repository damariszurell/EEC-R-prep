#' ---
#' "Data import and export"

#' 
#' R offers several options for accessing different data formats. Standard formats include text files (in ASCII format), binary files, R files (single objects or entire workspaces), and databases. These data can be read in from files using a file path, but also from the Internet using an URL path or from the clipboard. Of course, you can also write to these same devices. A good overview is provided in the manual „R Data Import/Export“ [@RCT2019], which you can access by typing help.start(). The manual also contains information on some useful packages, e.g. `foreign`, which provides access to datasets created with different statistical software such as SAS, SPSS, S-PLUS etc. Data import using the package `tidyverse` is briefly explained in the [RStudio cheat sheets](https://www.rstudio.com/resources/cheatsheets/).
#' 
#' # 1 - Read text data
#' Download the data files [`veggyshopping.txt`](data/veggyshopping.txt), [`veggyshopping.csv`](data/veggyshopping.txt) and [`myColumn.txt`](data/myColumn.txt) from the course data repository and move them to the data folder inside your project folder.
#' 
#' Since you are working in an R project the R session already points to the project directory, so when we want to load data from the data folder that is contained within the project directory, all we need to do is specify the *relative path* to the data folder. This is best done using file.path(), because this function builds the path automatically using the correct slash (`/` on Unix systems, `\` on Windows). Let's list the files inside the data folder:
#' 
# file.path() constructs the path with the correct slash (they are different on different operating systems). The point is a placeholder for your current folder

file.path(".", "data") # the . is a placeholder for your current working directory. It can be omitted, but we keep it as an example of how paths are built.

list.files(path = file.path(".", "data"))

# Since we are not navigating to subfolders within the data folder, in this specific case we can also use:
list.files(path = "data")

#' 
#' Read the file `veggyshopping.txt` from your data folder. The file is in table format (data frame); every column has a name, and columns are separated by comma. This information is important for correct reading:
my_df <- read.table(file.path('.', 'data', 'veggyshopping.txt'))

#' 
#' There may be several reasons for an error message. Is the data table correct? Do all columns contain the same number of elements? Yes, the data file is correct. Then, it probably has to do with the arguments passed to `read.table()`. Have a look at the help page and the default settings.
#' 
#' Important arguments:
#' 
#' - `file`: (path) and file name  
#' - `header`: logical value indicating whether file contains column names; defaults to `FALSE`  
#' - `sep`: column separator. Default: " " (white space or tab)
#' - `dec`: character used for decimal points. Default: "."
#' - `colClasses`: optional vector giving data types for each column
#' - `stringsAsFactors`: set to `FALSE` to avoid automatic transformation of character to factor.
#' 
#' R expects white spaces as field separator but we had separated our data columns by comma when saving the file. Also, R does not assume column names, so, we need to tell R that:
(my_df <- read.table(file.path("data", "veggyshopping.txt"), sep = ',', header = TRUE))
str(my_df)
names(my_df)
summary(my_df)

#' 
#' There are also some useful modifications for common formats, e.g. for comma-separated files (csv):
read.csv(file.path("data", "veggyshopping.txt"))
read.csv(file.path("data", "veggyshopping.csv"))

#' 
#' Sometimes, using read.table() or its modifications is not meaningful. The next example file does not contain a data table but only a (very long) vector. `read.table()` will still work but it will be slow, and will create a data frame object with many rows in only one column, which is not very sensible.
read.table(file.path("data", "myColumn.txt"))

#' 
#' For such one-row or one-column data files, it is better to use functions like `scan()`. With some exercise, this command can also be used for reading very complex data structures.
scan(file.path("data", "myColumn.txt"))

#' 
#' Other packages are available that provide more convenient functions for data import, e.g. `tidyverse` or `data.table`. Often, these functions will automatically detect the data structure in the files.
library(tidyverse)
read_delim(file.path("data", "veggyshopping.txt"))

# so, read_delim does not detect the column separator
read_delim(file.path("data", "veggyshopping.txt"), delim = ',')
read_csv(file.path("data", "veggyshopping.txt"))

library(data.table)
fread(file.path("data", "veggyshopping.txt"))

#' 
#' # 2 - Write text data
#' All objects created in R can be exported to file. Data frame can be written to file by `write.table` and its variants:
write.table(veggy_shopping, file.path("data", "veggyshopping.txt"), row.names = FALSE, col.names = TRUE, sep = ',')
write.csv(veggy_shopping, file.path("data", "veggyshopping.csv"))

#' 
#' This will automatically overwrite the two files you downloaded above because the file paths are identical to those of the downloaded files.
#' 
#' 
#' Important arguments:
#' 
#' - `file`: (path) and file name
#' - `sep`: column separator. Default: " " or "," (depending on function)
#' - `dec`: character used for decimal points. Default: "."
#' 
#' The function `write()` allows writing vectors and matrices to file. However, it contains some surprising default settings. Check out the help pages and below example. For demonstration purpose, we pipe the output into
#' the console ("").
# Write vector:
x <- 1:500
write(x, "") # prints to console

# Write matrix:
(Xmat <- matrix(1:10, ncol = 5))
write(Xmat, "") # prints to console

#' 
#' Surprisingly, the matrix is not exported in the right structure. Check out the help page `?write` to find out more about it.
#' 
# transpose matrix before exporting: works!
write(t(Xmat), "")

 
#' 
#' # 3 - Read and write R objects
#' When your data structure is more complex then simple data frames or matrices, other formats are likely preferable to text files.
#' 
#' - `save()`: saves R objects to `.Rdata` format. When you load an `.Rdata` file (`load()`), objects saved within appear in your global environment under the same name they were stored with.
#' - `saveRDS()`: stores R objects to `.rds` format. Arguably the most efficient way of storing any type of data that only needs to be accessed by R. `readRDS()` loads `.rds` files and you can assign the loaded data to a new object name (unlike `load()` which automatically assigns the object name of the data from when it was stored).
#' - `save.image()`: stores your entire workspace (equivalent to `save()`, but fall all the data currently in the global environment). This way, you can simply continue an R session at any later time by loading the stored workspace image (`load()`). When you are working in an RStudio project, workspace images are stored upon exiting the project by default. When your loaded objects take up a lot of memory, saving and loading can become pretty slow and it sometimes might be preferable to disable this setting.
#' 
#' 

# save object Xmat to Rdata format
save(Xmat, file = file.path("data", "Xmat.Rdata"))
load(file.path("data", "Xmat.Rdata")) # object Xmat will be loaded into global environment

saveRDS(Xmat, file = file.path("data", "Xmat.rds"))
Xmat_differentname <- readRDS(file.path("data", "Xmat.rds")) # same matrix, but is loaded into a different object name in global environment

