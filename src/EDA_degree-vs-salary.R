# EDA_degree-vs-salary.R
# Group: lab2-11
#
# This script reads in the cleaned data for degree vs. salary and performs EDA to create three figures reflecting the EDA.
#
# Script input arguments from the command line:
# 1. .csv file path of the .csv (e.g. data/clean_data/clean_salary_by_degree.csv)
#

# Usage:
# Rscript src/EDA_degree-vs-salary.R data/clean_data/clean_salary_by_degree.csv
# The data/clean_data/clean_salary_by_degree.csv is the path for the input file, which contains the cleaned data from degree to salary


suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggalt))
suppressPackageStartupMessages(library(scales))

args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1] # "data/clean_data/clean_salary_by_degree.csv"

main <- function(){
  df <- read_csv(input_file_path)
  
  # Change the col type to factor to work with
  df$Undergraduate_Major <- as.factor(df$Undergraduate_Major)
  df$Salary_Type<- as.factor(df$Salary_Type)
  
  
  # Plot college degree vs salary and show how salary changed from start to mid career (median salary)
  # arrange by start salary
  plot_by_start_salary <- df %>%
    filter(Salary_Type %in% c('Starting_Median_Salary', 'Mid_Career_Median_Salary') )%>%
    spread(key = Salary_Type, value = Salary) %>%
    ggplot(aes(x = Starting_Median_Salary, xend = Mid_Career_Median_Salary, y = fct_reorder(Undergraduate_Major, Starting_Median_Salary))) +
    geom_dumbbell(color = "#a3c4dc",
                  size = 0.75,
                  colour_xend = "#0e668b") +
    theme_bw() +
    theme(axis.title.y = element_blank(),
          axis.title.x = element_text(size = 15),
          strip.text.x = element_text(size = 15, colour = "black"),
          panel.grid.minor=element_blank()) +
    labs(x = "Salary",
         title = "Median starting to mid-career salary, by college degree, ordered by starting salary") +
    scale_x_continuous(label = dollar_format())
  
  
  # Plot college degree vs salary and show how salary changed from start to mid career (median salary)
  # arrange by mid salary
  plot_by_mid_salary <- df %>%
    filter(Salary_Type %in% c('Starting_Median_Salary', 'Mid_Career_Median_Salary') )%>%
    spread(key = Salary_Type, value = Salary) %>%
    ggplot(aes(x = Starting_Median_Salary, xend = Mid_Career_Median_Salary, y = fct_reorder(Undergraduate_Major, Mid_Career_Median_Salary))) +
    geom_dumbbell(color = "#a3c4dc",
                  size = 0.75,
                  colour_xend = "#0e668b") +
    theme_bw() +
    theme(axis.title.y = element_blank(),
          axis.title.x = element_text(size = 15),
          strip.text.x = element_text(size = 15, colour = "black"),
          panel.grid.minor=element_blank()) +
    labs(x = "Salary",
         title = "Median starting to mid-career salary, by college degree, ordered by mid-career salary") +
    scale_x_continuous(label = dollar_format())
  
  
  # Plot 10th to 90th percentile mid-career salary by college degree
  # arrange by median mid-career salary
  plot_mid_career_salary_range <- df %>%
    filter(Salary_Type %in% c("Mid_Career_10th_Percentile_Salary", "Mid_Career_50th_Percentile_Salary", "Mid_Career_90th_Percentile_Salary")) %>%
    spread(key = Salary_Type, value = Salary) %>%
    ggplot(aes(x = Mid_Career_10th_Percentile_Salary,
               xend = Mid_Career_90th_Percentile_Salary,
               y = fct_reorder(Undergraduate_Major, Mid_Career_50th_Percentile_Salary))
           ) +
    geom_dumbbell(color = "#a3c4dc",
                  size = 0.75,
                  colour_xend = "#0e668b") +
    geom_point(color = "firebrick1", aes(x = Mid_Career_50th_Percentile_Salary, y = fct_reorder(Undergraduate_Major, Mid_Career_50th_Percentile_Salary))) +
    theme_bw() +
    theme(axis.title.y = element_blank(),
          axis.title.x = element_text(size = 15),
          strip.text.x = element_text(size = 15, colour = "black"),
          panel.grid.minor=element_blank()) +
    labs(x = "Salary",
         title = "Mid-career salary range (10th, 50th and 90th percentile), by college degree") +
    scale_x_continuous(label = dollar_format())
  
  #save the plots in results folder under the following paths
  output_file_path_1 <- "results/degree_vs_salary_by_start.png"
  output_file_path_2 <- "results/degree_vs_salary_by_mid.png"
  output_file_path_3 <- "results/degree_vs_mid_salary_range.png"
  
  ggsave(plot = plot_by_start_salary,
         device = "png",
         width = 10,
         height = 10,
         limitsize = FALSE,
         dpi = 300,
         filename = output_file_path_1)
  ggsave(plot = plot_by_mid_salary,
         device = "png",
         width = 10,
         height = 10,
         limitsize = FALSE,
         dpi = 300,
         filename = output_file_path_2)
  ggsave(plot = plot_mid_career_salary_range,
         device = "png",
         width = 10,
         height = 10,
         limitsize = FALSE,
         dpi = 300,
         filename = output_file_path_3)
}

main()