# Data_cleaning.R
# Group: lab2-11

# This script reads the raw data and cleans the raw data
# It changes data that is currently character type to computable numeric data
# New clean data .csv files are the output of this script. 
#
# Script input arguments from the command line:
# 1. .csv file path that needs to be cleaned (e.g. data/degree-that-pay-back.csv)
# 2. .csv file path for the cleaned file to be written (e.g. data/degree-that-pay-back_cleaned.csv)
# 
# Script output is a .csv file that represents a dataframe in tidy data form

# Usage: 
# Rscript Data_cleaning.R data/raw_data/degree-that-pay-back.csv data/clean_data/degree-that-pay-back-cleaned.csv
# Rscript Data_cleaning.R data/raw_data/salaries-by-college-type.csv data/clean_data/clean_salary_by_degree.csv
# Rscript Data_cleaning.R data/raw_data/salaries-by-region.csv data/clean_data/clean_salary_by_region.csv

#import libraries
library(tidyverse)

# Read in command line argument
args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1]
output_file_path <- args[2]

# Data-Cleaning: remove ',' and '$'

char_to_num <- function(dataframe){
  
  # remove the '$' and ',' from the orignal raw data
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
  
  # remove space and '-' from the column name
  colnames(dataframe) <- str_replace_all(colnames(dataframe), pattern = " ", replacement = "_")
  colnames(dataframe) <- str_replace_all(colnames(dataframe), pattern = "-", replacement = "_")
  
  # convert 'widy' dataframe into 'tidy' form
  # the 'Percent_change_from_Starting_to_Mid_Career_Salary' column in the raw degree dataset was removed as its not needed for our analysis
  if('Percent_change_from_Starting_to_Mid_Career_Salary' %in% colnames(dataframe)){
    dataframe_tidy <- dataframe %>%
      select(-Percent_change_from_Starting_to_Mid_Career_Salary) %>%
      mutate(Mid_Career_50th_Percentile_Salary = Mid_Career_Median_Salary) %>%
      gather(key = 'Salary_Type', value = 'Salary', Starting_Median_Salary, Mid_Career_Median_Salary, Mid_Career_10th_Percentile_Salary, Mid_Career_25th_Percentile_Salary,Mid_Career_50th_Percentile_Salary, Mid_Career_75th_Percentile_Salary, Mid_Career_90th_Percentile_Salary)
  }else{
    dataframe_tidy <- dataframe %>%
      mutate(Mid_Career_50th_Percentile_Salary = Mid_Career_Median_Salary) %>%
      gather(key = 'Salary_Type', value = 'Salary', Starting_Median_Salary, Mid_Career_Median_Salary, Mid_Career_10th_Percentile_Salary, Mid_Career_25th_Percentile_Salary,Mid_Career_50th_Percentile_Salary, Mid_Career_75th_Percentile_Salary, Mid_Career_90th_Percentile_Salary)
  }
  
  return(dataframe_tidy)
}

# Read in original dataset
raw_data <- read_csv(input_file_path)

# Clean dataset using the function `char_to_num`
clean_data <- char_to_num(raw_data)

# Write the clean data file
write.csv(clean_data, file = output_file_path, row.names = FALSE)
