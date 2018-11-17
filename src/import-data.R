library(tidyverse)

salary_by_degree <- read_csv("data/degrees-that-pay-back.csv")
salary_by_type <- read_csv("data/salaries-by-college-type.csv")
salary_by_region <- read_csv("data/salaries-by-region.csv")


# NOTE: Right now, salaries are chars. Need to convert to numeric values. 
salary_by_degree