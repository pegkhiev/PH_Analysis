--PART 1
-- Number of [titles] Retiring
-- JOIN Employees and titles tables
SELECT e.emp_no, e.first_name, 
	e.last_name, ti.title, ti.from_date,
	s.salary
INTO retirement_title_salary
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
INNER JOIN salaries AS s
ON (ti.emp_no = s.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND e.hire_date BETWEEN '1985-01-01' AND '1988-12-31'

--determine duplicates using emp_no as identifier
SELECT emp_no,
	count(*)
INTO duplicate_names
FROM retirement_title_salary
GROUP BY emp_no
HAVING count(*)>1

SELECT * FROM duplicate_names

-- Select duplicates and 
--choose only the latest from_date
SELECT rts.emp_no, rts.first_name, rts.last_name,
	rts.from_date, rts.title, rts.salary 
INTO retirement_no_duplicates
	FROM 
	(SELECT emp_no, first_name, last_name,
	 from_date, title, salary, 
	 ROW_NUMBER() OVER
	 (PARTITION BY (emp_no)
	 ORDER BY from_date DESC) rn
	 FROM retirement_title_salary) rts
	 WHERE rn=1;

--Order de-duplicated table by from_date
SELECT emp_no, first_name, last_name,
	 from_date, title, salary
INTO retirement_by_date
FROM retirement_no_duplicates
ORDER BY from_date DESC

--Checking the tables 
SELECT * FROM retirement_no_duplicates
SELECT * FROM retirement_by_date

--Do count of title frequency
SELECT title, count(*)
INTO retirement_title
FROM retirement_by_date
GROUP BY title

SELECT title, count(*)
FROM retirement_no_duplicates
GROUP BY title