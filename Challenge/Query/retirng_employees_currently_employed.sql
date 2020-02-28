SELECT e.emp_no, e.first_name, 
	e.last_name, ti.title, ti.from_date,
	s.salary
INTO retirement_title_salary_2
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
INNER JOIN salaries AS s
ON (ti.emp_no = s.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND e.hire_date BETWEEN '1985-01-01' AND '1988-12-31'
AND ti.to_date = '9999-01-01'

SELECT emp_no,
	count(*)
--INTO duplicate_numbers
FROM retirement_title_salary_2
GROUP BY emp_no
HAVING count(*)>1