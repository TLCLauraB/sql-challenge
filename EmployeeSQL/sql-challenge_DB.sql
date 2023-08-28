-- IMPORTING CVS

-- Create a Table: Departments
CREATE TABLE departments(
  dept_no VARCHAR NOT NULL,
  dept_name VARCHAR NOT NULL
);

ALTER TABLE departments ADD PRIMARY KEY (dept_no);

-- Query all fields from the Table: Departments
SELECT *
FROM departments;

-- Create a Table: Dept_Emp
CREATE TABLE dept_emp(
  emp_no INT NOT NULL,
  dept_no VARCHAR NOT NULL
);

ALTER TABLE dept_emp ADD FOREIGN KEY (dept_no) REFERENCES departments(dept_no);

-- Query all fields from the Table: Dept_Emp
SELECT *
FROM dept_emp;

-- Create a Table: Dept_Manager
CREATE TABLE dept_manager(
  dept_no VARCHAR NOT NULL,
  emp_no INT NOT NULL
);

ALTER TABLE dept_manager ADD FOREIGN KEY (dept_no) REFERENCES departments(dept_no);
ALTER TABLE dept_manager ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

-- Query all fields from the Table: Dept_Manager
SELECT *
FROM dept_manager;

-- Create a Table: Employees
CREATE TABLE employees(
	emp_no INT NOT NULL,
	emp_title_id VARCHAR NOT NULL,
	birth_date VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date VARCHAR NOT NULL
);

ALTER TABLE employees ADD PRIMARY KEY (emp_no);

-- Query all fields from the Table: Employees
SELECT *
FROM employees;

-- Create a Table: Salaries
CREATE TABLE salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL
);

ALTER TABLE salaries ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

-- Query all fields from the Table: Salaries
SELECT *
FROM salaries;

-- Create a Table: Titles
CREATE TABLE titles(
	title_id VARCHAR NOT NULL,
	title VARCHAR NOT NULL
);

-- Query all fields from the Table: Titles
SELECT *
FROM titles;

-- QUESTIONS

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    e.sex,
    s.salary
FROM
    employees AS e
JOIN
    salaries AS s ON e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT
    first_name,
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '1/1/1996' AND '12/31/1986';
	
-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT
    dm.dept_no,
    d.dept_name,
    dm.emp_no,
    e.last_name,
    e.first_name
FROM
    dept_manager AS dm
JOIN
    departments AS d ON dm.dept_no = d.dept_no
JOIN
    employees AS e ON dm.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT
    de.dept_no,
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM
    dept_emp AS de
JOIN
    employees AS e ON de.emp_no = e.emp_no
JOIN
    departments AS d ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT
    first_name,
    last_name,
    sex
FROM
    employees
WHERE
    first_name = 'Hercules' AND
    last_name LIKE 'B%';
	
-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    employees AS e
JOIN
    dept_emp AS de ON e.emp_no = de.emp_no
JOIN
    departments AS d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM
    employees AS e
JOIN
    dept_emp AS de ON e.emp_no = de.emp_no
JOIN
    departments AS d ON de.dept_no = d.dept_no
WHERE
    d.dept_name IN ('Sales', 'Development');

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT
    last_name,
    COUNT(*) AS frequency
FROM
    employees
GROUP BY
    last_name
ORDER BY
    frequency DESC;
