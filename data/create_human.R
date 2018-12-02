# Emma Peltomaa
# 25.11.2018 & 2.12.2018

library("dplyr")
library("stringr")
library("MASS")
library("tidyverse")
library("tidyr")

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
gii <- mutate(gii, edur = seduf / sedum)
gii <- mutate(gii, lfpr = lfprf / lfprm)

# Joining the datasets
join_by <- c("country")
human <- inner_join(hd, gii, by = join_by)

# Saving the dataset
write.table(human, file = "human.csv")
View(human)


### Continuing data wrangling 2.12.2018

# Describing the dataset
dim(human) # 195 rows/observations, 19 columns/variables
str(human)
summary(human)

# Variable names' meanings:
"hdir" = HDI Rank
"country" = Country names
"hdi" = Human Development Index (HDI)
"liex" = Life Expectancy at Birth
"exyedu" = Expected Years of Education
"myedu" = Mean Years of Education
"gni" = Gross National Income (GNI) per Capita
"gnir_hdir" = GNI per Capita Rank Minus HDI Rank
"giir" = GII Rank
"gii" = Gender Inequality Index (GII)
"mamor" = Maternal Mortality Ratio
"adbir" = Adolescent Birth Rate
"perep" = Percent Representation in Parliament
"seduf" = Population with Secondary Education (Female)
"sedum" = Population with Secondary Education (Male)
"lfprf" = Labour Force Participation Rate (Female)
"lfprm" = Labour Force Participation Rate (Male)
"edur" = seduf / sedum
"lfpr" = lfprf / lfprm

# Mutating the data
str(human$gni)
str_replace(human$gni, pattern=",", replace ="") %>% as.numeric # Somehow the numeric values do not save in to the dataset.

# Excluding unneeded variables
keep <- c("country", "seduf", "lfprf", "exyedu", "liex", "gni", "mamor", "adbir", "perep")
human <- dplyr::select(human, one_of(keep))

# Removing all rows with missing values
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human))

# Removing the observations which are realted to regions instead of countries
tail(human_, n = 10)
last <- nrow(human_) - 7
human_ <- human_[1:last, ]
rownames(human_) <- human_$country
human <- dplyr::select(human_, -country)

write.table(human, file = "human.csv")
View(human)






