# Linear_Regression.R
# Group: lab2-11
#
# This script reads in the joined clean data and performs Linear Regression as a further prove for the result we get from ANOVA and tukey pairwise test
#
# Usage: 
# Script input arguments from the command line:
# 1. .csv file path of the joined region/type .csv (e.g. "data/clean_data/clean_salary_by_region_type_join.csv")
# 2. Folder path where the tests will be written to in .csv format (e.g. "results/lm_tests")
# 
# Script output are multiple .csv files resulting on the linear regeression model for the Starting and Mid-Career Salary
#
# Rscript Linear_Regression.R ../data/clean_data/clean_salary_by_region_type_join.csv ../results/lm_tests
# ../data/clean_data/clean_salary_by_region_type_join.csv is the file path for the input .csv file, which contains the joined table for region and school type with salary
# ../results/lm_tests is the folder name for all the output files

#import libraries
suppressPackageStartupMessages(library(tidyverse))


# Read in command line argument
# args <- commandArgs(trailingOnly = TRUE)
input_file_path <-   args[1] # 'data/clean_data/clean_salary_by_region_type_join.csv'
output_file_path <-  args[2] # 'results/lm_tests'

main <- function(){
  df <-read_csv(input_file_path)
  
  df_Starting <- df%>% select(-School_Name) %>%unique() %>% filter(Salary_Type == 'Starting_Median_Salary')
  df_Mid_Career <- df%>% select(-School_Name) %>%unique() %>% filter(Salary_Type == 'Mid_Career_50th_Percentile_Salary')
  
  # head(df_Starting)
  
  # Analysis the starting salary
  # Assume no interaction between Region and School_Type
  lm_Starting_no_interaction <- broom::tidy(lm(Salary~Region+School_Type -1, data = df_Starting))
  lm_Starting_no_interaction_sigflag <- lm_Starting_no_interaction %>% mutate(significant_flag = if_else(p.value < 0.05, 'Reject Null', 'Cannot Reject Null'))
  # Assume interaction between Region and School_Type
  lm_Starting_with_interaction <- broom::tidy(lm(Salary~Region*School_Type, data = df_Starting))
  lm_Starting_with_interaction_sigflag <- lm_Starting_with_interaction %>% mutate(significant_flag = if_else(p.value < 0.05, 'Reject Null', 'Cannot Reject Null'))
  
  # Analysis the Mid-Career Salary
  # Assume no interaction between Region and School_Type
  lm_Mid_no_interaction <- broom::tidy(lm(Salary~Region+School_Type, data = df_Mid_Career))
  lm_Mid_no_interaction_sigflag <- lm_Mid_no_interaction %>% mutate(significant_flag = if_else(p.value < 0.05, 'Reject Null', 'Cannot Reject Null'))
  # Assume interaction between Region and School_Type
  lm_Mid_with_interaction <- broom::tidy(lm(Salary~Region*School_Type, data = df_Mid_Career))
  lm_Mid_with_interaction_sigflag <- lm_Mid_with_interaction %>% mutate(significant_flag = if_else(p.value < 0.05, 'Reject Null', 'Cannot Reject Null'))
  
  write_csv(lm_Starting_no_interaction_sigflag, path=paste0(output_file_path, "/StartingSalary_Region_SchoolType_no_interaction.csv"), col_names = TRUE)
  write_csv(lm_Starting_with_interaction_sigflag, path=paste0(output_file_path, "/StartingSalary_Region_SchoolType_with_interaction.csv"), col_names = TRUE)
  write_csv(lm_Mid_no_interaction_sigflag , path=paste0(output_file_path, "/MidCareerSalary_Region_SchoolType_no_interaction.csv"), col_names = TRUE)
  write_csv(lm_Mid_with_interaction_sigflag, path=paste0(output_file_path, "/MidCareerSalary_Region_SchoolType_with_interaction.csv"), col_names = TRUE)
}

main()