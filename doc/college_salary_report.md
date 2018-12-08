
Exploring attributes of US college education in relation to career salary
=========================================================================

**By**: Alex Pak, Linyang Yu, Constantin Shuster
**Date**: December 8, 2018

### Our question

We were interested in exploring whether there are any relationships between certain attributes of US college education and graduates' salaries. Specifically, we analyzed the relationships between college region, type and degree on starting and mid-career salaries. Our question is exploratory and hypothesis generating. If we observed a relationship in the data, we created a hypothesis and tested it.

College region refers to one of the major regions of the US: Northeast, Midwest, South, West and California. College type refers to the main types of colleges in the US: Liberal Arts, Engineering, Ivy League, Party and State colleges. College degree refers to the college major, for example chemical engineering, accounting, etc.

Starting career salary was a median value. Mid-career salary was either 10th, 25, 50th (median), 75th or 90th percentile salary. Mid-career salary was the salary at **10 years** from graduation.

### Our dataset

The dataset was downloaded from [kaggle](https://www.kaggle.com/wsj/college-salaries) and is originally from *The Wall Street Journal* but based on a study done by *Payscale, Inc.*. The data is split into 3 tables. The first table contains College degrees and the corresponding salary data. The second table lists colleges, their region and corresponding salary data. The third table lists colleges, their type and corresponding salary data.

To begin our analysis we cleaned up the data tables by converting character data into numerical data so it can analyzed and visualized appropriately. We removed any spaces in the heading or '$'. We also joined the second two tables such that our joined table listed colleges, their region, their type and corresponding salary data.

### Exploratory data analysis (EDA)

##### Salary by college degree

We were first interested in examining how starting and mid-career salaries varied by college degree. Figure 1 and 2 below are [dumbbell plots](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Dumbbell%20Plot) where the **starting point** of the dumbbell is the **starting career salary** and the **end point** is the **mid-career salary**. Both salary values are median salaries.

![Figure 1](../results/degree_vs_salary_by_start.png)

![Figure 2](../results/degree_vs_salary_by_mid.png)

Figure 3 is also a dumbbell plot but it displays the range of **mid-career** salaries by **college degree**. The range is from 10th to 90th percentile and the median is the point in red. The salary data was ordered by median mid-career salary.

![Figure 3](../results/degree_vs_mid_salary_range.png)

##### Salary by college region

The next variable we examined was college region and its impact on graduates' salaries. Figure 4 shows start and mid-career salary aggregated by college region. The salary data was represented as mean estimates with 95% confidence intervals. The mean estimates were of *median* start and mid career salaries of colleges in each region that were available in the *joined* table.

![Figure 4](../results/salary_change_Region.png)

Figure 5 shows the mid-career salaries of the different US college regions, split into panels of 10th, 50th and 90th percentiles. We did this to look at whether the same pattern was observed across the full salary range, and whether certain regions were associated with the potential to achieve a higher "top" salary. Salary data was also represented as mean estimates with a 95% confidence interval.

![Figure 5](../results/salary_distribution_Region.png)

##### Salary by college type

Lastly, we examined how graduates' salary varied by college type. Figure 6 and 7 are similar analyses to figure 4 and 5 respectively, only the variable is college type. Salary data was calculated in the exact same manner as described in figure 4 and 5.

![Figure 6](../results/salary_change_SchoolType.png)

![Figure 7](../results/salary_distribution_SchoolType.png)

### Results

Since we had only 1 data point for each school degree, we could not do any hypothesis testing and thus we report here only major trends we observed in the data from the Figure 1, 2 and 3. From these figures we can see that graduates from STEM majors (Science, Technology and Mathematics) have higher salaries both at the start of their career and in the middle of their career. Graduates with majors in education or the arts/social sciences had the lowest salaries.

In regards to salary variation by school region, our EDA shows that California and Northeastern colleges may be associated with higher salaries both at the start and middle of their career. We performed a one-way ANOVA to test whether a difference in salary was present amongst the regions, shown in Table 1 below. The ANOVA tests (for all salary types) were statistically significant.

**Table 1**

| Salary Type                       |  F Statistic|       p-value|
|:----------------------------------|------------:|-------------:|
| Starting Median Salary            |        12.10|  3.398112e-09|
| Mid Career Median Salary          |        17.38|  5.700000e-13|
| Mid Career 10th Percentile Salary |         8.71|  1.187212e-06|
| Mid Career 25th Percentile Salary |        12.69|  1.246776e-09|
| Mid Career 50th Percentile Salary |        17.38|  5.700000e-13|
| Mid Career 75th Percentile Salary |        18.28|  1.340000e-13|
| Mid Career 90th Percentile Salary |        13.88|  2.306060e-10|

Next we performed Tukey's post-hoc tests to determine which region was responsible for the difference in salary. Table 2 summarizes Tukey's tests between region with regard to starting salary while Table 3 summarizes the results with regard to mid-career salary. All the Tukey's post hoc tests for each salary type, as well as ANOVA table are available in the `results/anova_results` folder.

**Table 2**

|              | California | Northeastern | Southern | Western | Midwestern |
|--------------|:-----------|:-------------|:---------|:--------|:-----------|
| California   | NA         | 0.251        | \*\*\*   | \*\*\*  | \*\*\*     |
| Northeastern | 0.251      | NA           | \*\*\*   | \*\*    | \*\*\*     |
| Southern     | \*\*\*     | \*\*\*       | NA       | 1       | 0.9993     |
| Western      | \*\*\*     | \*\*         | 1        | NA      | 1          |
| Midwestern   | \*\*\*     | \*\*\*       | 0.9993   | 1       | NA         |

-   = &lt;0.05, \*\* = &lt;0.01, \*\*\* = &lt;0.001

**Table 3**

|              | California | Northeastern | Southern | Western | Midwestern |
|--------------|:-----------|:-------------|:---------|:--------|:-----------|
| California   | NA         | 0.9549       | \*\*\*   | \*\*\*  | \*\*\*     |
| Northeastern | 0.9549     | NA           | \*\*\*   | \*\*\*  | \*\*\*     |
| Southern     | \*\*\*     | \*\*\*       | NA       | 0.963   | 0.9537     |
| Western      | \*\*\*     | \*\*\*       | 0.963    | NA      | 1          |
| Midwestern   | \*\*\*     | \*\*\*       | 0.9537   | 1       | NA         |

-   = &lt;0.05, \*\* = &lt;0.01, \*\*\* = &lt;0.001

Table 2 and 3 show that graduates of colleges in the Northeast and California had higher salaries than the other regions, however there was no statistically significant difference at alpha = 0.05 between colleges in the Northeast and California.

In regards to salary variation by school type, our hypothesis from the EDA was that there is a difference in salary depending on which college type a graduate attended. We performed a one-way ANOVA shown in Table 4 below. The one-way ANOVA showed a significant difference amongst school types across all salary comparison types at a significance level of &lt; 0.05

**Table 4**

| Salary Type                       |  F Statistic|     p-value|
|:----------------------------------|------------:|-----------:|
| Starting Median Salary            |        66.81|  0.0000e+00|
| Mid Career Median Salary          |        54.69|  0.0000e+00|
| Mid Career 10th Percentile Salary |        42.43|  2.5089e-26|
| Mid Career 25th Percentile Salary |        51.27|  0.0000e+00|
| Mid Career 50th Percentile Salary |        54.69|  0.0000e+00|
| Mid Career 75th Percentile Salary |        64.17|  0.0000e+00|
| Mid Career 90th Percentile Salary |        57.32|  0.0000e+00|

Table 5 and 6 show the results of the Tukey's post-hoc tests for starting and mid-career median salaries respectively, which were performed in order to determine which school type was responsible for the difference found via the one-way ANOVA testing.

**Table 5**

|              | Ivy League | Engineering | Liberal Arts | Party  | State  |
|--------------|:-----------|:------------|:-------------|:-------|:-------|
| Ivy League   | NA         | 0.9818      | \*\*\*       | \*\*\* | \*\*\* |
| Engineering  | 0.9818     | NA          | \*\*\*       | \*\*\* | \*\*\* |
| Liberal Arts | \*\*\*     | \*\*\*      | NA           | 1      | 0.1952 |
| Party        | \*\*\*     | \*\*\*      | 1            | NA     | 0.5768 |
| State        | \*\*\*     | \*\*\*      | 0.1952       | 0.5768 | NA     |

-   = &lt;0.05, \*\* = &lt;0.01, \*\*\* = &lt;0.001

**Table 6**

|              | Ivy League | Engineering | Liberal Arts | Party  | State  |
|--------------|:-----------|:------------|:-------------|:-------|:-------|
| Ivy League   | NA         | \*\*        | \*\*\*       | \*\*\* | \*\*\* |
| Engineering  | \*\*       | NA          | \*\*\*       | \*\*\* | \*\*\* |
| Liberal Arts | \*\*\*     | \*\*\*      | NA           | 0.4705 | \*\*\* |
| Party        | \*\*\*     | \*\*\*      | 0.4705       | NA     | 0.1121 |
| State        | \*\*\*     | \*\*\*      | \*\*\*       | 0.1121 | NA     |

-   = &lt;0.05, \*\* = &lt;0.01, \*\*\* = &lt;0.001

The results of Table 5 and 6 show that graduates from Ivy League schools or Engineering schools had higher salaries than the other school types, however there was no significant difference between graduates of Ivy League and Engineering schools.

### Interpretation

When comparing college degrees to salary, the Engineering fields consistently appear as the top earners. Of the top 10 spots (when comparing starting salary), Engineering degrees dominate, appearing in 7/10 spots. Although this might imply that STEM fields are high earners, it seems to only apply to the applied STEM field; for example, the more conventional science fields such as psychology and biology fall much lower on the list. These results are similar to this [study](https://study.com/articles/Undergraduate_Degree_vs_Graduate_Degree_Income_and_Salary_Comparison.html).

Looking at the Tukey procedure results for Region vs. Salary, the Northeastern and California seem to have similar means, as the null hypothesis consistently cannot be rejected across multiple salary types. This seems to make sense, as California and the Northeastern region contain highly rated schools (ex. Stanford, California Institute of Technology, Harvard).

The Tukey procedure results for School Type vs Salary seems to follow this interpretation. From the visualizations, Ivy League schools consistently place highly on the salary scale. However, when using the Tukey procedure, it seems as if there is no significant difference between the Ivy League school earnings and Engineering school earnings, suggesting once again that Engineering degrees are worth the most. Our results are similar to an analysis by the [Washington Post](https://www.washingtonpost.com/news/wonk/wp/2015/09/14/this-chart-shows-why-parents-push-their-kids-so-hard-to-get-into-ivy-league-schools/?noredirect=on&utm_term=.23ad81f0b9b1) which also showed graduation from Ivy League scools is associated with the highest career salaries.

### Limitations

One of the major limitations of our analysis was that for the dataset we chose, the individual datapoints for each salary were not given. Instead, the medians for each salary type were pre-calculated and tabulated into this dataset. This meant that: \* We had to take the dataset as the absolute truth since we could not calculate the medians ourselves, and \* We could not see the spread of the datapoints (ie. summary statistics, or visualizing the data as a boxplot).

Although the median is a robust summary statistic (compared to the mean, for example), it would have made our analysis more trustworthy if we were able to view and manipulate the individual datapoints.

Another limitation of our analysis is that ANOVA tests assume an equal variance between all levels of a factor. In our analysis, we did not check this assumption before performing the ANOVA tests.

### Future directions

In the future, to check the credibility of our ANOVA test, we can perform a Levene's Test. A Levene's Test assess the equality of variances between different factors. If our dataset passes the Levene's Test, it would add extra credibility to our ANOVA results.

Another potential visual exploration for our dataset would be to import a seperate dataset containing all US College names and the state they are based in (one such example can be found [here](https://trends.collegeboard.org/college-pricing/figures-tables/tuition-fees-flagship-universities-over-time)). By joining the state names to the college names in our dataset, we would be able to create a visual map of the United States, with each state containing salary information on a colour scale.

To further enhance our analysis, we could compare the top performing degrees in the States with the top performing degrees in Canada. It would be interesting to see differences in top degrees and the differences in starting/mid-career salaries between Canadian universities and colleges in the States (or if there is even a difference at all).

### References

1.  [Kaggle Data - College vs Salary](https://www.kaggle.com/wsj/college-salaries)
2.  [Dumbbell plots explained](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Dumbbell%20Plot)
3.  [Study.com - Undergraduate degree salary comparison](https://study.com/articles/Undergraduate_Degree_vs_Graduate_Degree_Income_and_Salary_Comparison.html)
4.  [Washington Post - Ivy League school salary comparison](https://www.washingtonpost.com/news/wonk/wp/2015/09/14/this-chart-shows-why-parents-push-their-kids-so-hard-to-get-into-ivy-league-schools/?noredirect=on&utm_term=.23ad81f0b9b1)
