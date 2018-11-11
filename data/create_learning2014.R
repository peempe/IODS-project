# Emma Peltomaa
# 11.11.2018
# Creating the dataset

# Reading the full learning2014 data from 
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Dimensions of the data
dim(lrn14)  # 183 rows/observations and 60 columns/variables

# Structure of the data
str(lrn14)

# dplyr package
install.packages("dplyr")
library(dplyr)

# Questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# Analysis dataset
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

# Renaming the variables
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

# Excluding observations where the exam points variable is zero
learning2014 <- filter(learning2014, points > 0) 

# Setting working directory
setwd("~/Documents/GitHub/IODS-project/data")

# Saving the dataset
write.table(learning2014, file = "learning2014.csv")

read.table("learning2014.csv")
head(learning2014)
str(learning2014)
