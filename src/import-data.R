# import-data.R
# Group: lab2-11

# This script read the original data as .csv files

# Usage: Rscript import-data.R

library(tidyverse)

main <- function(){

  # Reading the clean version of the data
  salary_by_degree <- read_csv("data/clean_salary_by_degree.csv")
  salary_by_region <- read_csv("data/clean_salary_by_region.csv")
  salary_by_type <- read_csv("data/clean_salary_by_type.csv")
  
  # Delete spaces in column names
  salary_by_degree <- salary_by_degree %>% 
    rename_all(funs(make.names(.)))
  salary_by_region <- salary_by_region %>% 
    rename_all(funs(make.names(.)))
  salary_by_type <- salary_by_type %>% 
    rename_all(funs(make.names(.)))
  
  
  # Some preliminary data exploration
  
  # Which degrees pay the most right after graduation? 
  arrange(salary_by_degree, desc(Starting.Median.Salary))
  
  # Which universities have the highest paying degrees? 
  arrange(salary_by_region, desc(Starting.Median.Salary))
  arrange(salary_by_region, desc(Mid.Career.Median.Salary))
  
  # Which regions pay the most right after graduation? 
  salary_by_region %>%
    group_by(Region) %>%
    summarize(Avg_Starting_Median_Salary = mean(Starting.Median.Salary)) %>%
    arrange(desc(Avg_Starting_Median_Salary))
}

main()