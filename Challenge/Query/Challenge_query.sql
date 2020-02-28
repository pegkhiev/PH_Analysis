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

--determine if there are duplicates using 
-- unique emp_no as identifier 
--(as names can be duplicated)
SELECT emp_no,
	count(*)
--INTO duplicate_numbers
FROM retirement_title_salary
GROUP BY emp_no
HAVING count(*)>1

-- Select duplicates based on emp_no
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

-- Title frequency and ordered by from_date
SELECT title, count(title), 
	MAX(from_date) AS from_date
INTO titles_by_date
FROM retirement_no_duplicates
GROUP BY title
ORDER BY from_date DESC

--Decide mentor candidates
SELECT e.emp_no, e.first_name, 
	e.last_name, ti.title, ti.from_date, 
	ti.to_date, s.salary
INTO mentor_candidates
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
INNER JOIN salaries AS s
ON (ti.emp_no = s.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' 
	AND '1965-12-31'
AND ti.to_date = '9999-01-01';
