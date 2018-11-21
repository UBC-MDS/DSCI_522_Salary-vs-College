# Data_cleaning.R
# Group: lab2-11

# This script read the raw data and clean the row data from the character type to computable numeric data
# and create new clean data .csv files. The script takes two arguments from the command line.
# 1. the file path for the .csv file that needs to be cleaned (e.g. data/degree-that-pay-back.csv)
# 2. the file path for the cleaned file to be stored (e.g. data/degree-that-pay-back_cleaned.csv)

# Usage: Rscript Data_cleaning.R
library(tidyverse)

# Read in command line argument
args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1]
output_file_path <- args[2]

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
  
  colnames(dataframe) <- str_replace_all(colnames(dataframe), pattern = " ", replacement = "_")
  
  return(dataframe)
}

# Read in original dataset
raw_data <- read_csv(input_file_path)


# Get clean data using the function `char_to_num`
clean_data <- char_to_num(raw_data)

# Write the clean data file
write.csv(clean_data, file = output_file_path, row.names = FALSE)
