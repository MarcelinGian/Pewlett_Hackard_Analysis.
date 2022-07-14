-- CHALLENGE CODE!
-- DELIVERABLE 1:
-- 1. Create a Retirement Titles table that holds all the titles of employees 
--...who were born between January 1, 1952 and December 31, 1955.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
--INTO retirement_titles
FROM employees as e
	INNER JOIN titles as t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no
;

-- 2. Some employees may have multiple titles in the database—for example, due to promotions so 
--...use 'DISTINCT ON' with 'ORDER BY' to remove duplicate rows and 
--...create a table that contains the most recent title of each employee. 
--...Exclude employees who have already left the company.
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
					rt.first_name,
					rt.last_name,
					rt.title
--INTO unique_titles
FROM retirement_titles AS rt
WHERE to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

-- 3. Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT (title), title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT (title) DESC;

-- DELIVERABLE 2:
-- 1. create a mentorship-eligibility table that holds the current
--...employees who were born between January 1, 1965 and December 31, 1965.
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
--INTO mentorship_eligibilty
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE de.to_date = ('9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;


-- ADDITIONAL QUERY:
-- Count total number of employees by their most recent job 
-- ..title who are about to retire.
SELECT SUM(a.cnt)
	from(
			SELECT COUNT (title) AS cnt
			FROM unique_titles
			GROUP BY title
) as a

-- ADDITIONAL QUERY:
-- Count by title of mentorship-eligibility table
SELECT COUNT (title), title
FROM mentorship_eligibilty
GROUP BY title
ORDER BY COUNT (title) DESC;

-- ADDITIONAL QUERY:
-- Count total number of mentors by their most recent job 
-- ..title
SELECT SUM(a.cnt)
	FROM(
			SELECT COUNT (title) AS cnt
			FROM mentorship_eligibilty
			GROUP BY title
) AS a;