# EDA_region_and_school_type_to_salary.R
# Group: lab2-11

# This script creates two plots each time the script is called to explore a college attribute's relation to salary between:
# 1. school region and graduates' salaries (start vs. MidCareer, salary distribution in MidCareer)
# 2. school type and graduates' salaries (start vs. MidCareer, salary distribution in MidCareer)

# The script takes two input arguments from the command line:
# 1. the file path for the joined table: data/clean_data/clean_salary_joined_region_and_type.csv
# 2. the college attribute that the user wants to explore: Region or School_Type

# Usage:
# Rscript src/EDA_region_and_school_type_to_salary.R data/clean_data/clean_salary_by_region_type_join.csv Region
# Rscript src/EDA_region_and_school_type_to_salary.R data/clean_data/clean_salary_by_region_type_join.csv School_Type

# Each time the script is called from the command line, if the college attribute is correct, it will:
# 1. create 2 plots based on the college attribute given
# 2. save the plots in the results folder
#     - Region: salary_distribution_Region.png and salary_change_Region.png
#     - School_Type: salary_distribution_SchoolType.png and salary_change_SchoolType.png


# import libraries
library(tidyverse)
library(ggthemes)
library(ggalt)
library(scales)

# read in the command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1]
feature_exp <- args[2]

#read school region and type joined csv
df <- read_csv(input_file_path)

# choose the feature we want to explore
if(feature_exp == 'Region'){
  
  # do the EDA for the region feature
  # make the salary distribution table based on the region
  df_region <- df %>% 
    select(-School_Name, -School_Type)
  
  # the introduce and remove of the School_Name and School_Type introduced duplicates into our data
  df_region_unique <- unique( df_region[ , ])
  
  # make estmation about the upper and lower confidence interval
  df_region_est <- df_region_unique %>%
    group_by(Region,Salary_Type) %>%
    summarise(mean_salary = mean(Salary, na.rm = TRUE),
              sd = sd(Salary, na.rm = TRUE),
              n = n(),
              se = sd/sqrt(n),
              upper_ci = mean_salary + 1.96 * se,
              lower_ci = mean_salary - 1.96 * se)
  
  
  
  # make the region to be factor
  df_region_est$Region <- as.factor(df_region_est$Region)
  
  # create facet labels
  Salary_Type_dist.labs <- c("Mid-Career 10th Percentile Salary", "Mid-Career 50th Percentile Salary", "Mid-Career 90th Percentile Salary")
  names(Salary_Type_dist.labs) <- c('Mid_Career_10th_Percentile_Salary', 'Mid_Career_50th_Percentile_Salary', 'Mid_Career_90th_Percentile_Salary')
  
  
  # make the plot for the region vs salary based on the distribution of the midCareer Salary
  # the figure is facet by the Salary_Type 10th, 50th and 90th.
  
  p_dist_region <- df_region_est %>%
    filter(Salary_Type %in% c ('Mid_Career_10th_Percentile_Salary', 'Mid_Career_50th_Percentile_Salary', 'Mid_Career_90th_Percentile_Salary')) %>%
    ggplot(aes(Region, mean_salary, fill = Region)) +
    geom_errorbar(aes(x = Region,  ymin = lower_ci, ymax = upper_ci), width = 0.4)+
    geom_col(width = 0.75) +
    labs(y = 'Salary') +
    facet_grid(~Salary_Type, labeller = labeller(Salary_Type = Salary_Type_dist.labs)) +
    theme_bw()+
    theme(legend.title = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.title.x = element_blank(),
          strip.text.x = element_text(size = 7, colour = "black"),
          panel.grid.major = element_blank()) +
    scale_fill_manual(values = c("lightpink", "lightpink1", "lightpink2", "lightpink3", "lightpink4"))+
    scale_y_continuous(label = dollar_format())
  
  # save the figure to the result folder
  ggsave(plot = p_dist_region, width = 10, height = 5,dpi = 300, filename = "results/salary_distribution_Region.png")
  
  
  # make the plot for the region vs salary based on the distribution of the midCareer Salary
  start_Mid_region <- df_region_est %>%
    filter(Salary_Type %in% c ('Starting_Median_Salary', 'Mid_Career_Median_Salary'))
  
  p_start_MidCareer_region <- start_Mid_region %>%
    ggplot(aes(x= fct_reorder(Region, mean_salary), y =mean_salary, color = Salary_Type)) +
    geom_point() +
    geom_errorbar(aes(x = Region, ymin = lower_ci, ymax = upper_ci), width = 0.2) +
    coord_flip(xlim = NULL, ylim = NULL, expand = TRUE, clip = "on") +
    labs( y = "Salary")+
    scale_color_discrete(labels = c("Average for the Mid-Career Median Salary", "Average for the Starting Median Salary")) +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          axis.title.y = element_blank(),
          legend.title=element_blank())+
    scale_y_continuous(label = dollar_format())
  
  # save the figure to the result folder
  ggsave(plot = p_start_MidCareer_region, width = 10, height = 5,dpi = 300, filename = "results/salary_change_Region.png")
  
  
  
}else if(feature_exp == 'School_Type'){
  # get the data for the school type
  df_SchoolType <- df %>%
    select(-School_Name, -Region)
  
  # duplicate created during join need to be removed
  df_schoolType_unique <- unique( df_SchoolType[ , ])
  
  # estimate the confidence interval
  df_schoolType_est <- df_schoolType_unique %>%
    group_by(School_Type,Salary_Type) %>%
    summarise(mean_salary = mean(Salary, na.rm = TRUE),
              sd = sd(Salary, na.rm = TRUE),
              n = n(),
              se = sd/sqrt(n),
              upper_ci = mean_salary + 1.96 * se,
              lower_ci = mean_salary - 1.96 * se)
  
  # make the School_Type to be factor
  df_schoolType_est$School_Type <- as.factor(df_schoolType_est$School_Type)
  
  # create facet labels
  Salary_Type_dist.labs <- c("Mid-Career 10th Percentile Salary", "Mid-Career 50th Percentile Salary", "Mid-Career 90th Percentile Salary")
  names(Salary_Type_dist.labs) <- c('Mid_Career_10th_Percentile_Salary', 'Mid_Career_50th_Percentile_Salary', 'Mid_Career_90th_Percentile_Salary')
  
  # make the plot for the School_Type vs salary based on the distribution of the midCareer Salary
  # the figure is facet by the Salary_Type 10th, 50th and 90th.
  p_dist_SchoolType <- df_schoolType_est %>%
    filter(Salary_Type %in% c ('Mid_Career_10th_Percentile_Salary', 'Mid_Career_50th_Percentile_Salary', 'Mid_Career_90th_Percentile_Salary')) %>%
    ggplot(aes(School_Type, mean_salary, fill = School_Type)) +
    geom_errorbar(aes(x = School_Type,  ymin = lower_ci, ymax = upper_ci), width = 0.4)+
    geom_col(width = 0.75) +
    labs(y = 'Salary') +
    facet_grid(~Salary_Type, labeller = labeller(Salary_Type = Salary_Type_dist.labs)) +
    theme_bw()+
    theme(legend.title = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.title.x = element_blank(),
          strip.text.x = element_text(size = 7, colour = "black"),
          panel.grid.major = element_blank()) +
    scale_fill_manual(values = c("lightpink", "lightpink1", "lightpink2", "lightpink3", "lightpink4"))+
    scale_y_continuous(label = dollar_format())
  
  # save the figure to the result folder
  ggsave(plot = p_dist_SchoolType, width = 10, height = 5,dpi = 300, filename = "results/salary_distribution_SchoolType.png")
  
  # make the plot for the region vs salary based on the distribution of the midCareer Salary
  start_Mid_SchoolType <- df_schoolType_est %>%
    filter(Salary_Type %in% c ('Starting_Median_Salary', 'Mid_Career_Median_Salary'))
  
  p_start_MidCareer_SchoolType <- start_Mid_SchoolType %>%
    ggplot(aes(x= fct_reorder(School_Type, mean_salary), y =mean_salary, color = Salary_Type)) +
    geom_point() +
    geom_errorbar(aes(x = School_Type, ymin = lower_ci, ymax = upper_ci), width = 0.2) +
    coord_flip(xlim = NULL, ylim = NULL, expand = TRUE, clip = "on") +
    labs( y = "Salary")+
    scale_color_discrete(labels = c("Average for the Mid-Career Median Salary", "Average for the Starting Median Salary")) +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          axis.title.y = element_blank(),
          legend.title=element_blank())+
    scale_y_continuous(label = dollar_format())
  
  # save the figure to the result folder
  ggsave(plot = p_start_MidCareer_SchoolType, width = 10, height = 5,dpi = 300, filename = "results/salary_change_SchoolType.png")
  
  
}else{
  print("Feature Not Found")
}
