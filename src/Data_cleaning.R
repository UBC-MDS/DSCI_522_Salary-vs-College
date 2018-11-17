# Data_cleaning.R
# Group: lab2-11

# This script read the raw data and clean the row data from the character type to computable numeric data
# and create new clean data .csv files.

# Usage: Rscript Data_cleaning.R

library(tidyverse)


# Data-Cleaning, remove the comma and dollar sign

char_to_num <- function(dataframe){
  dataframe$`Starting Median Salary` <- gsub('\\$','', dataframe$`Starting Median Salary`)
  dataframe$`Starting Median Salary` <- as.numeric(gsub(',','',dataframe$`Starting Median Salary`))
  
  dataframe$`Mid-Career Median Salary` <- gsub('\\$','', dataframe$`Mid-Career Median Salary`)
  dataframe$`Mid-Career Median Salary` <- as.numeric(gsub(',','',dataframe$`Mid-Career Median Salary`))
  
  dataframe$`Mid-Career 10th Percentile Salary` <- gsub('\\$','', dataframe$`Mid-Career 10th Percentile Salary`)
  dataframe$`Mid-Career 10th Percentile Salary` <- as.numeric(gsub(',','',dataframe$`Mid-Career 10th Percentile Salary`))
  
  dataframe$`Mid-Career 25th Percentile Salary` <- gsub('\\$','', dataframe$`Mid-Career 25th Percentile Salary`)
  dataframe$`Mid-Career 25th Percentile Salary` <- as.numeric(gsub(',','',dataframe$`Mid-Career 25th Percentile Salary`))
  
  dataframe$`Mid-Career 75th Percentile Salary` <- gsub('\\$','', dataframe$`Mid-Career 75th Percentile Salary`)
  dataframe$`Mid-Career 75th Percentile Salary` <- as.numeric(gsub(',','',dataframe$`Mid-Career 75th Percentile Salary`))
  
  dataframe$`Mid-Career 90th Percentile Salary` <- gsub('\\$','', dataframe$`Mid-Career 90th Percentile Salary`)
  dataframe$`Mid-Career 90th Percentile Salary` <- as.numeric(gsub(',','',dataframe$`Mid-Career 90th Percentile Salary`))
  
  return(dataframe)
}

# Get clean data using the function `char_to_num`
clean_salary_by_degree <- char_to_num(salary_by_degree)
clean_salary_by_region <- char_to_num(salary_by_region)
clean_salary_by_type <- char_to_num(salary_by_type)

# Write the clean data file
write.csv(clean_salary_by_region, file = "data/clean_salary_by_region")
write.csv(clean_salary_by_type, file = "data/clean_salary_by_type")
# Due to the special struction of the salary_by_degree dataframe (the last col as list)
clean_salary_by_degree$salary_by_degree <- as.character(clean_salary_by_degree$salary_by_degree)
write.csv(clean_salary_by_degree, file = "data/clean_salary_by_degree")

# We can then read data with the clean version
salary_by_degree <- read_csv("data/clean_salary_by_degree")
salary_by_region <- read_csv("data/clean_salary_by_region")
salary_by_type <- read_csv("data/clean_salary_by_type")