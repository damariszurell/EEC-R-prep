#' ---
#' "Getting started in R"
#' 
#' Installing R and RStudio (adopted from [datacarpentry](https://datacarpentry.org/R-ecology-lesson/#Install_R_and_RStudio))
#' 
#' 
#' For this course you will need both R and RStudio. **R** is a programming language that is particularly powerful for statistical data analysis and broadly used across almost all scientific disciplines. **RStudio** is an Integrated Development Environment (IDE) that makes it much easier to access R and develop reproducible code. Please make sure to install R first.  
#' 
#' To install R and RStudio on Windows:
#' 
#' - Download R for Windows from [CRAN](https://cran.r-project.org)
#' - Run the downloaded .exe file to install R
#' - Download [RStudio](https://rstudio.com/products/rstudio/download/) for Windows
#' - Install by executing the downloaded .exe file  
#' 
#' 
#' To install R and RStudio on MacOS:
#' 
#' - Download R for Mac from [CRAN](https://cran.r-project.org)
#' - Double click on the downloaded .pkg file to install R
#' - Also download and install [XQuartz](https://www.xquartz.org) (needed by some packages)
#' - Download [RStudio](https://rstudio.com/products/rstudio/download/) for MacOS
#' - Install by executing the downloaded .pkg file  
#' 
#' 
#' To install R and RStudio on Linux:
#' 
#' - Download and install the correct version of R on [CRAN](https://cran.r-project.org) (versions differ between Linux distributions)
#' - Download and install the correct version of [RStudio](https://rstudio.com/products/rstudio/download/) (versions differ between Linux distributions)  
#' 
#' 
#' In all cases, open RStudio and type 2+2 into the *console* (the command line window at the bottom left) and hit enter. If a 4 appears, you are all set up.
#' 
#' 
#' 
#' # What is R?
#' 
#' - a very flexible, open source programming environment for (statistical) data analyses and visualisation (www.r-project.org)  
#' - an object-oriented and interpreted programming language based on the S language [(see here)](https://stackoverflow.com/questions/38467631/whats-object-oriented-programming/39086783)
#' - runs on all common operating systems
#' 
#' **How to operate R:**  
#' 
#' - R is operated from the command line  
#' - work with script files for easier tractability, recycling and modification of commands 
#' - scripts also allow you to send big chunks of code or the entire script to the R console  
#' - scripts are the first step for automatizing your data manipulation and analyses  
#' - R has a built-in editor, but many people nowadays use R Studio (http://rstudio.org/) or other text editors  
#' 
#' **Additional R resources:** 
#' 
#' - Tutorial by [Adam Wilson](http://adamwilson.us/SpatialDataScience/02_graphics.html )    
#' - [Data carpentry](https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html)    
#' - Introduction by [Paul Torfs and Claudia Brauer](https://cran.r-project.org/doc/contrib/Torfs+Brauer-Short-R-Intro.pdf)    
#' - R for Beginners by [Emmanuel Paradis](https://rbasicsworkshop.weebly.com/uploads/1/8/6/0/18603232/paradis_2005_r-forbeginners.pdf)    
#' - Books [R for Data Science](http://r4ds.had.co.nz/), or @crawley2007)   
#' - [StackOverflow](https://stackoverflow.com/questions/tagged/r)  
#' The RStudio [cheat sheets](https://www.rstudio.com/resources/cheatsheets/) are also very helpful!
#' 
#' 
#' # Create a new project in RStudio
#' I recommend using RStudio throughout the course.
#' 
#' I also recommend setting up an RStudio project for the entire course (UP students can watch video tutorial in Moodle) and within the RStudio project separate R scripts for each session. To do so:
#' 
#' - Open RStudio
#' - Go to the tab "File" and select "New Project"
#' - Select either "New Directory" if you haven't set up a course folder yet, or select "Existing Directory" to point towards an existing folder. This directory will be the working folder for the course. Navigate to the path of the project folder on your machine (e.g. ’~Documents/Courses/R-intro)
#' - Name your project     
#' - Use your file explorer on your machine, find your project folder, and create four sub-folders: data, scripts, results, and figures
#' - Create a new empty R script by going to the tab "File", select "New File"  and then "R script"
#' - In the new R script, type `# Session 1: Getting started in R` and save the file in your folder "scripts" within your project folder, e.g. as "1_GettingStarted.R".
#' 
#' # Console and prompt
#' In the R console you will find the symbol `>`:
#'  This is the so-called *prompt*, which asks you for the next command. 
#'  
#'  The most basic thing you can do now is typing some mathematical calculations.  If you see a `+` instead, then the former command is not completed yet, and R waits for further arguments (maybe you have forgotten the closing bracket?).
#'  

20 * (5 - 3
)

#' 
#' A line break or a semicolon (;) separates commands.
#' 

2 + 3; 2 + 4

#' 
#' Anything following a hashmark `#`, will be interpreted as comment and will, thus, not be executed.

1 + 3
1 + 3

#' 
#' You could type all code examples that are listed here directly into your R console. You can also view the previous comments you executed in the console by using the cursor/arrow keys. However, we highly recommend storing everything into a script file. You can directly execute commands from the script file by using `ctrl + Enter` shortcut.
#' 
#' # Grammar: functions and arguments
#' R comes with a huge list of commands, which we call function. In order to execute a function, it needs to be followed by brackets `()`. 
#' 
## -----------------------------------------------------------------------------------------------------------------------------
sum()
sum(1, 3)

#' 
#' Within the brackets, we can provide additional arguments to the function. Some functions always expect additional arguments, and some functions don't. In the above example, `sum()` also works without additional arguments. The function's default assumes that we have provided a zero vector and thus the output is a `0`. If we provide a vector of numeric values, the function will return the sum of these values.
#' 
#' Some functions have named arguments, for example the function `rep()`, which creates a vector of replicates (we will learn more about vectors in the next section).
#' 
## -----------------------------------------------------------------------------------------------------------------------------
rep(x = 2, times = 10)
rep(2, 10)

#' 
#' In this example, both expression give the same results because we provided the arguments in the same order as the function expects. With named arguments, we can also change the order.
#' 
## -----------------------------------------------------------------------------------------------------------------------------
rep(times = 10, x = 2)
rep(10, 2)

#' 
#' # Working directory
#' R is always pointed at a specific directory on your computer, the working directory. You can check the current working directory by typing:

getwd()

#' 
#' If you set up the RStudio project correctly, then `getwd()` should show your course folder as working directory. Else, you change the working directory using `setwd()`. Check out the help page:

?setwd

#' 
#' RStudio also offers an option for setting the working directory in the tab bar. To do so, go to the tab "Session > Set Working Directory".
#' 
#' See the files contained in your folder:

dir()

#' 
#' # Workspace
#' You can list all objects in your workspace by typing `ls()`.

ls()

#' 
#' Probably your workspace does not list any objects yet. We can remove objects from the workspace using `rm()`.

x <- 20
y <- 30
z <- 40

ls()

rm(x) # removes one or more objects

rm(list = ls()) #removes all objects from workspace

#' 
#' # Load and install packages
#' There are thousands of additional packages available for R. You can see the list of installed packages by typing:
#' `library()`
#' 
#' The same command is used for loading a specific package into the workspace = make it available for
#' this session:

# loads the package raster:
library(ggplot2)
# removes package from current workspace:
detach(package:ggplot2)

#' 
#' If you don’t have the packages above, install them in the package manager or by running the command

install.packages("ggplot2", dependencies = TRUE)

#' 
#' # Getting help
#' R comes with an extensive, built-in help system, and several manuals, help pages for every available function and many additional documents.
#' 
#' You can access the built-in manuals by typing:

help.start()

#' 
#' Help pages for specific functions can be accessed with help() or with abbreviation ?.


# help page for arithmetic mean:
help(mean)
# the same:
?mean

#' 
#' Most functions come with examples:

example(mean)

#' 
#' Some function calls need to be surrounded by quotation marks when calling help, e.g. special characters or expression with syntactic meaning such as if, for und function.

?"*"
?"if"

#' 
#' If you have forgotten the exact name of a function, you can search all function names, titles and
#' keywords by typing:

help.search("mean")
# the same:
??mean

#' 
#' Search through all (installed) functions that contain the word in their function call:

apropos("mean")

#' 
#' Look at all functions contained in `base` package by typing:

library(help = base)

#' 
#' Some package authors offer additional documents or tutorials called vignettes:

# list all available vignettes of the installed(!) packages:
vignette()

# opens the vignette as pdf or html:
vignette("ggplot2-specs")

#' 
#' Upon opening a new R session, some useful information will be printed to the console, mainly on version number and copyright. You can also extract this and other useful information by typing commands, e.g.

sessionInfo()
citation()

#' 
#' The last command is important for citing the correct packages in your theses or any other publication.