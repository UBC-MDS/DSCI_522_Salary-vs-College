library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1] # "data/clean_data/clean_salary_by_degree.csv"
output_file_path_1 <- args[2] # "results/degree_starting_to_MidCareer_SalaryChange.png"
output_file_path_2 <- args[3] # "results/degree_MidCareer_Salary.png"

df <- read_csv(input_file_path)

# Change the col type to factor to work with
df$Undergraduate_Major <- as.factor(df$Undergraduate_Major)
df$Salary_Type<- as.factor(df$Salary_Type)


# Make a plot about salary change from Start to MidCareer
plot_changing <- df %>%
  filter(Salary_Type %in% c( 'Starting_Median_Salary', 'Mid_Career_Median_Salary') )%>%
  group_by(Salary_Type) %>%
  ggplot(aes(x = fct_reorder(Undergraduate_Major, Salary), y = Salary)) +
  geom_point() +
  facet_grid(~Salary_Type) +
  coord_flip(xlim = NULL, ylim = NULL, expand = TRUE, clip = "on") +
  theme_bw() +
  theme(axis.title.y = element_blank(),
        axis.title.x = element_text(size = 15),
        strip.text.x = element_text(size = 15, colour = "black"))

ggsave(plot = plot_changing, width = 30, height = 10, dpi = 300, filename = output_file_path_1)

# Make a plot about the salary compare (10, 25, 50, 75, and 90 percentile)
plot_distribution <- df%>% 
  filter(Salary_Type %in% c( "Mid_Career_10th_Percentile_Salary", "Mid_Career_25th_Percentile_Salary", "Mid_Career_50th_Percentile_Salary", "Mid_Career_75th_Percentile_Salary", "Mid_Career_90th_Percentile_Salary"))%>%
  group_by(Salary_Type) %>%
  ggplot(aes(x = fct_reorder(Undergraduate_Major, Salary), y = Salary)) +
  geom_point() +
  facet_grid(~Salary_Type) +
  coord_flip(xlim = NULL, ylim = NULL, expand = TRUE, clip = "on") +
  theme_bw() +
  theme(axis.title.y = element_blank(),
        axis.title.x = element_text(size = 15),
        strip.text.x = element_text(size = 10, colour = "black"))

ggsave(plot = plot_distribution, width = 40, height = 10, dpi = 300, filename = output_file_path_2)