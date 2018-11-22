# Join_region_and_type.R
# Group: lab2-11

# This script reads the clean salary by region and salary by type .csv's 
# and inner joins the results based on the university name as a key. 
# A new .csv file is the output of this script. 
#
# Script input arguments from the command line:
# 1. .csv file path for the cleaned salary by region (e.g. data/clean_data/clean_salary_by_region.csv)
# 2. .csv file path for the cleaned salary by type (e.g. data/clean_data/clean_salary_by_type.csv)
# 3. .csv file path for the final output (e.g. data/clean_data/clean_salary_by_region_type_join.csv)
# 
# Script output is a .csv file that represents the joined dataframe in tidy data form

# Usage: 
# Rscript Join_region_and_type.R ../data/clean_data/clean_salary_by_region.csv ../data/clean_data/clean_salary_by_type.csv ../data/clean_data/clean_salary_by_region_type_join.csv

# import libraries
library(tidyverse)

# define and read the .csv files
input_file_path_1 <- '../data/clean_data/clean_salary_by_region.csv'
input_file_path_2 <- '../data/clean_data/clean_salary_by_type.csv'
df_r <- read_csv(input_file_path_1)
df_t <- read_csv(input_file_path_2)

# perform the inner join
df_t_select <- df_t %>% select(School_Name, School_Type)
joined_table <- inner_join(df_r, df_t_select, by = "School_Name") %>% select(School_Name, Region, School_Type, everything())

# Export the new .csv file
write.csv(joined_table, file = "../data/clean_data/clean_salary_by_region_type_join.csv", row.names = FALSE)
