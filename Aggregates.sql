/*
📊 What Are Aggregate Functions?
Aggregate functions perform a calculation on a set of values and return a single value. 
They're commonly used with the GROUP BY clause to summarize data.

🔑 Common SQL Aggregate Functions
Here are the most important ones:

📊 Aggregate Function Examples
1. COUNT()
How many employees are there?

--solution--
SELECT count(sa.employee_id) 
FROM parks_and_recreation.employee_demographics de
JOIN parks_and_recreation.employee_salary sa
	ON de.employee_id = sa.employee_id

2. SUM()
What is the total salary paid to all employees?

--solution--
SELECT SUM(salary)
FROM parks_and_recreation.employee_salary

3. AVG()
What is the average age of employees?

--solution--
SELECT avg(age) FROM parks_and_recreation.employee_demographics

4. MIN() and MAX()
What is the minimum and maximum salary?

--solution--
SELECT min(sal.salary), max(sal.salary)
FROM parks_and_recreation.employee_salary sal

5. GROUP BY with Aggregate Functions
How many employees are there in each department?

-- solution --
SELECT pa.department_name, sum(sal.dept_id)
FROM parks_and_recreation.employee_salary sal
JOIN parks_and_recreation.parks_departments pa
	ON pa.department_id = sal.dept_id
group by pa.department_name

What is the average salary per department?

--solution--
SELECT par.department_name, avg(sal.salary) AS avg_salary
FROM parks_and_recreation.employee_salary sal
JOIN parks_and_recreation.parks_departments par
	ON sal.dept_id = par.department_id
GROUP BY par.department_id

📝 Exercises for Practice
Try writing and running these queries:

1. Find the total number of male and female employees.
Hint: Use GROUP BY gender on employee_demographics.

--solution--

SELECT gender, COUNT(*) AS TOTAL_number_of_employees
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;

2. List each occupation and the number of employees in each.
Hint: Use GROUP BY occupation on employee_salary.

--solution--
SELECT occupation, count(*) Number_of_employees
FROM parks_and_recreation.employee_salary
GROUP BY occupation
;

3. Find the highest and lowest age among employees.

--solution--
SELECT min(age) AS youngest, max(age) AS oldest
FROM parks_and_recreation.employee_demographics
;

4. Show the total salary paid to each department.
Hint: Use SUM(salary) and join with parks_departments.

--solution--
SELECT pa.department_name, SUM(sa.salary) AS TOTAL_SALARY
FROM parks_and_recreation.parks_departments pa
LEFT JOIN parks_and_recreation.employee_salary sa
	ON pa.department_id = sa.dept_id
GROUP BY pa.department_name
;

5. Which department has the highest average salary?
Hint: Use ORDER BY avg_salary DESC and LIMIT 1.

-- solution--
SELECT pa.department_name, avg(sa.salary) as avg_salary
FROM parks_and_recreation.parks_departments pa
JOIN parks_and_recreation.employee_salary sa
	ON pa.department_id = sa.dept_id
GROUP BY pa.department_name
ORDER BY avg_salary DESC
LIMIT 1
;

🏆 Advanced Aggregate Function Exercises
1. Find the department with the highest total salary payout.
Hint: Use SUM(salary), join with parks_departments, group by department, and use ORDER BY and LIMIT.

-- SOLUTION
SELECT 
    SUM(sa.salary),
    par.department_name
FROM parks_and_recreation.employee_salary sa
JOIN parks_and_recreation.parks_departments par
	ON par.department_id = sa.dept_id
GROUP BY par.department_name
ORDER BY SUM(salary) DESC
LIMIT 1
;

2. List each occupation and the average salary for that occupation, but only show occupations where the average salary is above 50,000.
Hint: Use GROUP BY occupation and HAVING AVG(salary) > 50000.

-- solution --
SELECT 
	occupation,
    avg(salary)
FROM parks_and_recreation.employee_salary sa
JOIN parks_and_recreation.parks_departments par
	ON sa.dept_id = par.department_id
GROUP BY occupation
HAVING avg(salary) > 50000
;

3. For each department, show the number of employees, the average salary, and the minimum salary.
Hint: Join employee_salary with parks_departments, group by department.

-- solution --
SELECT
	par.department_name,
    SUM(sa.employee_id) AS No_of_employees,
    avg(sa.salary) AS avg_salary,
    MIN(sa.salary) AS Minimum_salary
FROM parks_and_recreation.employee_salary sa
JOIN parks_and_recreation.parks_departments par
	ON sa.dept_id = par.department_id
GROUP BY par.department_name
;

4. Find the gender with the highest average salary.
Hint: Join employee_salary with employee_demographics on employee_id, group by gender, and order by average salary.

-- solution --

SELECT 
	de.gender,
    avg(sa.salary)
FROM parks_and_recreation.employee_demographics de
JOIN parks_and_recreation.employee_salary sa
	ON de.employee_id = sa.employee_id
GROUP BY de.gender
ORDER BY avg(sa.salary) DESC
LIMIT 1
;

5. Show the top 3 highest-paid employees, including their name, occupation, salary, and department name.
Hint: Join employee_salary with parks_departments, order by salary descending, and limit to 3.

-- solution --
SELECT 
	sa.first_name,
    sa.last_name,
    sa.occupation,
    sa.salary,
    par.department_name
FROM parks_and_recreation.employee_salary sa
JOIN parks_and_recreation.parks_departments par
	ON sa.dept_id = par.department_id
ORDER BY sa.salary DESC
LIMIT 3
;

6. For each department, show the percentage of employees who are female.
Hint: Use a subquery or conditional aggregation with COUNT(CASE WHEN gender = 'Female' THEN 1 END).

-- solution --
SELECT 
	sa.dept_id,
    ROUND(
        100.0 * SUM(CASE WHEN de.gender = 'Female' THEN 1 ELSE 0 END) / COUNT(*), 
        2
    ) AS percent_female
FROM parks_and_recreation.employee_demographics de
JOIN parks_and_recreation.employee_salary sa
	ON de.employee_id = sa.employee_id
GROUP BY sa.dept_id
;

7. Find the average age of employees for each occupation, but only include occupations with more than one employee.
Hint: Join employee_salary and employee_demographics, group by occupation, and use HAVING COUNT(*) > 1.

-- solution --
SELECT 
	sa.occupation,
    avg(de.age)
FROM parks_and_recreation.employee_demographics de
JOIN parks_and_recreation.employee_salary sa
	ON de.employee_id = sa.employee_id
GROUP BY occupation
HAVING avg(age) > 1
;

8. Which department has the widest salary range (difference between max and min salary)?
Hint: Use MAX(salary) - MIN(salary) as a calculated column, group by department, order by this value descending, and limit to 1.
*/
-- solution --

SELECT
	par.department_name,
    MAX(sal.salary) - MIN(sal.salary) AS Widest_salary_range	
FROM parks_and_recreation.parks_departments par
JOIN parks_and_recreation.employee_salary sal
	ON par.department_id = sal.dept_id
GROUP BY par.department_name
ORDER BY MAX(sal.salary) - MIN(sal.salary) DESC
LIMIT 1
;


