/*
🧠 What is the CASE Statement?
The CASE statement evaluates conditions and returns a value when the first condition is met.
It can be used in SELECT, ORDER BY, GROUP BY, and even in WHERE (in some databases).
📝 Syntax

SQL
SELECT
    column1,
    CASE
        WHEN condition1 THEN result1
        WHEN condition2 THEN result2
        ELSE default_result
    END AS new_column
FROM table_name;

📘 Examples Using Your Database
1. Label Employees as ‘Senior’ or ‘Junior’ Based on Age



SQL
SELECT
    first_name,
    last_name,
    age,
    CASE
        WHEN age >= 40 THEN 'Senior'
        ELSE 'Junior'
    END AS employee_level
FROM parks_and_recreation.employee_demographics;

2. Show Salary Category

SQL
SELECT
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary >= 70000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM parks_and_recreation.employee_salary;

3. Combine Gender and Age for Custom Label

SQL
SELECT
    first_name,
    last_name,
    gender,
    age,
    CASE
        WHEN gender = 'Female' AND age < 40 THEN 'Young Female'
        WHEN gender = 'Female' AND age >= 40 THEN 'Senior Female'
        WHEN gender = 'Male' AND age < 40 THEN 'Young Male'
        ELSE 'Senior Male'
    END AS demographic_group
FROM parks_and_recreation.employee_demographics;

🧪 Practice Exercises
1. Show each employee’s name and a column that says ‘Eligible for Promotion’ if their age is above 40 and salary is above 60,000, otherwise ‘Not Eligible’.
2. List all employees and show a column that says ‘Veteran’ if their age is at least 50, otherwise ‘Non-Veteran’.
3. Display each employee’s salary and a column that says ‘Even’ if the salary is an even number, otherwise ‘Odd’.
4. Show each department and a column that says ‘Large’ if it has more than 2 employees, otherwise ‘Small’.

🧪 Practice Exercises (Basic to Intermediate)
1. Label employees as ‘Senior’ if age ≥ 40, otherwise ‘Junior’.
Use employee_demographics.
2. Show each employee’s salary and a column that says ‘High’ if salary ≥ 60,000, otherwise ‘Low’.
Use employee_salary.
3. Display each employee’s full name and a column that says ‘Even’ if their age is even, otherwise ‘Odd’.
Use MOD(age, 2) to check even/odd.
4. Show each employee’s name and a column that says ‘Eligible’ if age ≥ 35 and salary ≥ 50,000, otherwise ‘Not Eligible’.
Join employee_demographics and employee_salary.
🏆 Advanced CASE Statement Exercises
1. Create a performance tier for employees based on salary:
>= 70,000 → ‘Top Performer’
50,000–69,999 → ‘Mid Performer’
< 50,000 → ‘Needs Improvement’
2. Show each department and a column that says:
‘Well Paid’ if average salary ≥ 60,000
‘Moderate’ if between 40,000 and 59,999
‘Underpaid’ if < 40,000
Use AVG(salary) and GROUP BY with CASE.
3. List employees and show a column that says:
‘Young Female’ if gender = Female and age < 35
‘Senior Male’ if gender = Male and age ≥ 45
‘Other’ for all other combinations
4. Show each employee’s name and a column that says:
‘Complete Info’ if both dept_id and salary are not null
‘Missing Department’ if dept_id is null
‘Missing Salary’ if salary is null
5. Create a custom label for each employee based on age and salary:
If age ≥ 50 and salary ≥ 60,000 → ‘Veteran High Earner’
If age < 30 and salary < 40,000 → ‘Young Starter’
Else → ‘Standard’
