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

# Rscript src/Join_region_and_type.R data/clean_data/clean_salary_by_region.csv data/clean_data/clean_salary_by_type.csv data/clean_data/clean_salary_by_region_type_join.csv

# import libraries
suppressPackageStartupMessages(library(tidyverse))

# define and read the .csv files
args <- commandArgs(trailingOnly = TRUE)
input_file_path_1 <- args[1] # data/clean_data/clean_salary_by_type.csv
input_file_path_2 <- args[2] # data/clean_data/clean_salary_by_region.csv
output_file_path <- args[3] # data/clean_data/clean_salary_by_region_type_join.csv
df_t <- read.csv(input_file_path_1)
df_r <- read.csv(input_file_path_2) #read_csv will return warning message, why?

main <- function(){
    
    # perform the inner join
    joined_table <- inner_join(df_r, df_t, by = "School_Name") %>% select(School_Name, Region, School_Type, Salary_Type = Salary_Type.x, Salary = Salary.x)
    joined_table_unique <- unique(joined_table)
    
    # Export the new .csv file
    write.csv(joined_table_unique, file = output_file_path, row.names = FALSE)
    
}

main()
