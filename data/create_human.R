# Emma Peltomaa
# 25.11.2018

# Reading two datasets from here:

# Human development, more information: http://hdr.undp.org/en/content/human-development-index-hdi
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

# Gender inequality, more infromation: http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Exploring both if the datasets:
dim(hd) # 195 rows/observations, 8 columns/variables
str(hd)
summary(hd)

dim(gii) # 195 rows/observations, 10 columns/variables
str(gii)
summary(gii)

# Renaming the variables
colnames(hd) <- c("hdir", "country", "hdi", "liex", "exyedu", "myedu", "gni", "gnir_hdir")
colnames(gii) <- c("giir", "country", "gii", "mamor", "adbir", "perep", "seduf", "sedum", "lfprf", "lfprm")

# Mutation of gii-data
library(dplyr)
gii <- mutate(gii, edur = seduf / sedum)
gii <- mutate(gii, lfpr = lfprf / lfprm)

# Joining the datasets
join_by <- c("country")
human <- inner_join(hd, gii, by = join_by)

# Saving the dataset
write.table(human, file = "human.csv")
View(human)
