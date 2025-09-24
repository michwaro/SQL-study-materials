/*
🧠 What is the HAVING Clause?
The HAVING clause is used to filter groups created by the GROUP BY clause — similar to how WHERE filters individual rows.

WHERE filters before grouping.
HAVING filters after grouping.


-- ✅ Syntax --

SELECT column, AGGREGATE_FUNCTION(column)
FROM table
WHERE condition
	AND/OR contition...
GROUP BY column
HAVING condition;
*/

/*
📘 Examples Using Your Database

Example 1 : Show occupations with more than one employee

SELECT occupation, count(*) AS num_employees
FROM employee_salary 
group by occupation 
having count(*) > 1;
*/

/* Example 2 : Departments with average salary above 60000
SELECT d.department_name, avg(e.salary) AS avg_salary
FROM employee_salary e
JOIN parks_departments d
	ON d.department_id = e.dept_id
GROUP BY d.department_name
Having  avg(e.salary) > 60000
    ;
*/
/*
 Example 3. Genders with average age below 40
SELECT ed.gender, avg(ed.age) AS avg_age
FROM employee_demographics ed
group by ed.gender
having avg(age) < 40;
*/

-- Practice Exercises
/*
1. List occupations where the total salary is more than 100,000.

SELECT occupation, sum(salary) AS total_salary
FROM parks_and_recreation.employee_salary
GROUP BY  occupation
HAVING sum(salary) > 100000
;

2. Find departments that have more than 2 employees.

SELECT department_name, sum(department_id) AS More_than_2_employees
FROM parks_and_recreation.parks_departments
GROUP BY department_name
HAVING sum(department_id) > 2;

/*3. Show each gender and the number of employees, but only include genders with more than 3 employees.

SELECT gender, sum(employee_id)
FROM parks_and_recreation.employee_demographics
group by gender
-- HAVING sum(employee_id) > 3;

4. Find occupations where the average salary is between 50,000 and 70,000.

SELECT occupation, avg(salary) AS Avg_salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation
HAVING avg(salary) between 50000 AND 70000;

5. Which department has the highest average salary?
	Hint: Use ORDER BY and LIMIT 1 after HAVING.
 
 SELECT par.department_name, avg(sal.salary) AS Avg_salary
 FROM parks_and_recreation.employee_salary sal
 JOIN parks_and_recreation.parks_departments par
	ON par.department_id = sal.dept_id
GROUP BY par.department_name
HAVING avg(sal.salary)
ORDER BY avg(sal.salary) DESC
LIMIT 1
;

6. Find occupations where the average salary is above the overall average salary of all employees.
Hint: Use a subquery to calculate the overall average salary.

-- solution --
SELECT 
	sa.occupation,
    avg(sa.salary)
FROM parks_and_recreation.employee_salary sa
GROUP BY sa.occupation
HAVING avg(sa.salary) > (
	SELECT 
		avg(sb.salary)
	FROM parks_and_recreation.employee_salary sb
);

7. List departments where the number of employees is more than the average number of employees per department.
Hint: Use GROUP BY, COUNT(), and a subquery.

-- My incorrect solution --
SELECT 
	paa.department_name,
	saa.employee_id
FROM parks_and_recreation.parks_departments paa
JOIN parks_and_recreation.employee_salary saa
	ON paa.department_id = saa.dept_id
GROUP BY paa.department_name
HAVING saa.employee_id > (
	SELECT 
		pa.department_name,
		avg(sa.employee_id)
	FROM parks_and_recreation.parks_departments pa
    JOIN parks_and_recreation.employee_salary sa
		ON pa.department_id = sa.dept_id
);

-- Correct solution --

SELECT 
    sa.dept_id,
    COUNT(*) AS employee_count
FROM parks_and_recreation.employee_salary sa
WHERE sa.dept_id IS NOT NULL
GROUP BY sa.dept_id
HAVING COUNT(*) > (
    SELECT AVG(dept_count)
    FROM (
        SELECT COUNT(*) AS dept_count
        FROM parks_and_recreation.employee_salary
        WHERE dept_id IS NOT NULL
        GROUP BY dept_id
    ) AS dept_counts
);

8. Show each gender and the average salary, but only include genders where the average salary is above 60,000.
Hint: Join employee_salary and employee_demographics, group by gender, and use HAVING.

9. Find occupations where the total salary is more than 100,000 and the number of employees is more than 1.
Hint: Use multiple conditions in the HAVING clause.

10. Find departments where the salary range (MAX - MIN) is greater than 20,000.
Hint: Use MAX(salary) - MIN(salary) in the HAVING clause.

11. Show the top 2 departments with the highest average salary, but only include departments with more than 2 employees.
Hint: Use HAVING COUNT(*) > 2, ORDER BY AVG(salary) DESC, and LIMIT 2.

12. Find occupations where the average age of employees is below 40 and the total salary is above 50,000.
Hint: Join employee_salary and employee_demographics, group by occupation, and use multiple conditions in HAVING.

*/

-- Solutions --
