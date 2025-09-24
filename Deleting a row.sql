/*

Deleting rows
When you need to delete data from a table in the database, you can use a DELETE statement, which describes the table 
to act on, and the rows of the table to delete through the WHERE clause.

Delete statement with condition
DELETE FROM mytable
WHERE condition;
If you decide to leave out the WHERE constraint, then all rows are removed, which is a quick and easy way to clear out 
a table completely (if intentional).

Taking extra care
Like the UPDATE statement from last lesson, it's recommended that you run the constraint in a SELECT query first to 
ensure that you are removing the right rows. Without a proper backup or test database, it is downright easy to irrevocably 
remove data, so always read your DELETE statements twice and execute once.

🔥 Basic Syntax of DELETE

DELETE FROM table_name
WHERE condition;

⚠️ Always include a WHERE clause unless you want to delete all rows from the table.

1. Deleting from employee_demographics
Example:
Delete the employee with ID 13:

DELETE FROM parks_and_recreation.employee_demographics
WHERE employee_id = 13;

2. Deleting from employee_salary
Example:
Delete salary info for someone named "Mona Lisa":

DELETE FROM parks_and_recreation.employee_salary
WHERE employee_id = 13;

3. Deleting from parks_departments
Example:
Delete a department by name:

DELETE FROM parks_and_recreation.parks_departments
WHERE department_id = 7;

⚠️ Deleting All Rows (Use with Caution)
If you want to clear a table completely:

DELETE FROM employee_salary;

This removes all rows but keeps the table structure.

✅ Best Practices
Always back up your data before running delete operations.
Use SELECT first to preview what will be deleted:

SELECT * FROM employee_salary WHERE salary < 30000;

Then run:

DELETE FROM employee_salary WHERE salary < 30000;

Practice Scenarios
1. Delete All Employees Over a Certain Age
Delete all employees older than 60 from employee_demographics:

SQL
DELETE FROM employee_demographics
WHERE age > 60;

2. Delete Salary Records for Employees Without a Department
Remove salary records where dept_id is NULL:

SQL
DELETE FROM employee_salary
WHERE dept_id IS NULL;

3. Delete a Department by ID
Remove the department with department_id 3:

SQL
DELETE FROM parks_departments
WHERE department_id = 3;

Using DELETE with JOIN
Sometimes you want to delete rows from one table based on related data in another table. This is common when you have related tables (like employee_demographics and employee_salary).

Example 1: Delete Employees Who Have No Salary Record
Suppose you want to remove employees from employee_demographics who do not have a matching record in employee_salary:

SQL
DELETE ed
FROM employee_demographics ed
LEFT JOIN employee_salary es
  ON ed.employee_id = es.employee_id
WHERE es.employee_id IS NULL;

This deletes employees who are not found in the salary table.
Example 2: Delete Salary Records for Employees Who Have Left
Suppose you want to delete salary records for employees who are no longer in employee_demographics:

SQL
DELETE es
FROM employee_salary es
LEFT JOIN employee_demographics ed
  ON es.employee_id = ed.employee_id
WHERE ed.employee_id IS NULL;

This deletes salary records for employees who don’t exist in the demographics table.
Example 3: Delete All Employees in a Certain Department
Suppose you want to delete all employees in the employee_demographics table who belong to the "Healthcare" department (assuming you can join via dept_id):

SQL
DELETE ed
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id
JOIN parks_departments pd ON es.dept_id = pd.department_id
WHERE pd.department_name = 'Healthcare';

This deletes employees whose department is "Healthcare".
Practice Problems

Try writing the SQL for these scenarios:

1. Delete all employees named "Jerry" from employee_demographics.

2. Delete all salary records for employees with a salary less than 25,000.

3. Delete all departments whose name contains the word "Control".

4. Delete all employees who are not assigned to any department (i.e., their dept_id is NULL in employee_salary).

5. Delete all salary records for employees whose age is below 30 (requires a JOIN).


1. How to Use TRUNCATE
The TRUNCATE statement is used to remove all rows from a table, quickly and efficiently.

Syntax:

SQL
TRUNCATE TABLE table_name;

Example:

SQL
TRUNCATE TABLE employee_salary;

This will remove all rows from the employee_salary table, but the table structure (columns, indexes, etc.) remains.

3. When to Use Each
DELETE:

When you want to remove specific rows (using WHERE).
When you need to activate triggers or maintain referential integrity.
When you want to delete all rows but keep the auto-increment value.
TRUNCATE:

When you want to quickly remove all rows from a table.
When you don’t need to activate triggers or worry about row-by-row deletions.
When you want to reset the auto-increment counter.
4. Examples
Delete all employees named 'Jerry':

SQL
DELETE FROM employee_demographics WHERE first_name = 'Jerry';

Delete all rows from a table:

SQL
DELETE FROM parks_departments;

Truncate a table (remove all rows, reset auto-increment):

SQL
TRUNCATE TABLE parks_departments;

⚠️ Caution
TRUNCATE is much faster but cannot be used to delete specific rows.
Both DELETE (without WHERE) and TRUNCATE will remove all data, but TRUNCATE is less flexible and may not be reversible in all database systems.
