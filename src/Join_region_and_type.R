# Join_region_and_type.R
# Group: lab2-11

# Because we are interested in a 2-factor ANOVA test (by region and school type), this script is used to perform inner join for the two datasets:
# 1. data/clean_data/clean_salary_by_region.csv
# 2. data/clean_data/clean_salary_by_type.csv 
# And create a third .csv file for storing the joined dataframes.
# Since the goal for this script is very direct, the script will take no argument from the command bash

# Usage: Rscript Join_region_and_type.R

# import libraries
library(tidyverse)

# define and read the .csv files
args <- commandArgs(trailingOnly = TRUE)
input_file_path_1 <- args[1] # data/clean_data/clean_salary_by_type.csv
input_file_path_2 <- args[2] # data/clean_data/clean_salary_by_region.csv

df_t <- read_csv(input_file_path_1)
df_r <- read_csv(input_file_path_2)

# perform the inner join
df_t_select <- df_t %>% select(School_Name, School_Type)
joined_table <- inner_join(df_r, df_t_select, by = "School_Name") %>% select(School_Name, Region, School_Type, everything())

# Export the new .csv file
write.csv(joined_table, file = "data/clean_data/joined_region_and_type.csv", row.names = FALSE)
