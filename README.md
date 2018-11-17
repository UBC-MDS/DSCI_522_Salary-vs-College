# DSCI_522_Salary-vs-College

### About the dataset

We chose to analyze a dataset about the salaries of US college graduates organized by college, region, type and major. This is publicly available [dataset](https://www.kaggle.com/wsj/college-salaries) on Kaggle. The original data is from *The Wall Street Journal*, which itself was based on a study done by *Payscale, Inc*.

Original data can be found here:

[Salary Increase by Type of College (WSJ)](http://online.wsj.com/public/resources/documents/info-Salaries_for_Colleges_by_Type-sort.html)

[Salaries by Region](http://online.wsj.com/public/resources/documents/info-Salaries_for_Colleges_by_Region-sort.html)

[Salary Increase by Major](http://online.wsj.com/public/resources/documents/info-Degrees_that_Pay_you_Back-sort.html)

### Importing the data

The original dataset was organized as .csv files. For this project, we will use R to import and handle our data analysis.

Imported data can be found [here](https://github.com/UBC-MDS/DSCI_522_Salary-vs-College/tree/master/data), in the `data` folder of our repository. Scripts that handle the data import can be found [here](https://github.com/UBC-MDS/DSCI_522_Salary-vs-College/tree/master/src), in the `src` folder. 

### Our question

We decided to explore the dataset and ask whether there are any relationships between college region, type and major to graduates' salaries. This is an exploratory question.

### Our plan

1. Perform an exploratory data analysis of the dataset:  
    a. Investigate school region, type, and degree as they relate to graduates' salaries  
    b. Look the different salaries: starting salary, mid-career salary, etc.  
    c. Create plots to visualise the distributions of the data   

2. If we find any patterns/differences in groups, we will validate/quantify them using hypothesis testing. For example, we could look for differences in the variables (school region, type, degree) that may impact graduates' salaries using ANOVA.   

### Potential summaries and visualizations

To visualize the distribution of the data we plan to use violin/jitter plots that, for example, look at the distribution of salary by school type. We will also use ordered bar/dot plots to rank our data; for example, to see which degrees pay the highest and lowest directly after graduation we may compare degree type to starting salary.

We will summarise any differences in graduates' salary within each variable (school region, type, major) using an ANOVA.

### Directory structure
```
project_root/
├── doc/
│   ├── final_report.Rmd
├── src/
│   ├── import_data.R
│   ├── Data_cleaning.R
│   ├── analyze_data.R
│   ├── viz_data.R
├── data/
│   ├── clean_salary_by_degree.csv
│   ├── clean_salary_by_region.csv
│   ├── clean_salary_by_type.csv
│   ├── degrees-that-pay-back.csv
│   ├── salaries-by-college-type.csv
│   ├── salaries-by-region.csv
├── results/
│   ├── fig.png
│   ├── stat_result.csv
├── README.md
```