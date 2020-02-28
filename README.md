# PH_Analysis

## Background

The project required use of ERD to determine the relationship of the various csv files for Pewlett-Hackard, and then use SQL to import all csv files, and perform various queries. The questions to be answered are: 
- How many employees born between 1952 - 1955, and hired between 1982-1985 will be retiring 
- How to de-duplicate the names due to people changing titles 
- How many people born in 1965 are candidates for mentorship program 

## ERD 

From the ERD, it can be seen that for dept_managers and dept_emp tables, __neither the dept_no nor emp_no alone can be primary keys because they are not unique due to employees moving between departments__.  Therefore the combination of dept_no and emp_no are combined to be primary keys.

For Titles table, __again the emp_no is not unique__, and therefore the combination of emp_no and title are set to be primary keys. 

<img alt = "ERD" src = https://github.com/pegkhiev/PH_Analysis/blob/master/Challenge/ERD.png>


full retirement list _ 65427 

no_duplicates - 41380
mentor candidates - 1550
