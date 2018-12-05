# Join_region_and_type.R
# Group: lab2-11

# This script reads the clean salary by region and salary by type .csv's 
# and inner joins the results based on the university name as a key. 
# A new .csv file is the output of this script. 
#

# Usage: 
# Script input arguments from the command line:
# 1. .csv file path for the cleaned salary by region (e.g. data/clean_data/clean_salary_by_region.csv)
# 2. .csv file path for the cleaned salary by type (e.g. data/clean_data/clean_salary_by_type.csv)
# 3. .csv file path for the final output (e.g. data/clean_data/clean_salary_by_region_type_join.csv)
# 
# Script output is a .csv file that represents the joined dataframe in tidy data form

# Rscript Join_region_and_type.R ../data/clean_data/clean_salary_by_region.csv ../data/clean_data/clean_salary_by_type.csv ../data/clean_data/clean_salary_by_region_type_join.csv

# import libraries
suppressPackageStartupMessages(library(tidyverse))

# define and read the .csv files
args <- commandArgs(trailingOnly = TRUE) # c("data/clean_data/clean_salary_by_type.csv", "data/clean_data/clean_salary_by_region.csv", "data/clean_data/clean_salary_by_region_type_join.csv") #commandArgs(trailingOnly = TRUE)
input_file_path_1 <- args[1] # data/clean_data/clean_salary_by_type.csv
input_file_path_2 <- args[2] # data/clean_data/clean_salary_by_region.csv
output_file_path <- args[3] # data/clean_data/clean_salary_by_region_type_join.csv

main <- function(){
  df_t <- read_csv(input_file_path_1)
  df_r <- read_csv(input_file_path_2)
  #df_wtf <- read_csv("data/clean_data/clean_salary_by_region_type_join.csv")
  
  left_join_table <- left_join(df_t, df_r, by = c("School_Name" = "School_Name", "Salary_Type" = "Salary_Type")) %>%
    select(School_Name, Region, School_Type, Salary_Type, Salary = Salary.x)
  
  # perform the inner join
  # df_t_select <- df_t %>% select(School_Name, School_Type)
  # joined_table <- inner_join(df_r, df_t_select, by = "School_Name") %>% select(School_Name, Region, School_Type, everything())
  
  # Export the new .csv file
  write.csv(left_join_table, file = output_file_path, row.names = FALSE)
  
}

main()
