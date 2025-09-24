/*
🧠 1. What Are Subqueries?
A subquery is a query nested inside another SQL query. It can be used in:

SELECT clause
FROM clause
WHERE or HAVING clause

Subqueries help answer complex questions without needing multiple separate queries.

🟢 2. Basic Subqueries
🔹 Example: Find employees earning more than the average salary

-- solution --

SELECT first_name, last_name, salary
FROM parks_and_recreation.employee_salary
WHERE salary > (
	SELECT avg(salary)
    FROM parks_and_recreation.employee_salary
    );

🧪 Practice Exercise (Basic)
Q1: List employees whose salary is less than the maximum salary.

-- solution --

SELECT first_name, last_name, salary
FROM parks_and_recreation.employee_salary
WHERE salary < (
	SELECT MAX(salary)
	FROM parks_and_recreation.employee_salary);

🟡 3. Intermediate Subqueries

🔹 Subquery in the FROM clause
Find average salary per department using a subquery:

--solution --
SELECT dept_id, avg_salary
FROM (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM parks_and_recreation.employee_salary
    GROUP BY dept_id
) AS dept_avg;


🧪 Practice Exercise (Intermediate)
Q2: List departments where the average salary is greater than $60,000.

-- solution --
SELECT pa.department_name, avg(sa.salary) AS Avg_salary
FROM parks_and_recreation.parks_departments pa
JOIN parks_and_recreation.employee_salary sa
	ON pa.department_id = sa.dept_id
GROUP BY pa.department_name
HAVING avg(sa.salary) > 60000;

🔴 4. Advanced Subqueries
🔹 Correlated Subquery

Find employees earning more than the average salary in their department:

-- solution --

SELECT 
	first_name,
    last_name,
    salary
    dept_id
FROM parks_and_recreation.employee_salary a
WHERE salary > (
	SELECT avg(salary)
    FROM parks_and_recreation.employee_salary b
    WHERE a.dept_id = b.dept_id
);

This subquery is correlated because it depends on the outer query's dept_id.

🧪 Practice Exercise (Advanced)
Q3: List employees whose salary is above the average salary of their department and who are older than 40 (use employee_demographics).

Hint: You’ll need a JOIN and a correlated subquery.

-- solution --

SELECT 
	sa.first_name,
    sa.last_name,
    sa.salary,
    sa.dept_id
FROM parks_and_recreation.employee_salary sa
JOIN parks_and_recreation.employee_demographics de
	ON sa.employee_id = de.employee_id
WHERE salary > (
	SELECT avg(salary)
    FROM parks_and_recreation.employee_salary sb
    WHERE sa.dept_id = sb.dept_id
);

🧭 5. Subqueries with IN / NOT IN
🔹 Example: Find employees who work in departments listed in parks_departments

-- solution --
SELECT 
	first_name,
    last_name,
    dept_id
FROM parks_and_recreation.employee_salary
WHERE dept_id IN (
	SELECT department_id
    FROM parks_and_recreation.parks_departments
);

🧪 Practice Exercise
Q4: Find employees who do not belong to any department listed in parks_departments.

-- solution --

SELECT 
	first_name,
    last_name,
    dept_id
FROM parks_and_recreation.employee_salary
WHERE dept_id NOT IN (
	SELECT department_id
    FROM parks_and_recreation.parks_departments
);


TO PRACTICE MORE

🧰 Bonus: Combining Subqueries with JOINs
You can also use subqueries inside JOINs to enrich your data.

🔹 Example: Join employee salary with department names

SQL
SELECT e.first_name, e.last_name, e.salary, d.department_name
FROM employee_salary AS e
JOIN parks_departments AS d
ON e.dept_id = d.department_id;


🟢 Basic Subquery Exercises
Employees earning more than the average salary

SQL
SELECT first_name, last_name, salary
FROM employee_salary
WHERE salary > (
    SELECT AVG(salary)
    FROM employee_salary
);

Employees younger than the average age

SQL
SELECT first_name, last_name, age
FROM employee_demographics
WHERE age < (
    SELECT AVG(age)
    FROM employee_demographics
);

Employees born before the oldest employee

SQL
SELECT first_name, last_name, birth_date
FROM employee_demographics
WHERE birth_date < (
    SELECT MIN(birth_date)
    FROM employee_demographics
);

Employees whose salary is equal to the minimum salary

SQL
SELECT first_name, last_name, salary
FROM employee_salary
WHERE salary = (
    SELECT MIN(salary)
    FROM employee_salary
);

Employees in departments listed in parks_departments

SQL
SELECT first_name, last_name, dept_id
FROM employee_salary
WHERE dept_id IN (
    SELECT department_id
    FROM parks_departments
);

🟡 Intermediate Subquery Exercises
Departments with average salary above $60,000

SQL
SELECT dept_id, avg_salary
FROM (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employee_salary
    GROUP BY dept_id
) AS dept_avg
WHERE avg_salary > 60000;

Employees not in any department listed in parks_departments

SQL
SELECT first_name, last_name, dept_id
FROM employee_salary
WHERE dept_id NOT IN (
    SELECT department_id
    FROM parks_departments
);

Employees whose department has more than 2 members

SQL
SELECT first_name, last_name, dept_id
FROM employee_salary
WHERE dept_id IN (
    SELECT dept_id
    FROM employee_salary
    GROUP BY dept_id
    HAVING COUNT(*) > 2
);

Employees whose salary is in the top 3 salaries

SQL
SELECT first_name, last_name, salary
FROM employee_salary
WHERE salary IN (
    SELECT salary
    FROM employee_salary
    ORDER BY salary DESC
    LIMIT 3
);

(Note: Some SQL engines don't allow LIMIT in subqueries. Use ROW_NUMBER() or TOP in such cases.)

Employees whose age is greater than the average age of employees in their department (Requires JOIN and subquery in FROM clause)

🔴 Advanced Subquery Exercises
Correlated Subquery: Employees earning more than department average

SQL
   SELECT first_name, last_name, salary, dept_id
   FROM employee_salary AS e
   WHERE salary > (
       SELECT AVG(salary)
       FROM employee_salary AS d
       WHERE d.dept_id = e.dept_id
   );
   
Correlated Subquery: Employees older than average age in their department (Requires joining demographics and salary)

Employees whose salary is above department average and age is above 40

SQL
   SELECT e.first_name, e.last_name, e.salary, d.age
   FROM employee_salary AS e
   JOIN employee_demographics AS d ON e.employee_id = d.employee_id
   WHERE e.salary > (
       SELECT AVG(salary)
       FROM employee_salary AS s
       WHERE s.dept_id = e.dept_id
   )
   AND d.age > 40;
   
Departments with total salary budget above $150,000



SQL
   SELECT dept_id
   FROM (
       SELECT dept_id, SUM(salary) AS total_salary
       FROM employee_salary
       GROUP BY dept_id
   ) AS dept_salaries
   WHERE total_salary > 150000;
   
Employees whose salary is higher than any Office Manager



SQL
   SELECT first_name, last_name, salary
   FROM employee_salary
   WHERE salary > ANY (
       SELECT salary
       FROM employee_salary
       WHERE occupation = 'Office Manager'
   );
   
Employees whose salary is higher than all Nurses



SQL
   SELECT first_name, last_name, salary
   FROM employee_salary
   WHERE salary > ALL (
       SELECT salary
       FROM employee_salary
       WHERE occupation = 'Nurse'
   );
   
Employees whose department has a Parks Director



SQL
   SELECT first_name, last_name, dept_id
   FROM employee_salary
   WHERE dept_id IN (
       SELECT dept_id
       FROM employee_salary
       WHERE occupation = 'Parks Director'
   );
   ```
Employees whose department does not have a City Manager



SQL
   SELECT first_name, last_name, dept_id
   FROM employee_salary
   WHERE dept_id NOT IN (
       SELECT dept_id
       FROM employee_salary
       WHERE occupation = 'City Manager'
   );
   
*/
