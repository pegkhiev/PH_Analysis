# PH_Analysis

## Background

The project required use of ERD to determine the relationship of the various csv files for Pewlett-Hackard, and then use SQL to import all csv files, and perform various queries. The questions to be answered are: 
- How many employees born between 1952 - 1955, and hired between 1982-1985 will be retiring 
- How to de-duplicate the names due to people changing titles 
- How many people born in 1965 are candidates for mentorship program 

### Note to Grader: The full queries are included in the folder "Challenge/Query" - the README only includes PARTS of the full query, thank you. 

## ERD 

From the ERD, it can be seen that for dept_managers and dept_emp tables, __neither the dept_no nor emp_no alone can be primary keys because they are not unique due to employees moving between departments__.  Therefore the combination of dept_no and emp_no are combined to be primary keys.

For Titles table, __again the emp_no is not unique__, and therefore the combination of emp_no and title are set to be primary keys. 

<img alt = "ERD" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/ERD.png>

## Full Retirement List 

The question asked to create a new query containing emp_no, first and last name, title, from_date among employees born between 1952-1955, and hired between 1982-1985. __NOTE: the question did not ask to include current to_date for employees to identify who are still currently hired in their present position. Therefore the resulting table contains duplicate rows because some employees have changed titles.__ 

__Number of employees INCLUDING duplicated rows is 65,427.__

### Note: This FULL RETIREMENT LIST does not take into account the current employment to_date, because the challenge question didn't specify that. So some employees could have already left the company.  Therefore this number is only accurate according to the CHALLENGE question, but is NOT accurate in excluding those who have already left. 

A sample of the output is seen below showing duplicated rows.

<img alt = "table1" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/retirement_title_salary.png>

### However, if the query includes people born between 1952-1955, hired between 1982-1985, and employment to_date is present (9999-01-01), then the result is 33,118 employees eligible for retirement.  There is no duplicate of employees.  While there are duplicated names, they are unique individuals because no emp_no is duplicated, and no individual employees having multiple titles. The query is in the Challenge folder, and the output csv file is in the challenge folder, titled "retirement_title_salary_2.csv". 


## De-duplicated Retirement List 

If we continue with the first query parameters: employees born between 1952-1955, and hired between 1982-1985, to deduplicate the rows, the following query is used.  This is using a SELECT-OVER-PARTION BY query.  For the PARTITION BY function, __emp_no__ is used because names can be the same for two different employees, but only emp_no is unique. 

First the sub-query is to apply row_number() for emp_no that are partitioned and ordered by their from_date in descending order, along with other columns. Therefore the latest date of the employee's employment is the first row number.  After the sub-query, the query is to select only the rows where the row_number is 1 for each emp_no.  This way only the most present title is chosen and removing the de-duplicated rows. 

__The total number of employees after de-duplication is 41,380.__

### Note: However as the FULL RETIREMENT LIST does not take into account the employment date, so even after the deduplication, some employees could have already left the company.  Therefore this number is only accurate as to deduplicating "full retirement list", but is NOT accurate in excluding those who have already left. This is included in my Further Analysis section.  This section is mainly to show the use of a different type of query. 

<img alt = "query_deduplication" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/query_deduplication.png>

<img alt = "deduplicated_table" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/deduplicated_retirement.png>



## Titles ordered by date 

To find out total number of titles for the full retirement list in descending order by their from_date, the query is grouped by title. I performed a count(title), and then MAX(from_date) aggregration to determine the latest date of the title.  Then the table is ordered by descending date so that the resulting table is in descending order by date. 

The highest numbers are in Engineering department.

__Note: the data is selected from ONLY those who are still currently employed. Therefore the total is 33,118.__


<img alt = "titles_by_date" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/titles_by_date_2.png>

## Mentor Candidates 

The question asked how many employees are candidates for mentorship. The condition is that they must be born in 1965.  As all retirees are born between 1952-1955, NONE of them would qualify.  Therefore the query goes back to the employees table, and joined with titles table, applying the condition of birth_date in 1965. 

__The total number of candidates born in 1965 is 1,549__ 

<img alt = "query_mentor" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/query_candidates.png>

<img alt = "mentor" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/mentor.png>

## Further Analysis 

1) The question should clarify and specify the conditions for determining number of people retiring.  I've included both sets of output, but the brief was not very clear. 

2) Another analysis is to apply conditions to the mentor candidates table - e.g. including only employees of senior level in the mentorship candidates pool, or only employees in Engineering, as Engineering is the most affected department with the most people retiring. 




