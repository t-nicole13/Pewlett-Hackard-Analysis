--Determine Retirment Eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

--Search for only 1952 birth dates
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

--Search for only 1953 birth dates
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

--Search for only 1954 birth dates
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

--Search for only 1955 birth dates
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

--Retirement Eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Creating a new table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info CASCADE;

--View new table
SELECT *
FROM retirement_info;


DROP TABLE retirement_info;

--Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Check the table
SELECT *
FROM retirement_info;

--Joining departments and dept_manaer tables (inner join)
SELECT departments.dept_name,
	   dept_manager.emp_no,
	   dept_manager.from_date,
	   dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

--Joining retirement_info and dept_employee tables (left join)
SELECT retirement_info.emp_no,
	   retirement_info.first_name,
	   retirement_info.last_name,
	   dept_employee.to_date
FROM retirement_info
LEFT JOIN dept_employee
ON retirement_info.emp_no = dept_employee.emp_no;

--Joining retirement_info and dept_employee tables (left join and aliases)
SELECT ri.emp_no,
       ri.first_name,
	   ri.last_name,
	   de.to_date
FROM retirement_info as ri
LEFT JOIN dept_employee as de
ON ri.emp_no = de.emp_no;

--Joining departments and dept_manaer tables (inner join and updating with aliases)
SELECT d.dept_name,
	   dm.emp_no,
	   dm.from_date,
	   dm.to_date
FROM dept_manager as dm
INNER JOIN departments as d
ON d.dept_no = dm.dept_no;

--Left join for retirement_info and dept_emp tables
SELECT ri.emp_no,
	   ri.first_name,
	   ri.last_name,
	   de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employee as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_employee as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

--Employee count by department number (add ORDER BY)
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_employee as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--Employee count by department number (add new table to export to CSV)
SELECT COUNT(ce.emp_no), de.dept_no
INTO employee_count
FROM current_emp as ce
LEFT JOIN dept_employee as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- List 1: Employee Information
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.gender,
	   s.salary,
	   de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s 
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employee as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List 2: Management
SELECT dm.dept_no,
	   d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
FROM dept_manager as dm
INNER JOIN departments as d
	ON (dm.dept_no = d.dept_no )
INNER JOIN current_emp as ce
	ON (dm.emp_no = ce.emp_no);


-- List 3 Department Retirees
SELECT ce.emp_no,
       ce.first_name,
	   ce.last_name,
	   d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employee as de
	ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d 
	ON (de.dept_no = d.dept_no);

-- Obj: Sales team wants the retirement_info table for their department only
-- Needed emp_no, first_name, last_name, and dept_name
SELECT ri.emp_no,
	   ri.first_name,
	   ri.last_name,
	   d.dept_name
INTO sales_info
FROM retirement_info AS ri
INNER JOIN dept_employee As de
	ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';


-- Obj: Sales team wants the retirement_info table for sales and development departments
-- Needed emp_no, first_name, last_name, and dept_name
SELECT ri.emp_no,
	   ri.first_name,
	   ri.last_name,
	   d.dept_name
--INTO sales_dev_info
FROM retirement_info AS ri
INNER JOIN dept_employee As de
	ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');

-- Create a new table using the INTO clause and join both tables on the primary key.
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   t.title,
	   t.from_date,
	   t.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE birth_date BETWEEN '1952-01-01'  AND '1955-12-31'
ORDER BY e.emp_no;
		