# Emma Peltomaa
# 9.12.2018

library(dplyr)
library(tidyr)

# Loading the datasets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

names(BPRS)
str(BPRS)
summary(BPRS)

names(RATS)
str(RATS)
summary(RATS)

# Converting categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
glimpse(BPRS)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
glimpse(RATS)

# Converting the datasets to long form and adding two variables
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
glimpse(BPRSL)

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))
glimpse(RATSL)

# Comparing wide and long versions
names(BPRSL)
str(BPRSL)
summary(BPRSL)

names(RATSL)
str(RATSL)
summary(RATSL)

# Wide form: one observation is a single individual with multiple measurement points
# E.g. in BPRS dataset subject's psychotic symptoms are measured several times during few weeks

# Long form: now one measurement point is treated as single observation
# E.g. in BPRS dataset subject's score in BPRS on 1st week is one observation and the score on 2nd week is another observation

write.table(BPRSL, file = "BPRSL.csv")
View(BPRSL)

write.table(RATSL, file = "RATSL.csv")
View(RATSL)
