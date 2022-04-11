--Retrieve the emp_no, first_name, and last_name columns from the Employees table.
--Retrieve the title, from_date, and to_date columns from the Titles table.
--Create a new table using the INTO clause.
--Join both tables on the primary key.
--Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
Join titles AS t
On (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

select * from retirement_titles;

--Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
--These columns will be in the new table that will hold the most recent title of each employee.
--Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
--Use Dictinct with Orderby to remove duplicate rows
--Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'.
--Create a Unique Titles table using the INTO clause.
SELECT DISTINCT ON (rt.emp_no)rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;

--First, retrieve the number of titles from the Unique Titles table.
select count (ut.emp_no), ut.title
--create a Retiring Titles table to hold the required information
INTO retiring_title
from unique_titles as ut
--Group the table by title, then sort the count column in descending order.
group by ut.title
order by count(ut.emp_no) desc;

select * from retiring_title;


-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns from the Department Employee table.
-- Retrieve the title column from the Titles table.
--select e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
-- Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Create a new table using the INTO clause.
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
-- Join the Employees and the Department Employee tables on the primary key.
-- Join the Employees and the Titles tables on the primary key.
from employees as e
	INNER JOIN dept_emp as de
	on (e.emp_no = de.emp_no)
	INNER JOIN titles as t
	on (e.emp_no = t.emp_no)
where (de.to_date = '9999-01-01') and (birth_date between '1965-01-01'and '1965-12-31')
--Order the table by the employee number
ORDER BY e.emp_no;

select * from mentorship_eligibility;

select count(emp_no) AS "total Count", title
from mentorship_eligibility
group by title
order by "total Count" desc;