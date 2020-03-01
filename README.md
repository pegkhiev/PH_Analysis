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

The question asked to create a new query containing emp_no, first and last name, title, from_date among employees born between 1952-1955, and hired between 1982-1985. __NOTE: the question did not ask to include current to_date for employees who are still currently hired in their present position. Therefore the resulting table contains duplicate rows because some employees have changed titles.__ 

__Number of employees INCLUDING duplicated rows is 65,427.__

The query used is a simple join from employees table and titles table, and applying conditions of birth_date and hire_date. A sample of the output is seen below showing duplicated rows

<img alt = "query1" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/query_retirement.png>

<img alt = "table1" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/retirement_title_salary.png>

## De-duplicated Retirement List 

To deduplicate the rows, the following query is used.  This is using a SELECT-OVER-PARTION BY query.  For the PARTITION BY function, emp_no is used because names can be the same for two different employees, but only emp_no is unique. 

First the sub-query is to apply row_number() for emp_no that are partitioned and ordered by their from_date in descending order, along with other columns. Therefore the latest date of the employee's employment is the first row number.  After the sub-query, the query is to select only the rows where the row_number is 1 for each emp_no.  This way only the most present title is chosen and removing the de-duplicated rows. 

__The total number of employees after de-duplication is 41,380.__

<img alt = "query_deduplication" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/query_deduplication.png>

<img alt = "deduplicated_table" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/deduplicated_retirement.png>

### Titles ordered by date 

To find out total number of titles for the full retirement list in descending order by their from_date, the query is grouped by title. I performed a count(title), and then MAX(from_date) aggregration to determine the latest date of the title.  Then the table is ordered by descending date so that the resulting table is in descending order by date. 

__The highest numbers are in Engineering department.  A total of 20,793 retiring employees are in Engineering department (Senior Engineers, Engineers, Assistant Engineers)__

<img alt = "query_titlebydate" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/query_titlebydate.png>

<img alt = "title_bydate" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/title_by_date.png>

## Mentor Candidates 

The question asked how many employees are candidates for mentorship. The condition is that they must be born in 1965.  As all retirees are born between 1952-1955, NONE of them would qualify.  Therefore the query goes back to the employees table, and joined with titles table, applying the condition of birth_date in 1965. 

__The total number of candidates born in 1965 is 1,550__ 

<img alt = "query_mentor" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/query_candidates.png>

<img alt = "mentor" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/mentor.png>

## Further Analysis 

1) The above retirement list includes those who have already left the companies, so the extra condition of ensuring that they are still presently hired should be included.  This can be done by just simply adding the extra condition in the "retirement" query.  This would also remove the step of deduplicating the rows because only the present titles will be included already. 

2) Another analysis is to apply conditions to the mentor candidates table - e.g. including only employees of senior level in the mentorship candidates pool, or only employees in Engineering, as Engineering is the most affected department with the most people retiring. 




