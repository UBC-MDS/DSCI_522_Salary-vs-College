# Statistic_test.R
# Group: lab2-11
# Authors: Alex Pak, Linyang Yu, Constantin Shuster
# Date: November 24, 2018
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
# ../data/clean_data/clean_salary_by_region_type_join.csv is the file path for the input .csv file, which contains the joined table for region and school type with salary
# ../results/anova_results is the folder name for all the output files

#import libraries
suppressPackageStartupMessages(library(tidyverse))

# Read in command line argument
args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1]
output_file_path <- args[2]

#input_file_path <- "data/clean_data/clean_salary_by_region_type_join.csv"
#output_file_path <- "results/anova_results"

main <- function(){
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
  #region_aovs
  #school_type_aovs
  #region_tukeys
  
  region_results <- as_tibble(matrix(ncol=3, nrow=7))
  school_type_results <- as_tibble(matrix(ncol=3, nrow=7))
  region_results <- rename(region_results, Salary_Type = V1, F_Statistic = V2, P_Value = V3)
  school_type_results <- rename(school_type_results, Salary_Type = V1, F_Statistic = V2, P_Value = V3)
  
  for (index in seq(1:length(all_categories))){
    region_results[index, 1] <- names(region_aovs[index])
    region_results[index, 2] <- region_aovs[[index]]["statistic"][[1]][1]
    region_results[index, 3] <- region_aovs[[index]]["p.value"][[1]][1]
    school_type_results[index, 1] <- names(school_type_aovs[index])
    school_type_results[index, 2] <- school_type_aovs[[index]]["statistic"][[1]][1]
    school_type_results[index, 3] <- school_type_aovs[[index]]["p.value"][[1]][1]
  }

  region_tukey_results <- bind_rows(region_tukeys)
  
  salary_column <- as_tibble(matrix(ncol=1, nrow=70))
  salary_column <- rename(salary_column, salary_type=V1)
  
  salary_column[1:10, 1] <- names(region_tukeys[1])
  salary_column[11:20, 1] <- names(region_tukeys[2])
  salary_column[21:30, 1] <- names(region_tukeys[3])
  salary_column[31:40, 1] <- names(region_tukeys[4])
  salary_column[41:50, 1] <- names(region_tukeys[5])
  salary_column[51:60, 1] <- names(region_tukeys[6])
  salary_column[61:70, 1] <- names(region_tukeys[7])
  
  region_tukey_results <- bind_cols(salary_column, region_tukey_results)
  region_tukey_results <- select(region_tukey_results, salary_type, term, comparison, adj.p.value)
  
  #---------------------------------------------------------------------------------------------#
  region_tukey_results <- region_tukey_results %>%
    mutate(flag = if_else(((adj.p.value > 0.01 )&(adj.p.value < 0.05)), '*',
                          if_else(((adj.p.value < 0.01)&(adj.p.value > 0.001)), '**',
                                  if_else((adj.p.value < 0.001), '***', 'Cannot Reject the NULL Hypothesis'))))
  #---------------------------------------------------------------------------------------------#
  
  
  school_type_tukey_results <- bind_rows(school_type_tukeys)
  
  salary_column[1:10, 1] <- names(region_tukeys[1])
  salary_column[11:20, 1] <- names(school_type_tukeys[2])
  salary_column[21:30, 1] <- names(school_type_tukeys[3])
  salary_column[31:40, 1] <- names(school_type_tukeys[4])
  salary_column[41:50, 1] <- names(school_type_tukeys[5])
  salary_column[51:60, 1] <- names(school_type_tukeys[6])
  salary_column[61:70, 1] <- names(school_type_tukeys[7])
  
  school_type_tukey_results <- bind_cols(salary_column, school_type_tukey_results)
  school_type_tukey_results <- select(school_type_tukey_results, salary_type, term, comparison, adj.p.value)
  
  #---------------------------------------------------------------------------------#
  school_type_tukey_results <- school_type_tukey_results %>%
    mutate(flag = if_else(((adj.p.value > 0.01 )&(adj.p.value < 0.05)), '*',
                          if_else(((adj.p.value < 0.01)&(adj.p.value > 0.001)), '**',
                                  if_else((adj.p.value < 0.001), '***', 'Cannot Reject the NULL Hypothesis'))))
  #--------------------------------------------------------------------------------#
  
  
  write_csv(region_results, path=paste0(output_file_path, "/region_anova_results.csv"), col_names = TRUE)
  write_csv(school_type_results, path=paste0(output_file_path, "/school_type_anova_results.csv"), col_names = TRUE)
  write_csv(region_tukey_results, path=paste0(output_file_path, "/region_tukey_results.csv"), col_names = TRUE)
  write_csv(school_type_tukey_results, path=paste0(output_file_path, "/school_type_tukey_results.csv"), col_names = TRUE)

}

main()
