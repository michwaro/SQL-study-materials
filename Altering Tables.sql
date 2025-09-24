/*
Altering tables
As your data changes over time, SQL provides a way for you to update your corresponding tables and database schemas by using the 
ALTER TABLE statement to add, remove, or modify columns and table constraints.

Adding columns
The syntax for adding a new column is similar to the syntax when creating new rows in the CREATE TABLE statement. You need to 
specify the data type of the column along with any potential table constraints and default values to be applied to both existing 
and new rows. In some databases like MySQL, you can even specify where to insert the new column using the FIRST or AFTER clauses, 
though this is not a standard feature.

Altering table to add new column(s)
ALTER TABLE mytable
ADD column DataType OptionalTableConstraint 
    DEFAULT default_value;
Removing columns
Dropping columns is as easy as specifying the column to drop, however, some databases (including SQLite) don't support this feature. 
Instead you may have to create a new table and migrate the data over.

Altering table to remove column(s)
ALTER TABLE mytable
DROP column_to_be_deleted;
Renaming the table
If you need to rename the table itself, you can also do that using the RENAME TO clause of the statement.

Altering table name
ALTER TABLE mytable
RENAME TO new_table_name;
Other changes
Each database implementation supports different methods of altering their tables, so it's always best to consult your database 
docs before proceeding.

1. Adding a Column
Suppose you want to add an email address to the employee_demographics table:

SQL
ALTER TABLE employee_demographics
ADD COLUMN email VARCHAR(100);

2. Dropping (Removing) a Column
If you decide you no longer need the age column:

SQL
ALTER TABLE employee_demographics
DROP COLUMN age;

3. Modifying a Column’s Data Type
Let’s say you want to allow longer department names in parks_departments:

SQL
ALTER TABLE parks_departments
MODIFY COLUMN department_name VARCHAR(100);

4. Renaming a Column
If you want to rename dept_id in employee_salary to department_id:

SQL
ALTER TABLE employee_salary
CHANGE COLUMN dept_id department_id INT;

5. Renaming a Table
To rename employee_salary to salaries:

SQL
RENAME TABLE employee_salary TO salaries;

6. Adding a Constraint
Suppose you want to ensure that salaries are always positive:

SQL
ALTER TABLE employee_salary
ADD CONSTRAINT chk_salary_positive CHECK (salary > 0);

7. Adding a Foreign Key
To link employee_salary.dept_id to parks_departments.department_id:

SQL
ALTER TABLE employee_salary
ADD CONSTRAINT fk_dept
FOREIGN KEY (dept_id) REFERENCES parks_departments(department_id);

Summary Table
Action			- Example SQL Statement
Add column		- ALTER TABLE table_name ADD COLUMN col_name datatype;
Drop column		- ALTER TABLE table_name DROP COLUMN col_name;
Modify column	- ALTER TABLE table_name MODIFY COLUMN col_name new_datatype;
Rename column	- ALTER TABLE table_name CHANGE COLUMN old_name new_name datatype;
Rename table	- RENAME TABLE old_table TO new_table;
Add constraint	- ALTER TABLE table_name ADD CONSTRAINT ...;
Add foreign key	- ALTER TABLE table_name ADD CONSTRAINT ... FOREIGN KEY ... REFERENCES ...;


1. Add a New Column
Suppose you want to add a phone_number column to the employee_demographics table:

SQL
ALTER TABLE employee_demographics
ADD COLUMN phone_number VARCHAR(20);

2. Remove a Column
If you want to remove the birth_date column from employee_demographics:

SQL
ALTER TABLE employee_demographics
DROP COLUMN birth_date;

3. Change a Column’s Data Type
Let’s say you want to allow for larger salaries in employee_salary:

SQL
ALTER TABLE employee_salary
MODIFY COLUMN salary BIGINT;

4. Add a Foreign Key
To ensure that dept_id in employee_salary always matches a valid department in parks_departments:

SQL
ALTER TABLE employee_salary
ADD CONSTRAINT fk_dept_id
FOREIGN KEY (dept_id) REFERENCES parks_departments(department_id);

5. Rename a Table
If you want to rename parks_departments to departments:

SQL
RENAME TABLE parks_departments TO departments;

