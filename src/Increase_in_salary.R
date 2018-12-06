# Increase_in_salary.R
# Group: lab2-11
# Authors: Alex Pak, Linyang Yu, Constantin Shuster
# Date: November 24, 2018
#
# This script reads in the joined table and creates a .csv with the increase in starting to mid-career salary. 
#
# Script input arguments from the command line:
# 1. .csv file path of the joined region/type .csv (e.g. "data/clean_data/clean_salary_by_region_type_join.csv")
# 2. Folder path where the output will be written to in .csv format (e.g. "results")
# 
# Script output is a .csv file with the increase in salary data. 

# Usage: 
# Rscript Increase_in_salary.R ../data/clean_data/clean_salary_by_region_type_join.csv ../results
# ../data/clean_data/clean_salary_by_region_type_join.csv is the file path for the input file
# ../results is the location for the output file

#import libraries
suppressPackageStartupMessages(library(tidyverse))

# Read in command line argument
args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1]
output_file_path <- args[2]

#input_file_path <- "data/clean_data/clean_salary_by_region_type_join.csv"
#output_file_path <- "results"

main <- function(){

  df <- read_csv(input_file_path)
  all_categories <-  unique(df$Salary_Type)
  
  df <- df %>% distinct()
  
  #head(df)
  
  increase_in <- (spread(df, Salary_Type, Salary)) %>%
    mutate(abs_increase = Mid_Career_Median_Salary - Starting_Median_Salary, 
           percent_increase = (Mid_Career_Median_Salary/Starting_Median_Salary)*100)
  
  increase_in <- select(increase_in, School_Name, Region, School_Type, Starting_Median_Salary, Mid_Career_Median_Salary, abs_increase, percent_increase)
  
  increase_in
  
  write_csv(increase_in, path=paste0(output_file_path), col_names=TRUE)
  
  #increase_in_tidy <- gather(increase_in, Mid_Career_10th_Percentile_Salary, Mid_Career_25th_Percentile_Salary, Mid_Career_50th_Percentile_Salary, 
  #         Mid_Career_75th_Percentile_Salary, Mid_Career_90th_Percentile_Salary, Mid_Career_Median_Salary, Starting_Median_Salary, 
  #         abs_increase, percent_increase, key="Salary_Type", value="Salary")
  
  #(increase_in_tidy %>%
  #  filter(Salary_Type == "abs_increase"))

}

main()