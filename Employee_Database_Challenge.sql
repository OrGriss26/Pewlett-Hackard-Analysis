--------------------------------CHALLENGE
SELECT e.emp_no, 
	   e.first_name,
	   e.last_name,
	   tl.title, 
	   tl.from_date,
	   tl.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS tl
ON (e.emp_no = tl.emp_no) 
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
ORDER BY e.emp_no ASC;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title 
INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no ASC, rt.to_date DESC;

--file to retrieve the number of employees by their most recent job title
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.title DESC;


--query to create a Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	   e.first_name,
	   e.last_name,
	   e.birth_date, 
	   de.from_date,
	   de.to_date,
	   tl.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;