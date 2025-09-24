/*
🧮 What Are Expressions in SQL?

An expression is a combination of one or more values, operators, and SQL functions that evaluate to a value.
You can use expressions in the SELECT list, WHERE, ORDER BY, and even in GROUP BY or HAVING.

In addition to querying and referencing raw column data with SQL, you can also use expressions to write more complex logic on column 
values in a query. These expressions can use mathematical and string functions along with basic arithmetic to transform values when 
the query is executed, as shown in this physics example.

Example query with expressions
SELECT particle_speed / 2.0 AS half_particle_speed
FROM physics_data
WHERE ABS(particle_position) * 10.0 > 500;

Each database has its own supported set of mathematical, string, and date functions that can be used in a query, which you can find 
in their own respective docs.

The use of expressions can save time and extra post-processing of the result data, but can also make the query harder to read, so we 
recommend that when expressions are used in the SELECT part of the query, that they are also given a descriptive alias using the AS 
keyword.

Select query with expression aliases

SELECT col_expression AS expr_description, …
FROM mytable;

In addition to expressions, regular columns and even tables can also have aliases to make them easier to reference in the output and 
as a part of simplifying more complex queries.

Example query with both column and table name aliases

SELECT column AS better_column_name, …
FROM a_long_widgets_table_name AS mywidgets
INNER JOIN widget_sales
  ON mywidgets.id = widget_sales.widget_id;


🔢 Types of Expressions

1. Arithmetic Expressions
You can add, subtract, multiply, or divide numeric columns.

Example:
Show each employee’s salary and what their salary would be after a 10% raise.

-- solution --

SELECT 
	sa.first_name,
    sa.last_name,
    sa.salary,
    sa.salary * 1.10 AS salary_after_raise
FROM parks_and_recreation.employee_salary sa
;

2. String Expressions
You can concatenate (join) strings.

Example:
Show each employee’s full name in one column.

-- solution --

SELECT
	concat( first_name, ' ', last_name) AS full_name
FROM parks_and_recreation.employee_demographics
;

-- Also use first_name || ' ' || last_name in other SQL

3. Date Expressions
You can calculate age, years of service, etc.

Example:
Show each employee’s birth year.

-- solution --

SELECT 
	first_name,
    last_name,
    year(birth_date) AS Birth_year
FROM parks_and_recreation.employee_demographics
;

4. Conditional Expressions (CASE)
You can create new columns based on conditions.

Example:
Label employees as ‘Senior’ if age ≥ 40, otherwise ‘Junior’.

-- solution --

SELECT
	first_name,
    last_name,
    age,
    CASE
		WHEN age >= 40 THEN 'senior'
        ELSE 'junior'
	END AS employee_level
FROM parks_and_recreation.employee_demographics
;

📝 Practice Exercises
Try writing queries for these:

1. Show each employee’s name and their salary after deducting 5,000 as tax.

-- solution --

SELECT 
	first_name,
    last_name,
    salary - 5000 AS salary_after_tax
FROM parks_and_recreation.employee_salary


2. List all employees and show a column that says ‘High’ if their salary is above 60,000, otherwise ‘Low’.

-- solution --

SELECT 
	first_name,
    last_name,
    salary,
    CASE WHEN salary > 60000 THEN 'High'
		ELSE 'Low'
	END AS salary_level
FROM parks_and_recreation.employee_salary
;

3. Display each employee’s age in 5 years.

-- Solution --

SELECT 
	first_name,
    last_name,
    age,
    year(birth_date) + 5 AS Age_in_5_years
FROM parks_and_recreation.employee_demographics
;

4. Show each department and the average salary, rounded to the nearest thousand.

-- solution --

SELECT 
	pa.department_name,
    ROUND(avg(sa.salary), -3) AS avg_salary_to_thousand
FROM parks_and_recreation.employee_salary sa
JOIN parks_and_recreation.parks_departments pa
	ON sa.dept_id = pa.department_id
GROUP BY pa.department_name
;
/*
5. Show each employee’s full name and the length of their full name.

-- incomplete solution --

SELECT 
	concat(first_name, ' ', last_name) AS full_name,
    length(concat(first_name, ' ', last_name)) AS name_length
FROM parks_and_recreation.employee_demographics
;

/*
🏆 Advanced SQL Expression Exercises
1. Show each employee’s name, salary, and what their salary would be after a 15% bonus, rounded to the nearest whole number.

-- solution --

SELECT 
	first_name,
    last_name,
    salary,
    ROUND(salary * 1.15) AS Final_salary	
FROM parks_and_recreation.employee_salary
;

2. Display each employee’s full name and a column showing the number of characters in their full name.

-- solution --

SELECT 
	concat(first_name, ' ',last_name) AS full_name,
    length(concat(first_name, ' ',last_name)) AS name_length
FROM parks_and_recreation.employee_demographics
;

🏆 Advanced Variation
Show each employee’s full name and a column that says:

'Short Name' if the length is ≤ 12 characters
'Medium Name' if between 13 and 20
'Long Name' if > 20 characters

-- solution --

SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
    LENGTH(CONCAT(first_name, ' ', last_name)) AS name_length,

    CASE 
		WHEN LENGTH(CONCAT(first_name, ' ', last_name)) <= 12 THEN 'Short Name'
        WHEN LENGTH(CONCAT(first_name, ' ', last_name)) <= 20 THEN 'Medium Name'
        ELSE 'Long Name'
	END AS name_category
FROM  parks_and_recreation.employee_demographics
;

3. List all employees and show a column that says ‘Eligible for Promotion’ if their age is above 40 and salary is 
above 60,000, otherwise ‘Not Eligible’.

-- solution --

SELECT 
	sa.first_name,
    sa.last_name,
    CASE
		WHEN sa.salary > 60000 AND de.age > 40 THEN 'Eligible for Promotion'
        ELSE 'Not Eligible'
        END AS Eligible_for_promotion
FROM parks_and_recreation.employee_salary sa
JOIN parks_and_recreation.employee_demographics de
	ON de.employee_id = sa.employee_id
;

4. For each department, show the department name and the difference between the highest and lowest salary in that department.

SELECT 
	pa.department_name,
    max(sa.salary)-min(sa.salary)
FROM parks_and_recreation.parks_departments pa
JOIN parks_and_recreation.employee_salary sa
	ON pa.department_id = sa.dept_id
group by pa.department_name
;

🏆 Advanced Variation
Show only departments where the salary range is greater than 20,000:

SQL
SELECT 
    pa.department_name,
    MAX(sa.salary) - MIN(sa.salary) AS salary_range
FROM parks_and_recreation.parks_departments pa
JOIN parks_and_recreation.employee_salary sa
    ON pa.department_id = sa.dept_id
GROUP BY pa.department_name
HAVING salary_range > 20000;

5. Show each employee’s name, salary, and the percentage their salary contributes to the total salary of all employees.

-- solution --
SELECT
	sa.first_name,
    sa.last_name,
    sa.salary,
    ROUND(sa.salary / (SELECT SUM(salary) FROM parks_and_recreation.employee_salary) * 100, 2) AS Percentage_salary_contribution
FROM parks_and_recreation.employee_salary sa
;

6. Display each employee’s name and a column that shows their birth month as a string (e.g., ‘March’).

-- solution -- 

SELECT
	de.first_name,
    de.last_name,
    monthname(de.birth_date) AS birth_month
FROM parks_and_recreation.employee_demographics de
;

🏆 Advanced Variation
Show each employee’s name, birth month, and a label:

'Q1' if born in Jan–Mar
'Q2' if born in Apr–Jun
'Q3' if born in Jul–Sep
'Q4' if born in Oct–Dec

SQL
SELECT
    de.first_name,
    de.last_name,
    MONTHNAME(de.birth_date) AS birth_month,
    CASE
        WHEN MONTH(de.birth_date) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(de.birth_date) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(de.birth_date) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS birth_quarter
FROM parks_and_recreation.employee_demographics de;

7. Show each occupation and the average age of employees in that occupation, rounded to one decimal place.

-- solution --

SELECT 
	sa.occupation,
    round(avg(de.age), 1)
FROM parks_and_recreation.employee_salary sa
JOIN parks_and_recreation.employee_demographics de
	ON de.employee_id = sa.employee_id
GROUP BY sa.occupation
;

8. List all employees and show a column that says ‘Veteran’ if their age is at least 50, otherwise ‘Non-Veteran’.

-- solution --

SELECT
	first_name,
    last_name,
    CASE
		WHEN age >= 50 THEN 'Veteran'
        ELSE 'Non-Veteran'
        END AS Veteran
FROM parks_and_recreation.employee_demographics
;
*/