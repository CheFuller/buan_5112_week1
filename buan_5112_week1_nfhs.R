#######################
# OMSBA 5112 - Week 1 #
# GitHub & R Coding   #
#                     #
# 9/24/2020           #
#                     #
# Chequala Fuller     #
#######################

library(tidyverse)
library(haven)
library(ggplot2)

#read the .dta file as nfhs
nfhs <- read_dta("IAHR52FL.dta")

#subset the data so that you only keep the variables between "hhid" and "shstruc"
summary(subset(nfhs, select = c(hhid, shstruc)))
select(nfhs, hhid:shstruc)

#plot the distribution of the number of listed household members
ggplot(data = nfhs, mapping = aes(x = hv009)) +
  geom_histogram(binwidth = 0.5) + 
  xlab("Number of Listed Household Members")

#create a new data frame that contains urban households only
new_df <- nfhs %>%
  mutate(urban = hv025 == 2)

#####################################################################################
# The code below provides a Boxplot of the distribution of household size by type   #
# of urban area                                                                     #
#                                                                                   #
# Urban areas are classified into (0) large cities (capital cities and cities with  # 
# over 1 million population), (1) small cities (population over 50,000), and (2)    #
# towns (other urban areas)                                                         #
#####################################################################################


ggplot(data = nfhs, aes(factor(x = hv026), y = hv009)) +
  geom_boxplot(size = 1) + 
  xlab("Type of Urban Area") +
  ylab("Distribution of Household Size")

#Use "group_by" and "summarise" to find the means and medians of the number of household
#members by type of urban area. Match the correct means to their urban areas.

nfhs %>%
  group_by(factor(x = hv026)) %>%
  summarise(
    mean(nfhs$hv009)
  )

nfhs %>%
  group_by(factor(x = hv026)) %>%
  summarise(
    median(nfhs$hv009)
  )
  