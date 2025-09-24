/*

Dropping tables
In some rare cases, you may want to remove an entire table including all of its data and metadata, 
and to do so, you can use the DROP TABLE statement, which differs from the DELETE statement in that 
it also removes the table schema from the database entirely.

Drop table statement
DROP TABLE IF EXISTS mytable;

Like the CREATE TABLE statement, the database may throw an error if the specified table does not exist, 
and to suppress that error, you can use the IF EXISTS clause.

In addition, if you have another table that is dependent on columns in table you are removing (for example, 
with a FOREIGN KEY dependency) then you will have to either update all dependent tables first to remove the 
dependent rows or to remove those tables entirely.

Dropping tables in SQL is a way to permanently delete a table and all of its data from a database. This action cannot be undone, so it should be used with caution.

🧠 Syntax of DROP TABLE

DROP TABLE table_name;

You can also drop multiple tables at once:

DROP TABLE table1, table2;

🔧 Examples Using Your Parks_and_Rec Database
Let’s say you want to remove the employee_salary table:

DROP TABLE employee_salary;

If you want to remove both employee_salary and employee_demographics:

DROP TABLE employee_salary, employee_demographics;

⚠️ Important Notes
Data Loss: All data in the table is lost.
Dependencies: If other tables reference the one you're dropping (via foreign keys), you may need to drop those constraints first.
Safe Practice: Always back up your data before dropping tables.

✅ Use Case in Your SQL File
Your script starts with:

DROP DATABASE IF EXISTS `Parks_and_Recreation`;

This is similar—it drops the entire database if it exists. You can do the same for tables:

DROP TABLE IF EXISTS employee_salary;

This avoids errors if the table doesn’t exist.