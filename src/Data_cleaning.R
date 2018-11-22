# Data_cleaning.R
# Group: lab2-11

# This script reads the raw data and clean the row data from the character type to computable numeric data
# and creates new clean data .csv files. The script takes two arguments from the command line.
# 1. the file path for the .csv file that needs to be cleaned (e.g. data/degree-that-pay-back.csv)
# 2. the file path for the cleaned file to be stored (e.g. data/degree-that-pay-back_cleaned.csv)
# The output for the script will be a .csv file in its tidy form of data, with all the column and values computable

# Usage: 
# Rscript Data_cleaning.R data/raw_data/degree-that-pay-back.csv data/clean/degree-that-pay-back-cleaned.csv
# Rscript Data_cleaning.R data/raw_data/salaries-by-college-type.csv data/clean/clean_salary_by_degree.csv
# Rscript Data_cleaning.R data/raw_data/salaries-by-region.csv data/clean/clean_salary_by_region.csv

#import libraries
library(tidyverse)

# Read in command line argument
args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1]
output_file_path <- args[2]

# Data-Cleaning, remove the comma and dollar sign

char_to_num <- function(dataframe){
  # remove the dollar sign and comma from the orignal row data
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
  
  # remove space and '-'from the column name and make them computable
  colnames(dataframe) <- str_replace_all(colnames(dataframe), pattern = " ", replacement = "_")
  colnames(dataframe) <- str_replace_all(colnames(dataframe), pattern = "-", replacement = "_")
  
  # convert the widy form table in to tody form
  # the dgree dataset have a useless column named 'Percent_change_from_Starting_to_Mid_Career_Salary' that we want to remove it
  # We need to check the existence of the column
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

# Get clean data using the function `char_to_num`
clean_data <- char_to_num(raw_data)

# Write the clean data file
write.csv(clean_data, file = output_file_path, row.names = FALSE)
