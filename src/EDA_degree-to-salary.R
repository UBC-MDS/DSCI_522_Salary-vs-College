# EDA_degree-to-salary.R
# Group: lab2-11

# This script creates a interactive plot to explore the relationship between the undergrad degree and the related career salaries
# The script takes one argument from the command line.
# 1. the file path for the cleaned data (data/degree-that-pay-back_cleaned.csv)


# Usage: 
# Rscript EDA_degree-to-salary.R data/degree-that-pay-back-cleaned.csv

# import libraries
library(tidyverse)
library(plotly)

# Read in command line argument
args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1]

# read in the cleaned dataframe
df <- read_csv(input_file_path)

# main function for making a interactive plot to explore the salary changes between start and mid career
p_1 <- df %>% plot_ly(x = ~Undergraduate_Major, y = ~Starting_Median_Salary, type = 'bar', name = 'Start Salary') %>%
  add_trace(y = ~Mid_Career_Median_Salary, name = 'Mid Career Salary') %>%
  layout(yaxis = list(title = 'Salaries for Different Major'),
         xaxis = list(title = 'Undergrade Major'),
         barmode = 'group')

# save the plotly plot
# please do not change the following three lines of code, plotly is problematic when we try to define the saving path directly
# the following code will create a interactive plot in the result folder
dir.create(paste0(getwd(),"/results"))
image_save_path_1 <-  paste0(getwd(),"/results/","degree-to-salary_start-to-Mid-Career.html")
htmlwidgets::saveWidget(as_widget(p_1), image_save_path_1)

# main function for making a interactive plot to explore the salary distribution for mid career: 10%, 25%, 75%, 90% percentile
p_2 <- df %>% plot_ly(x = ~Undergraduate_Major, y = ~Mid_Career_10th_Percentile_Salary, type = 'bar', name = 'Mid Career 10th Percentile Salary') %>%
  add_trace(y = ~Mid_Career_25th_Percentile_Salary, name = 'Mid Career 25th Percentile Salary') %>%
  add_trace(y = ~Mid_Career_Median_Salary, name = "Mid Career 50th Percentrile Salary") %>%
  add_trace(y = ~Mid_Career_75th_Percentile_Salary, name = 'Mid Career 75th Percentile Salary' ) %>%
  add_trace(y = ~Mid_Career_90th_Percentile_Salary, name = 'Mid Career 90th Percentile Salary') %>%
  layout(yaxis = list(title = 'Salaries for Different Major'),
         xaxis = list(title = 'Undergrade Major'),
         barmode = 'group')

# save the plotly plot
dir.create(paste0(getwd(),"/results"))
image_save_path_2 <-  paste0(getwd(),"/results/","degree-to-salary_distribution.html")
htmlwidgets::saveWidget(as_widget(p_2), image_save_path_2)