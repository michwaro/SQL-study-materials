/*
1. INSERTING Rows

Inserting rows
We've spent quite a few lessons on how to query for data in a database, so it's time to start learning a bit about 
SQL schemas and how to add new data.

What is a Schema?
We previously described a table in a database as a two-dimensional set of rows and columns, with the columns being 
the properties and the rows being instances of the entity in the table. In SQL, the database schema is what describes 
the structure of each table, and the datatypes that each column of the table can contain.

Example: Correlated subquery
For example, in our Movies table, the values in the Year column must be an Integer, and the values in the Title column must be a String.

This fixed structure is what allows a database to be efficient, and consistent despite storing millions or even billions of rows.

Inserting new data
When inserting data into a database, we need to use an INSERT statement, which declares which table to write into, 
the columns of data that we are filling, and one or more rows of data to insert. In general, each row of data you 
insert should contain values for every corresponding column in the table. You can insert multiple rows at a time 
by just listing them sequentially.

Insert statement with values for all columns
INSERT INTO mytable
VALUES (value_or_expr, another_value_or_expr, …),
       (value_or_expr_2, another_value_or_expr_2, …),
       …;
In some cases, if you have incomplete data and the table contains columns that support default values, you can insert 
rows with only the columns of data you have by specifying them explicitly.

Insert statement with specific columns
INSERT INTO mytable
(column, another_column, …)
VALUES (value_or_expr, another_value_or_expr, …),
      (value_or_expr_2, another_value_or_expr_2, …),
      …;
In these cases, the number of values need to match the number of columns specified. Despite this being a more verbose 
statement to write, inserting values this way has the benefit of being forward compatible. For example, if you add a 
new column to the table with a default value, no hardcoded INSERT statements will have to change as a result to 
accommodate that change.

In addition, you can use mathematical and string expressions with the values that you are inserting.
This can be useful to ensure that all data inserted is formatted a certain way.

Example Insert statement with expressions
INSERT INTO boxoffice
(movie_id, rating, sales_in_millions)
VALUES (1, 9.9, 283742034 / 1000000);
a) employee_demographics Table

Structure:

employee_id (INT, Primary Key)
first_name (VARCHAR)
last_name (VARCHAR)
age (INT)
gender (VARCHAR)
birth_date (DATE)

Example Insert:

INSERT INTO parks_and_recreation.employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES (13, 'Mona', 'Lisa', 32, 'Female', '1993-05-14');

This adds a new employee with ID 13.

b) employee_salary Table
Structure:

employee_id (INT)
first_name (VARCHAR, NOT NULL)
last_name (VARCHAR, NOT NULL)
occupation (VARCHAR)
salary (INT)
dept_id (INT)
Example Insert:

INSERT INTO parks_and_recreation.employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Mona', 'Lisa', 'Receptionist', 40000, 1);

This adds Mona Lisa’s salary details.

c) parks_departments Table
Structure:

department_id (INT, AUTO_INCREMENT, Primary Key)
department_name (VARCHAR, NOT NULL)
Example Insert:

INSERT INTO parks_and_recreation.parks_departments (department_name)
VALUES ('Community Outreach')

The department_id will be auto-generated.

2. UPDATING Rows

Updating rows
In addition to adding new data, a common task is to update existing data, which can be done using an UPDATE statement. Similar 
to the INSERT statement, you have to specify exactly which table, columns, and rows to update. In addition, the data you are 
updating has to match the data type of the columns in the table schema.

Update statement with values
UPDATE mytable
SET column = value_or_expr, 
    other_column = another_value_or_expr, 
    …
WHERE condition;

The statement works by taking multiple column/value pairs, and applying those changes to each and every row that satisfies the 
constraint in the WHERE clause.

Taking care
Most people working with SQL will make mistakes updating data at one point or another. Whether it's updating the wrong set of 
rows in a production database, or accidentally leaving out the WHERE clause (which causes the update to apply to all rows), 
you need to be extra careful when constructing UPDATE statements.

One helpful tip is to always write the constraint first and test it in a SELECT query to make sure you are updating the right 
rows, and only then writing the column/value pairs to update.

a) employee_demographics Table
Example Update: Suppose you want to update Mona Lisa’s age:

UPDATE parks_and_recreation.employee_demographics
SET age = 33
WHERE employee_id = 13;
 
 b) employee_salary Table
Example Update: Suppose Mona Lisa gets a raise:

UPDATE parks_and_recreation.employee_salary
SET salary = 45000
WHERE employee_id = 13;

c) parks_departments Table
Example Update: Suppose you want to rename a department:

UPDATE parks_and_recreation.parks_departments
SET department_name = 'Community Engagement'
WHERE department_id = 7;

