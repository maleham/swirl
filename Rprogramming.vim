"""
CHECK R PACKAGES AT:
https://www.rstudio.com/products/rpackages/
R GIVES +/- INF WHEN DIVIDING BY 0!
PYTHON: zero-based indexing vs R: one-based indexing

> library(swirl) if using it first time from another computer?
> swirl if already used in computer

- when (...) press enter to continue

- exit swirl and return to the R prompt (>) at any 
  time by pressing the Esc key
- if at the prompt, type bye() to exit and save your progress

At R prompt:
- skip() allows you to skip the current question
- play() lets you experiment with R (swirl ignores me)...
- until nxt() which will regain swirl's attention
- main() returns you to swirl's main menu
- info() displays these options again


1. R PROGRAMMING: BASICS OF PROGRAMMING IN R
1.1. BASIC BUILDING BLOCKS
- (<-) is the = of python
- small collection of numbers: vector (simplest type of data structure, 
  i.e., any object that contains data
  (even a single number is a vector of length 1)
- c() = concatenate
- for help about a built-in function type ?c (or whatever function)
  without parentheses normally
- sqrt() = square root
- abs() = absolute value of
- When given two vectors of the same length, R simply performs
  the specified arithmetic operation (`+`, `-`, `*`, etc.)
  element-by-element. If the vectors are of different lengths,
  R 'recycles' the shorter vector until it is the same length
  as the longer vector, i.e. 
      z <- c(1.1, 9, 3.14)
      z * 2 + 100 is actually
      z * c(2, 2, 2) + c(100, 100, 100)
  OJO! c(1,2,3,4) + c(0,10) gives as result 1 12  3 14
  i.e. R still applies the 'recycling' method, but will throw
  a warning to let you know something fishy might be going on

1.2. WORKSPACE AND FILES
- getwd() = determine which directory the R session is using as 
  current wd
- ls () = to list all objects in your local workspace, i.e., what 
  variables and (functions?) I have defined in my session in my wd
  OJO! ls() != list.files() or dir()
- list.files() == dir()   =    list all files in wd
- args() = see arguments that a function takes
  e.g. args(list.files) (list.files without ())
- dir.create("testdir") = to create a dir in current wd named "testdir"
- setwd("testdir") = to set a directory ("testdir") as current wd
  i.e., I am in wd home/delolmo, which contains /testdir. To set "testdir"
  as current wd: setwd("testdir") (just the name of downstream wd)
- file.create("mytest.R") = to create "mytest.R" file in current wd
- file.exists() = check whether a file exists in wd
- file.info() = to get information about a file (remember quotation marks)
- file.rename("file1.R", "file2.R") = rename "file1" as "file2"
- file.remove("file1.R") = no delete file1.R
- file.copy("file2.R", "file3.R") = copy "file2" to "file3"
***DON'T FORGET QUOTATION MARKS!***

- file.path = to construct file and directory paths that
  are independent of the operating system your R code is running on.
  Pass 'folder1' and 'folder2' as arguments to file.path to make a
  platform-independent pathname.
  e.g.: > file.path("folder1", "folder2") == "folder1/folder2" 
  i.e.: this simply creates a path, to create this path inside an existing 
  path (eg in my wd): dir.create(dir.path("folder1", "folder2"))
- unlink() = would be similar to dir.delete, it is to delete dirs
  OJO! One has to fix recursive=TRUE in unlink() so that R makes sure
  we are not doing it by accident

1.3. SEQUENCES OF NUMBERS
- ':' operator = to create sequence of numbers (including both numbers at 
  the side of the :) one by one
  i.e. pi:10 = 3.14, 4.14, ..., 9.14 (10.14 would be too high)
  You can also do it "backwards": 15:1 = 15 14 13 12 11 ... 3 2 1
  OJO! For help about a particular built-in R function in the case of an
  operator (like :): ?":" or ?`:`
- seq() = more control than :, but allows us to have more control of the
  sequence, e.g.: 
      seq(1,20,by=0.5) == to increment by steps of 0.5
      seq(5,10,length=30) == I want 30 numbers between 5 and 10
- length() = to evaluate the length of a certain sequence
- 1:length(my_seq) == seq(along.with=my_seq) == seq_along(my_seq)
- rep() = replicate, e.g.: 
      rep(c(0,1,2),times=10) = 0 1 2 0 1 2 0 1 2 ... (10 times)
             == rep(c(0,1,2),10)
      rep(c(0,1,2),each =10) = 0 0 0 0 (10times) 1 1 1 1 (10times) 2 2 ...

1.4. VECTORS
- Vectors can be either
    ATOMIC VECTORS (contains 1 data type): atomic vectors can be:
        LOGICAL: TRUE, FALSE, NA (not available)
          logical operators: >, <, >=, <=, ==, !=
          combination of logical expressions: | (or, union)
                                              & (and, intersection)
        CHARACTER: "" used to distinguish character objects
          paste() =  to join elements of vector of characters into one 
                     continuous character string (i.e. character vector
                     of length 1)
                     COLLAPSE: e.g.: paste(my_char, collapse=" "): 
                        collapse argument tells R that we want to
                        separate characters in a vector with single spaces
                     SEP: e.g.: paste("Hello", "world!", sep=" "): 
                        separate the characters (vectors of length 1)
                        by single space
                  paste(1:3, c("X", "Y", "Z"), sep=", ") == 
                  zip(np.linspace(1.0,3.0,num=3), np.array(["X", "Y", "Z"])             INTEGER
          positive
          negative
          named --> eg c(foo=11,bar=2,norf=NA) (each element has a name)
        COMPLEX
    LISTS (contains multiple data types)

1.5. MISSING VALUES
- rnorm() = takes as many values as specified inside () from a standard 
  normal distribution
- R represents
  TRUE as the number 1 and FALSE as the number 0. Therefore, if we
  take the sum of a bunch of TRUEs and FALSEs, we get the total
  number of TRUEs.
- NaNs only provided for "indeterminaciones" such as 0/0 or Inf-Inf
  NOTE Inf (not inf) stands for infinity

1.6. SUBSETTING VECTORS
- []: to view, e.g., in x[1:10], the first 10 elements of x
  x[is.na(x)] returns a vector of all NAs in x
  Imagine x has many NAs and normal numbers mixed together and I want 
  to get just the positive numbers of x
    x[x>0] won't help me, since I will get a vector of positive numbers
      and NAs (NA>0 evaluates to NA)
    subsetting x into a y vector: y <- x[!is.na(x)] and y[y>0] will work              or x[!is.na(x) & x>0] (all numbers that are both not NA AND that are
      greatly bigger than 0)
- For nice code: c(x[3],x[5],x[7])==x[c(3,5,7)] but x[c(3,5,7)] is nicer
- You should always make sure that what you are asking for is within the bounds   of the vector you're working with if length(x) == 40 and I ask 
  x[3000], R doesn't prevent me from asking for it, it just returns NA
- Negative indexes are accepted: will give all elements except the 
  negative index     NOT LIKE PYTHON!! negative indexes are 'backwards' indexes
  x[c(-2,-10)] == x[-c(2,10)]
- names() = to get the names of a named vector i.e., a vector with named
  elements
- You can first create a vector eg v1 <- c(1,2,NA) and then name it by:
  names(v1) <- c("col1", "col2", "col3")

- identical(arg1,arg2) = to check whether arguments inside identical()
  function are identical or not. Returns TRUE or FALSE

1.7. MATRICES AND DATA FRAMES
- MATRICES vs DATA FRAMES:
    MATRICES: contain a single class of data
    DATA FRAMES: consist of many different classes of data
- dim() = gives dimensions of an object, returns (ROWS,COL)
    VECTOR: null dimension, we can only find its length with length()
            I can change vector to matrix (with dim != 0) by
            dim(vector) <- c(4,5)
- class() = to see whether arg inside class is matrix, vector..

-cbind() = combine columns (args in cbind can be of different classes,
           namely vector and matrix)
           OJO! it combines in order: cbind(nameofpat, matrix) will return 
           a matrix with an extra column (nameofpat) at the beginning of 
           matrix
           OJO2! But this returns a matrix of character stringt = NOT GOOD
           (matrices can only contain ONE class of data) ---> R did an 
           """Implicit coercion"""
           SOLUTION: data.frame(vect,mat)
- colnames()/rownames() = another approach to name cols or rows in a df
                          e.g. colnames(df) <- c("Name", "Weight", "BP")

1.8. LOGIC

- TRUE and FALSE: logical/boolean values
- ! = not (e.g. ! 5 == 7   = TRUE, because not(5==7) is TRUE)
      NOT operator negates logical expressions, so TRUE expressions become
      FALSE and FALSE expressions become TRUE
- & and && = AND operator
      &: evaluates AND across a vector
         TRUE & c(TRUE,FALSE,FALSE) == c(TRUE, TRUE, TRUE) & c
         (TRUE,FALSE,FALSE) == TRUE, FALSE, FALSE
      &&: evaluates first member of vector
          TRUE && c(TRUE,FALSE,FALSE) == TRUE (only 1st element of vector
          is evaluated)
- | and || = OR operators (same rules as & and &&)
      TRUE | c(TRUE,FALSE,FALSE) == TRUE, TRUE, TRUE
- AND operators are evaluated BEFORE OR operators (like * is evaluated 
  before +)
- isTRUE() = evaluates TRUTH and returns T/F, e.g. isTRUE(6>4) = TRUE
- xor(arg1,arg2) = exclusive OR. It one arg evaluates to T and the other 
                   to F, the function will return T, otherwise F
                   e.g. xor(5==6, !FALSE) = TRUE
                   e.g. xor(5==5, !FALSE) == xor(TRUE,TRUE) = FALSE

- sample() = samples randomly the argument inside the function
- which() = takes logical vector as arg and returns indices of the vector
            that are TRUE
            which(c(TRUE, FALSE, TRUE)) = c(1,3)
- any() = returns TRUE it one or more of the elements in the vector is T
- all() = returns T if every element in the logical vector is T

1.9. FUNCTIONS
- mean() --> mean(2,4,5) NOT WORKING
             mean(c(2,4,5)) WORKS
- To view source code for any functions, type the function name without any
  args or parentheses
- %% = to find remainder

- DEFAULT FUNCTION: 
  remainder <- function(num,divisor=2){
    num%%divisor
    }
  remainder(5) does remainder of 5/2 (divisor is 2 by default), so == 1
  But still I can change divisor: remainder(9,3) == 0

- args(function) = to see the arguments inside a function

EXAMPLE: Write a function so that if a function is passed into the "func"
         argument and some data (like a vector) is passed into the "dat"
         argument the evaluate() function will return the result of dat
         being passed as an arg to func

         evaluate <- function(func,dat){
          func(dat)
          }

- Anonymous functions = functions that are not named appropriately
  e.g. evaluate(function(x){x+1}, 6) returns 7
       first argument is a tiny anonymous function that takes one arg (x) 
       and returns x+1

EXAMPLE: use evaluate function defined previou:sly with an anonymous function 
         to return the last element of vector c(8,4,0). The anonymous 
         function must only take one argument which should be a variable 'x'.

          evaluate(function(x){x[length(x)]}, c(8,4,0))

- paste() = paste("Programming", "is", "fun!") returns "Programming is fun!"

- All arguments after the ellipses must have default values (strict rule in R) 
- BINARY OPERATORS: see ~/Documents/MASTER-THESIS/swirl/Functions_tutorial/
                    bin_op.R

1.10. LAPPLY AND SAPPLY 
      (most important members of *apply family of f(x)s in R)
      (take lists as input)
- close relatives: vapply(), tapply()
                   all provide convenient means of implementing
                       Split-Apply-Combine strategy for data analysis
- Each of the *apply functions will SPLIT up some data into smaller pieces,
  APPLY a function to each piece and then COMBINE results.

- head() = arg is a dataset, head() returns first six lines of dataset
- viewinfo() = to open a more complete description of the dataset (arg) in
  a separate text file
- str() = to view structure
- summary() =  produce result summaries of the results of various model 
  fitting functions (min, max, median, mean, 1st and 3rd quartile...)

- lapply() = takes a list as input, applies a function to each element of 
  the list, returns a list of same length as original one. A df is just a 
  list of vectors (type as.list(flags)), so we can use lapply() to apply the
  class() function to each column of the flags dataset.
  e.g. lapply(flags,class) --> note that class goes without parentheses!
       This tells me the class of the cols in flags:
       i.e. that 1st col (name) is a "factor", 2nd (landmass) is "integer"...
       Returns a LIST (L in lapply) of length 30 (one element for each col)
       where each element of list is a character vector of length one
       (i.e., "factor" or "integer"...)
- as.character(result of a lapply() computation) to simplify this list to
  a character vector (a vector of characters)
    Now, class(result of as.character()) is character
- sapply() = alternative to lapply()+as.character(lapply())
  BETTER SAPPLY
  | In general, if the result is a list where every element is of 
  | length one, then sapply() returns a vector.
  | If the result is a list where every element is a vector of the 
  | same length (> 1), sapply() returns a matrix. If sapply() 
  | can't figure things out, then it just returns a list, 
  | no different from what lapply() would give you.

  | In the examples we've looked at so far, sapply() has been able 
  | to simplify the result to vector. That's
  | because each element of the list returned 
  | by lapply() was a vector of length one. Recall that 
  | sapply() instead returns a matrix when each element of 
  | the list returned by lapply() is a vector of the same
  | length (> 1).

- > flag_colors <- flags[, 11:17] = stores all rows but just cols from
    11th to 17th

- unique() = returns vector with all duplicate elements removed
             just unique elements  
             OJO! unique(vector), i.e. unique(c())

1.11 VAPPLY AND TAPPLY
- vapply() = in contrast to sapply, which 'guesses' the correct format of 
             the result, vapply allows to specify it explicitly. If the
             result doesn't match the format specified, vapply throws error
             vapply may perform faster than sapply for large datasets

INTERESTING! dataset$nameofcol to receive just data from one col
             table(dataset$nameofcol) to get a table of it
             e.g. table(flags$landmass) returns a table with info of how
                  many flags/countries fall into eack landmass group (6)
                  table(flags$animate) to get a table with how many
                  countries have an animated flag (1) or unanimated flag (0)
- tapply (flags$animate, flags$landmass, mean) = applies mean of animated 
  flags that fall into each landmass --> so I receive output with shape of 
  landmass (arg2)

1.12. LOOKING AT DATA
- Data is commonly stored in dataframes
- object.size() = to see how much sace the dataset occupies in memory 
- names() = returns a character vector of column (i.e. variable) names
- head() = shows first 6 rows of data (I can alter this by passing
           a second argument with the number of rows I'd like to see
- tail() = same as head() but starting in the end of the dataset
- summary() = to get a feel for how each variable is distributed
              and how much of the dataset is missing
              It displays min, median, mean, max, 1st and 3rd quartiles
              and number of NAs
              One could type table(plants$Active_Growth_Period) for more 
              info of a variable that has been truncated in the summary()
              (specially if the variable is a categorical/factor vble)
- str() = the best function. Combines all functions in a concise
          and readable format. Tells us first class of data set, then how
          many observations and vbles, then gives the name and class of
          each variable as well as a preview of its contents

1.13. SIMULATION
SAMPLING WITH REPLACEMENT (replace is an arg in sample() function): 
when a sampling unit is drawn from a finite population and is 
returned to that population, after its characteristic(s) have been 
recorded, before the next unit is drawn, the sampling is said to
be done with replacement. e.g. when sampling dice (From
https://stats.oecd.org/glossary/detail.asp?ID=3835)

- sample() --> by default, replace=FALSE.
               if size is not specified, R takes a sample equal in
               size to the vector from which I am sampling
               probability can be attached in a 4th arg in case of, e.g.,
               unfair coin
               e.g. sample(LETTERS) == sample(LETTERS, 26, replace=FALSE)

  | Each probability distribution in R has an r*** function 
  | (for "random"), a d*** function (for "density"), a p*** 
  | (for "probability"), and q*** (for "quantile"). We are most 
  | interested in the r*** functions in this lesson, but I encourage 
  | you to explore the others on your own.

- rbinom() = to calculate probability of SUCCESSES given a specific
             probability of success.
             e.g. if an unfair coin has a prob of giving HEADS (success)
             of 0.7 ---> rbinom(1,size=100,prob=0.7)

- rnorm() = standard normal distribution, mean=0, sd=1 by default
- colMeans() = to find mean of each col
- hist() = to plot hist of eh colMeans()
- rchisq(), rexp(), rgamma()...

1.14. DATES AND TIMES
IF I WORK WITH DATES AND TIMES OFTEN, I MAY WANT TO CHECK OUT THE 
LUBRIDATE PACKAGE BY HADLEY WICKHAM

ALWAYS TO LOAD DATAFRAMES: e.g.: data(dataframe_RNASeq)

R has special way of representing times and dates, which is helpful
if I am working with data that shows changes over time (time-series
data)

Dates and times are stored as the number of days (for dates),
seconds (for POSIXct times) or lists of seconds, minutes, hours 
(for POSIXlt times) since 1970-01-01
1970-01-01.

- EXAMPLE: d1 <- Sys.Date()
           d1 == "2016-02-03"
           class(d1) == 'Date'
           unclass(d1) == 16834 --> number of days since 1970-01-01
- as.Date() = to reference a date prior to 1970-01-01
              unclass(as.Date(1969-01-01) == -365

- Sys.time() = to store current date and time
               t1 <- Sys.time()
               class(t1) == "POSIXct" "POSIXt"
               unclass(t1) == 1454496489
               By default, Sys.time() returns an object of class POSIXct
               but we can coerce the result to POSIX1t:
- as.POSIX1t(Sys.time()) --> str(unclass(as.POSIX1t(Sys.time())))
  to see compact list

- weekdays(time/date), months(), quarters() = returns the day of the
  week, the month or the quarter of the year of the date or 
  time (POSIXct, POSIXlt) passed as arg

- strptime() = converts character vectors into POSIXlt (in case
  dates or times are in a format unrecognized by R)
  (similar to as.POSIXlt()), although input doesn't have to be YYYY-MM-DD
  strptime(time, "%B %d, %Y %H:%M")

- difftime(time1,time2,units='') = to find the difference in time passed
  between time1 and time2 in the units passed as arg (days, months..)
  
1.15. BASE GRAPHICS
MORE ADVANCED PORTIONS OF GRAPHICS IN R INCLUDED IN 
LATTICE, GGPLOT2 AND GGVIS. For ggplot2:
http://varianceexplained.org/r/teach_ggplot2_to_beginners/

- plot(dataset of 2 cols) = R notes that the df I passed as arg has 
  2 cols, so assumes that I want to (SCATTER)plot one vs. the other
  I can specify what I want to plot in which axis with '$'
    plot(x=cars$speed, y=cars$dist)
- main() = par in plot() to plot title
- sub() = par in plot() to plot subtitle
- col=2 = par in plot() to plot with RED color
- xlim=c() = par in plot() to limit x axis to a specific interval

- FORMULA ARGUMENTS: expression var1~var2 (shape of y~x), so var2 is 
  plotted on x axis and var1 on y axis
- boxplot() = when passing a "formula" argument, one has to specify
  the "data" argument (dataset) where it is taken from

"""
