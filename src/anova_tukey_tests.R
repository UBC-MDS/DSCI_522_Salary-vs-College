# Statistic_test.R
# Group: lab2-11
#
# This script reads in the joined clean data and performs multiple one-way ANOVA's
# across all salary type categories. Then, this script performs the Tukey Procedure
# on the resulting ANOVA tests. 
#
# Script input arguments from the command line:
# 1. .csv file path of the joined region/type .csv (e.g. "data/clean_data/clean_salary_by_region_type_join.csv")
# 2. Folder path where the tests will be written to in .csv format (e.g. "results/anova_tests")
# 
# Script output are multiple .csv files resulting from the ANOVA tests on all salary types and the Tukey Procedure
# added on top of all the ANOVA tests. 

# Usage: 
# Rscript anova_tukey_tests.R ../data/clean_data/clean_salary_by_region_type_join.csv ../results/anova_results

#import libraries
library(tidyverse)

# Read in command line argument
args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1]
output_file_path <- args[2]

#input_file_path <- "data/clean_data/clean_salary_by_region_type_join.csv"
#output_file_path <- "results/anova_results/"

df <- read_csv(input_file_path)
all_categories <-  unique(df$Salary_Type)

df <- df %>% distinct()

region_aovs <- vector("list", length(all_categories))
school_type_aovs <- vector("list", length(all_categories))

for (index in seq(1:length(all_categories))){
  #print(all_categories[index])
  salary_type_df <- df %>%
    filter(Salary_Type == all_categories[index])
  names(region_aovs)[index] <- all_categories[index]
  region_aovs[[index]] <- aov(Salary~Region, data = salary_type_df)
  names(school_type_aovs)[index] <- all_categories[index]
  school_type_aovs[[index]] <- aov(Salary~School_Type, data = salary_type_df)
}

region_tukeys <- lapply(region_aovs, stats::TukeyHSD)
school_type_tukeys <- lapply(school_type_aovs, stats::TukeyHSD)

for (index in seq(1:length(all_categories))){
  names(region_tukeys)[index] <- all_categories[index]
  names(school_type_tukeys)[index] <- all_categories[index]
}

region_aovs <- lapply(region_aovs, broom::tidy)
school_type_aovs <- lapply(school_type_aovs, broom::tidy)
school_type_tukeys <- lapply(school_type_tukeys, broom::tidy)
region_tukeys <- lapply(region_tukeys, broom::tidy)


for (index in seq(1:length(region_aovs))){
  write_csv(region_aovs[[index]], path=paste0(output_file_path, "/", names(region_aovs[index]), "_region_anova.csv"), col_names = TRUE)
  write_csv(school_type_aovs[[index]], path=paste0(output_file_path, "/", names(region_aovs[index]), "_type_anova.csv"), col_names = TRUE)
  write_csv(region_tukeys[[index]], path=paste0(output_file_path, "/", names(region_aovs[index]), "_region_tukey.csv"), col_names = TRUE)
  write_csv(school_type_tukeys[[index]], path=paste0(output_file_path, "/", names(region_aovs[index]), "_type_tukey.csv"), col_names = TRUE)
}