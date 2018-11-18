# Emma Peltomaa
# 18.11.2018
# Creating two datasets, they are downloaded from here: https://archive.ics.uci.edu/ml/datasets/Student+Performance

# Reading the datasets
math <- read.table("student-mat.csv", sep=";", header=TRUE)
por <- read.table("student-por.csv", sep=";", header=TRUE)

# Dimensions of the datasets
dim(math)  # 395 rows/observations and 33 columns/variables
dim(por)  # 649 rows/observations and 33 columns/variables

# Structure of the datasets
str(math)
str(por)

###################

# Joining the datasets
library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# Dimensions and structure of the jointed data
dim(math_por) # 382 rows/observations and 53 columns/variables
str(math_por)

###################

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- select(two_columns, 1)[[1]]
  }
}

###################

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

###################

glimpse(alc)

# Saving the dataset
write.table(alc, file = "alc.csv")
