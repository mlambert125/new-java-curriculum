+++
title = "Introduction to SQL"
type = "chapter"
weight = 142
+++

## Competency and Learning Objectives

### Competency:

Introduction to SQL

### Learning Objectives:

- I can write basic SQL SELECT queries
- I can write basic DELETE, UPDATE and INSERT queries

## Introduction

The main way that we interact with MySQL is through SQL (Structured Query Language). SQL is a language that allows us to
interact with databases. We can use SQL to create, read, update, and delete data in a database.  In this lesson, we will
learn the basics of SQL and how to use mysql workbench to interact with a database.

## Using the MySQL Workbench Query Editor

### Starting MySQL Workbench and Creating a Test Database/Table

First, we need to start MySQL Workbench. Once you have started MySQL Workbench, right-click on the "SCHEMAS" tab in the
left-hand panel and select "Create Schema". A schema is a database in MySQL. You can think of a schema as a container
for related tables for a particular application. Give your schema the name "testdb".

Now, we need to create a table in our database. Expand the newly created schema, and right-click on the "Tables" node.
Select "Create Table". At the top of the window, enter the name "users" for the table. Now, we need to add columns to
the table using the rest of the form. Add the following columns to the table:

| Column Name | Data Type | Length | Attributes  | Description |
|-------------|-----------|--------|-------------|-------------|
| id          | INT       |        | PK, NN, UQ, AI      | A unique auto-incrementing ID for the user |
| username        | VARCHAR   | 45     |             | Username             |
| firstName   | VARCHAR   | 45     |             | First Name             |
| lastName    | VARCHAR   | 45     |             | Last Name            |
| age        | INT       |        |             | Age of the user     |

> [!NOTE]
> We have created a table using the MySQL Workbench GUI. This is a good way to get started with MySQL, but later we
> will learn how to create tables using a SQL script that can be stored with our project and repeated on any MySQL
> server.

### Opening the Query Editor

Now that we have created a table, we can start writing SQL queries. Click on the "New Query" button in the toolbar at
the top of the screen. This will open the query editor. The query editor is where we can write SQL queries to interact
with our database.

We haven't written any SQL yet, but take notice of the toolbar at the top of the query editor. The most important
buttons are the "Execute" button (the lightning bolt), the "Save" button (the floppy disk), and the "Open" button
(the folder).

Execute will run the query that is currently in the editor. Save will save the query to a file on your computer. Open
will open a query from a file on your computer.

As you are learning, you can use the "Save" and "Load" functionality to save your work.

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## Inserting New Data into a Table

To insert new data into a table, we use the INSERT statement. The basic syntax for the INSERT statement is as follows:

```sql
insert into users (username, firstName, lastName, age) values ('jdoe', 'John', 'Doe', 35);
```
Let's break this down:

| Statement Part | Description |
|----------------|-------------|
| `insert into`   | This tells MySQL that we want to insert data into a table. |
| `users`        | This is the name of the table we want to insert data into. |
| (`username, firstName, lastName, age`) | These are the names of the columns we want to insert data into. |
| `values`       | This tells MySQL that we are going to provide the values to insert. |
| `('jdoe', 'John', 'Doe', 35)` | These are the values we want to insert into the columns. |

Notice that the order of the columns in the parentheses must match the order of the values in the parentheses.

Another thing to notice is that we did not include the `id` column in the insert statement. This is because the `id`
column is an auto-incrementing column. This means that MySQL will automatically assign a unique value to the `id` column
for each new row we insert. We can also insert multiple rows at once by separating the values with commas:

```sql
insert into users (username, firstName, lastName, age) values ('jdoe', 'John', 'Doe', 30), ('asmith', 'Alice', 'Smith',
44);
```

This will insert two new rows into the `users` table.  You can keep adding more rows by adding more commas and values.

Before we continue, let's use the insert statement to add a few more users to our `users` table:

```sql
insert into users (username, firstName, lastName, age)
values
    ('asmith', 'Alice', 'Smith', 20),
    ('bdoe', 'Bob', 'Doe', 33),
    ('cjohnson', 'Charlie', 'Johnson', 41),
    ('dlee', 'David', 'Lee', 19),
    ('ejones', 'Eve', 'Jones', 30),
    ('fkim', 'Frank', 'Kim', 15),
    ('gwhite', 'Grace', 'White', 22),
    ('hwang', 'Henry', 'Wang', 19),
    ('ijones', 'Ivy', 'Jones', 50),
    ('jdoe', 'John', 'Doe', 65),
    ('klee', 'Kevin', 'Lee', 62),
    ('lchen', 'Linda', 'Chen', 24),
    ('mlee', 'Michael', 'Lee', 29),
    ('nkim', 'Nancy', 'Kim', 18),
    ('ojohnson', 'Oscar', 'Johnson', 40),
    ('pchen', 'Peter', 'Chen', 55),
    ('qwang', 'Quincy', 'Wang', 28),
    ('rjones', 'Rachel', 'Jones', 37),
    ('slee', 'Sam', 'Lee', 21),
    ('tkim', 'Tina', 'Kim', 26);
```

We'll be using this data for the rest of the lesson, so make sure to run this query in your MySQL Workbench.
You can also use the `select` statement to verify that the data was inserted correctly:

```sql
select * from users;
```

This will retrieve all rows from the `users` table. You should see the data that you just inserted.  We will learn
more about the `select` statement soon, but you can keep using the statement above and rerunning inserts to verify
and restore data as we work through the lesson.

### Check For Understanding

1. **Question:** What kind of statement inserts new data into a table?
    - **Answer:** An INSERT statement.
2. **Question:** Why did we not include the `id` column in the insert statement?
    - **Answer:** Because the `id` column is an auto-incrementing column, MySQL will automatically assign a unique value
      to it.
3. **Question:** How do we insert multiple rows at once?
    - **Answer:** By separating the values with commas in the insert statement.

## Updating Data in a Table

Sometimes we need to update data in a table. To do this, we use the UPDATE statement. An update statement can update
one row, or can update multiple rows at once. The basic syntax for the UPDATE statement is as follows:

```sql
update users set firstName = 'Jane', lastName = 'Doe' where username = 'jdoe';
```

Here's what each part of the statement means:

| Statement Part | Description |
|----------------|-------------|
| `update`       | This tells MySQL that we want to update data in a table. |
| `users`        | This is the name of the table we want to update data in. |
| `set`          | This tells MySQL that we are going to provide the new values to update. |
| `firstName = 'Jane'`, | This is the new value we want to set for the `firstName` column. |
| `lastName = 'Doe'` | This is the new value we want to set for the `lastName` column. |
| `where`        | This tells MySQL that we only want to update certain rows. |
| `username = 'jdoe'` | This is the condition that tells MySQL which rows to update. |

Notice that we used the `where` clause to specify which rows we want to update. If you were to omit the `where` clause,
and the condition, MySQL would update all rows in the table. This is a very important point to remember. Always use the
`where` clause to specify which rows you want to update. Otherwise, you may accidentally update all rows in the table.

You can also update multiple rows at once by using a condition that matches multiple rows. For example, if we wanted to
update all users with the last name "Doe" to have the first name "Jane", we could do the following:

```sql
update users set firstName = 'Jane' where lastName = 'Doe';
```
This would update all users with the last name "Doe" to have the first name "Jane".

### Check For Understanding

1. **Question:** What kind of statement updates data in a table?
    - **Answer:** An UPDATE statement.
2. **Question:**  What is the purpose of the `where` clause in an update statement?
    - **Answer:** To specify which rows we want to update. If we omit the `where` clause, all rows in the table will be
      updated.
3. **Question:** How do we update multiple rows at once?
    - **Answer:** By using a condition that matches multiple rows in the `where` clause.

## Deleting Data from a Table

Removing data from a table is done using the DELETE statement. The basic syntax for the DELETE statement is as
follows:

```sql
delete from users where username = 'jdoe';
```
Let's break this down:
| Statement Part | Description |
|----------------|-------------|
| `delete from`  | This tells MySQL that we want to delete data from a table. |
| `users`        | This is the name of the table we want to delete data from. |
| `where`        | This tells MySQL that we only want to delete certain rows. |
| `username = 'jdoe'` | This is the condition that tells MySQL which rows to delete. |

Notice that we used the `where` clause to specify which rows we want to delete. If you were to omit the `where`
clause, and the condition, MySQL would delete all rows in the table. This is even more important to remember than with
the update statement. Always use the `where` clause to specify which rows you want to delete, unless you really want to
delete all rows in the table.

### Check For Understanding

1. **Question:** What kind of statement deletes data from a table?
    - **Answer:** A DELETE statement.
2. **Question:** What is the purpose of the `where` clause in a delete statement?
    - **Answer:** To specify which rows we want to delete. If we omit the `where` clause, all rows in the table will be
      deleted.
3. **Question:** What happens if we omit the `where` clause in a delete statement?
    - **Answer:** All rows in the table will be deleted.

## Querying Data using SELECT

The final kind of operation that we need is to retrieve data from a table. To do this, we use the SELECT statement. The
SELECT statement is a more complex statement than the INSERT, UPDATE, and DELETE statements. The basic syntax for a
simple SELECT statement is as follows:

```sql
select firstName, lastName from users where lastName = 'Doe';
```

The structure of the SELECT statement is as follows:
| Statement Part | Description |
|----------------|-------------|
| `select`       | This tells MySQL that we want to retrieve data from a table. |
| `firstName, lastName` | These are the names of the columns we want to retrieve. |
| `from`         | This tells MySQL that we will be retrieving data from a table. |
| `users`        | This is the name of the table we want to retrieve data from. |
| `where`        | This tells MySQL that we only want to retrieve certain rows. |
| `lastName = 'Doe'` | This is the condition that tells MySQL which rows to retrieve. |

One difference with the SELECT statement is that we need to specify what columns we are interested in.  When we query
a table, we don't always need all of the columns of data, and it's more efficient to only retrieve the columns that
we need.

We can also use the `*` wildcard to select all columns from a table. For example, if we wanted to retrieve all columns
from the `users` table, we could do the following:

```sql
select * from users;
```

This would retrieve all columns from the `users` table.  This would also retrieve all rows from the table since there
is no `where` clause filtering the results.

### Check For Understanding

1. **Question:** What kind of statement retrieves data from a table?
    - **Answer:** A SELECT statement.
2. **Question:** What is the purpose of the `where` clause in a select statement?
    - **Answer:** To specify which rows we want to retrieve. If we omit the `where` clause, all rows in the table will be
      retrieved.
3. **Question:** How do we retrieve all columns from a table?
    - **Answer:** By using the `*` wildcard in the select statement.

## Compound Conditions

We can write more complex conditions in the `where` clause using the `and` and `or` keywords and by learning a few
more operators. The `and` keyword allows us to combine multiple conditions into a single condition. For example, if we
wanted to retrieve all users with the last name "Doe" and the first name "John", we could do the following:

```sql
select * from users where lastName = 'Doe' and firstName = 'John';
```

The `or` keyword allows us to retrieve rows that match either condition. For example, if we wanted to retrieve all
users with the last name "Doe" or the first name "John", we could do the following:

```sql
select * from users where lastName = 'Doe' or firstName = 'John';
```

You can also use the `not` keyword to negate a condition. For example, if we wanted to retrieve all users with the
last name "Doe" but not the first name "John", we could do the following:

```sql
select * from users where lastName = 'Doe' and not firstName = 'John';
```

We can use parentheses to group conditions together. For example, if we wanted to retrieve all users with the last name
"Doe" and either the first name "John" or "Jane", we could do the following:

```sql
select * from users where lastName = 'Doe' and (firstName = 'John' or firstName = 'Jane');
```

We can also use several operators other than `=` in the `where` clause. The most common ones are:

| Operator | Description | Example |
|----------|-------------|-------------|
| `=`      | Equal to    | `firstName = 'John'` |
| `!=`     | Not equal to |  `firstName != 'John'` |
| `>`      | Greater than | age > 18 |
| `<`      | Less than   | age < 18 |
| `>=`     | Greater than or equal to |  `>= 18` |
| `<=`     | Less than or equal to |  `<= 18` |
| `like`   | Matches a pattern with % as a wildcard for any number of other letters | `firstName like 'J%'` |
| `in`     | Matches a value in a list where the list is a comma-separated list in parentheses |  `firstName in ('John', 'Jane')` |

### Check For Understanding

1. **Question:** What are the two keywords we can use to combine multiple conditions in the `where` clause?
    - **Answer:** `and` and `or`.
2. **Question:** What does the `not` keyword do in a condition?
    - **Answer:** It negates the condition, meaning it will return rows that do not match the condition.
3. **Question:** How do we group conditions together in a `where` clause?
    - **Answer:** By using parentheses.
4. **Question:** What would the expression `firstName like 'J%'` return?
    - **Answer:** It would return all rows where the first name starts with the letter "J". The `%` wildcard matches any
      number of letters after the "J".

## Aliases and Calculated Fields

We can do some interesting things with the column list portions of the SELECT statement.

### Aliases
We can use the `as` keyword to create an alias for a column. An alias lets us call a column something other than its
name in our result set. For example, if we wanted to retrieve the first name and last name of all users, but we wanted
to call the first name "First" and the last name "Last", we could do the following:

```sql
select firstName as First, lastName as Last from users;
```

When we execute this query, the result set will have two columns: "First" and "Last" instead of "firstName" and
"lastName".

### Calculated Fields

We can also create calculated fields in the SELECT statement. A calculated field is a field that is not in the table,
but is made by combining other fields. For example, if we wanted to retrieve usernames and age in 10 years, we could do
the following:

```sql
select username, age + 10 as ageIn10Years from users;
```

This would retrieve the username and a new column called "ageIn10Years" that is the age of the user plus 10.  For 
calculated fields, we always also use an alias to name the new column.

In addition to mathematical operators on number fields, we can also use string operators on string fields. The most
common string operator is the `concat` function. The `concat` function takes two or more strings and combines them into
one string. For example, if we wanted to retrieve the first name and last name of all users, but we wanted to combine
them into a single column called "fullName", we could do the following:

```sql
select concat(firstName, ' ', lastName) as fullName from users;
```

Here are some of the common functions that we can use in the SELECT statement:

| Function | Description |
|----------|-------------|
| `concat(firstName, ' ', lastName)` | Combines two or more strings into one string. |
| `length(firstName)` | Returns the length of a string. |
| `upper(firstName)` | Converts a string to uppercase. |
| `lower(firstName)` | Converts a string to lowercase. |
| `substring(firstName, 1, 3)` | Returns a substring of a string. The first parameter is the string, the second parameter is the starting index (0-based), and the third parameter is the length of the substring. |
| `trim(firstName)` | Removes leading and trailing whitespace from a string. |
| `round(age, 0)` | Rounds a number to the nearest integer. The first parameter is the number, and the second parameter is the number of decimal places to round to. |

### Check For Understanding

1. **Question:** What is an alias in SQL?
    - **Answer:** An alias is a name we give to a column in the result set that is different from its name in the table.
2. **Question:** What is a calculated field in SQL?
    - **Answer:** A calculated field is a field that is not in the table, but is made by combining other fields.
3. **Question:** How do we create a calculated field in SQL?
    - **Answer:** By using a mathematical or string operator in the SELECT statement and giving it an alias.
4. **Question:** What does the `concat` function do in SQL?
    - **Answer:** The `concat` function takes two or more strings and combines them into one string.
5. **Question:** What does the `length` function do in SQL?
    - **Answer:** The `length` function returns the length of a string.
6. **Question:** What does the `upper` function do in SQL?
    - **Answer:** The `upper` function converts a string to uppercase.

## Order By and Limit

### Sorting with `order by`

We can also sort the results of a SELECT statement using the `order by` clause. The `order by` clause allows us to sort
the results of a query by one or more columns. For example, if we wanted to retrieve all users and sort them by age in
descending order, we could do the following:

```sql
select * from users order by age desc;
```

This would retrieve all users and sort them by age in descending order. We can also sort by multiple columns. For
example, if we wanted to retrieve all users and sort them by last name in ascending order and then by first name in
ascending order, we could do the following:

```sql
select * from users order by lastName asc, firstName asc;
```

This would retrieve all users and sort them by last name in ascending order and then if any users have the same last
name, sort them within their group by first name in ascending order.

### Limiting the Number of Rows Returned with `limit`

We can also limit the number of rows returned by a query using the `limit` clause. The `limit` clause allows us to
specify how many rows we want to retrieve. For example, if we wanted to retrieve the first 5 users in the table, we
could do the following:

```sql
select * from users limit 5;
```

This would retrieve the first 5 users in the table. We can also specify an offset to start from. For example, if we
wanted to retrieve the next 5 users in the table starting from the 6th user, we could do the following:

```sql
select * from users limit 5 offset 5;
```

This would retrieve the next 5 users in the table starting from the 6th user.

### Paging with `limit`, `offset` and `order by`

We can combine `limit`, `offset`, and `order by` to create paging functionality. Imagine a web page with a table of
users that shows 10 users per page and lets the user sort by any column.  Let's say the user is on page 3 and wants to
see the next 10 users sorted by last name. We could do the following:

```sql
select * from users order by lastName asc limit 10 offset 20;
```

This would retrieve the next 10 users in the table starting from the 21st user and sorted by last name in ascending
order.

### Check For Understanding

1. **Question:** What does the `order by` clause do in a SELECT statement?
    - **Answer:** It sorts the results of the query by one or more columns.
2. **Question:** What does the `limit` clause do in a SELECT statement?
3. **Question:** What does the `offset` clause do in a SELECT statement?
    - **Answer:** It specifies where to start retrieving rows from when using the `limit` clause.
4. **Question:** How do we combine `limit`, `offset`, and `order by` to create paging functionality?
    - **Answer:** By using the `limit` and `offset` clauses to specify how many rows to retrieve and where to start
      retrieving from, and the `order by` clause to specify how to sort the results.

## Practice/Project Task

- Activity Description:
- Prompt:
- Format (individual, pair programming, presentation, group discussion, etc.):
- Tools:
- Time Estimate:
- Test Case
    - Input: 
    - Output:
- Expected Outcomes: 
    - **Green**:
    - **Yellow**:
    - **Red**:

## Conclusion

In this lesson, we learned the basics of SQL and how to use MySQL Workbench to interact with a database. We learned
how to create a database and a table, and how to insert, update, delete, and select data from a table. We also learned
how to use the `where` clause to filter results, how to use aliases and calculated fields, and how to use compound
conditions. We also learned about some common functions that we can use in the SELECT statement. 

Understanding how to use SQL is a critical skill for any developer, as it allows us to interact with databases and
retrieve the data we need for our applications. While using an ORM like JPA can let us work with databases without
writing SQL, knowing how to write more complex queries and using SQL is a valuable skill that can help you become
a uniquely qualified and valuable developer.

In the next lesson, we will learn about JOINS and SubQueries and how to create a database creation script that can be
used to create a database and tables on any MySQL server entirely from an SQL script.

