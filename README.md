# DSCI_522_Salary-vs-College

### About the dataset

We chose to analyze a dataset about the salaries of US college graduates organized by college, region, type and major. This is publicly available [dataset](https://www.kaggle.com/wsj/college-salaries) on Kaggle. The original data is from *The Wall Street Journal*, which itself was based on a study done by *Payscale, Inc*.

Original data can be found here:

[Salary Increase by Type of College (WSJ)](http://online.wsj.com/public/resources/documents/info-Salaries_for_Colleges_by_Type-sort.html)

[Salaries by Region](http://online.wsj.com/public/resources/documents/info-Salaries_for_Colleges_by_Region-sort.html)

[Salary Increase by Major](http://online.wsj.com/public/resources/documents/info-Degrees_that_Pay_you_Back-sort.html)

### Importing the data

The original dataset was organized as .csv files. For this project, we will use R to import and handle our data analysis. 

Data import can be found [here](), in the `src` folder of our repository. 

### Our question

We decided to explore the dataset and ask whether there are any relationships between college region, type and major and graduates' salaries. This is an exploratory question.

### Our plan

1. Perform an exploratory data analysis of the dataset:  
    a. Look at school region, type, and degree    
    b. Compare each for all the different salaries (starting salary, mid-career salary, etc.)  
    c. Create plots to visualise the distributions of the data  

2. If we notice a particular patterns/differences in groups, we will quantify them using using hypothesis testing. For example, we could look for differences in the variables (school region, type, degree) that may impact graduates' salaries using ANOVA.   

### Potential summaries and visualizations

Many plots can be created for an exploratory analysis. For example, to visualize the distributions of data, violin or jitter plots that compare school type and salary could be made. We could also use ordered bar plots or dot plots to rank our data. For example, when comparing degree to starting salary, we would immediately see which degrees pay the highest and lowest directly after graduation. 

The final summary of our data will be represented as the result of a two-way ANOVA between school region, school type, and the resulting salary. The two-way ANOVA will tell us if there are any interaction effects between school region and type, and if there are is any statistically significant result that affects the final salary.
