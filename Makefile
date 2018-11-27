# Create cleaned data file
all: results/anova_results results/increase_in_salary.csv results/salary_distribution_SchoolType.png results/salary_change_SchoolType.png results/salary_distribution_Region.png results/salary_change_Region.png

data/clean_data/clean_salary_by_degree.csv : data/raw_data/degrees-that-pay-back.csv src/Data_cleaning.R
	Rscript src/Data_cleaning.R data/raw_data/degrees-that-pay-back.csv data/clean_data/clean_salary_by_degree.csv

data/clean_data/clean_salary_by_type.csv : data/raw_data/salaries-by-college-type.csv src/Data_cleaning.R
	Rscript src/Data_cleaning.R data/raw_data/salaries-by-college-type.csv data/clean_data/clean_salary_by_type.csv

data/clean_data/clean_salary_by_region.csv : data/raw_data/salaries-by-region.csv src/Data_cleaning.R
	Rscript src/Data_cleaning.R data/raw_data/salaries-by-region.csv data/clean_data/clean_salary_by_region.csv

# join the tables together
data/clean_data/clean_salary_by_region_type_join.csv : data/clean_data/clean_salary_by_type.csv data/clean_data/clean_salary_by_region.csv Rscript Join_region_and_type.R
	Rscript Join_region_and_type.R data/clean_data/clean_salary_by_region.csv data/clean_data/clean_salary_by_type.csv data/clean_data/clean_salary_by_region_type_join.csv

# Create EDA for degree vs. Salary
results/degree_vs_salary_by_start.png results/degree_vs_salary_by_mid.png results/degree_vs_mid_salary_range.png : data/clean_data/clean_salary_by_degree.csv src/EDA_degree-vs-salary.R
	Rscript src/EDA_degree-vs-salary.R data/clean_data/clean_salary_by_degree.csv

# Create EDA for region to Salary
results/salary_distribution_Region.png results/salary_change_Region.png : data/clean_data/clean_salary_by_region_type_join.csv src/EDA_region_and_school_type_to_salary.R
	Rscript src/EDA_region_and_school_type_to_salary.R data/clean_data/clean_salary_by_region_type_join.csv Region

# Create EDA for School_Type to Salary
results/salary_distribution_SchoolType.png results/salary_change_SchoolType.png : data/clean_data/clean_salary_by_region_type_join.csv src/EDA_region_and_school_type_to_salary.R
	Rscript src/EDA_region_and_school_type_to_salary.R data/clean_data/clean_salary_by_region_type_join.csv School_Type

# ANOVA and tukey pairwise test
results/anova_results : data/clean_data/clean_salary_by_region_type_join.csv anova_tukey_tests.R
	Rscript anova_tukey_tests.R data/clean_data/clean_salary_by_region_type_join.csv results/anova_results

# other data analysis done for the final report
results/increase_in_salary.csv : data/clean_data/clean_salary_by_region_type_join.csv Increase_in_salary.R
	Rscript Increase_in_salary.R data/clean_data/clean_salary_by_region_type_join.csv results/increase_in_salary.csv
