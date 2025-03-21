+++
title = "Advanced SQL"
type = "chapter"
weight = 143
+++

## Competency and Learning Objectives

### Competency:

Advanced SQL

### Learning Objectives:

- I can write and explain JOINS and SubQueries
- I can write GROUP BY statements and use aggregate functions

## Introduction

In the previous lesson, we learned about the basics of SQL and how to perform simple queries. In this lesson, we will
dive deeper into SQL by exploring JOINS, SubQueries, and GROUP BY statements. These concepts are essential for working
with relational databases and will help you retrieve and manipulate data more effectively.

This will be a particularly challenging section, so be sure to take your time and ask questions if you need help.

## Setting up a Test Database

Create a database called `online_store` and execute the following SQL commands to create a test database and populate
it with sample data. This will allow you to practice the concepts we will cover in this lesson.

We will learn more about how to create a script like this later in this lesson, but for now, just run it to set up your
test database.

```sql
drop table if exists customers;
drop table if exists orders;

create table customers (
    id int primary key auto_increment,
    first_name varchar(50),
    last_name varchar(50)
);

create table orders (
    id int primary key,
    customer_id int null,
    order_date date,
    total_amount decimal(10, 2),
    foreign key (customer_id) references customers(id)
);

insert into customers (id, first_name, last_name, email) values
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

insert into orders (id, customer_id, order_date, total_amount) values
(1, '2023-01-01', 100.00),
(1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);
```

This query will create two tables, `customers` and `orders`, and populate them with sample data. The `customers` table
contains information about 4 customers, and the `orders` table contains information about 6 orders. The `customer_id`
column in the `orders` table is a foreign key that references the `id` column in the `customers` table.

**Customers**

| id | first_name | last_name |
|----|------------|-----------|
| 1  | John       | Doe       |
| 2  | Jane       | Smith     |
| 3  | Alice      | Smith     |
| 4  | Bob        | Brown     |

**Orders**

| id | customer_id | order_date | total_amount |
|----|-------------|------------|--------------|
| 1  | 1           | 2023-01-01 | 100.00       |
| 2  | 1           | 2023-02-01 | 150.00       |
| 3  | 2           | 2023-01-01 | 200.00       |
| 4  | 3           | 2023-04-01 | 250.00       |
| 5  | 3           | 2023-04-01 | 300.00       |
| 6  | NULL        | 2023-04-01 | 100.00       |

Notice that order 6 has a `customer_id` of `NULL`. This is an order that was placed by a guest customer who did not
create an account. This is a common scenario in e-commerce applications.  Notice also that Bob Brown has created an
account, but has not placed any orders yet.

## GROUP BY and Aggregate Functions

GROUP BY is a clause that you can use in a SELECT statement to "roll up" or group rows that have the same values
in specified columns into summary rows. This is often used with aggregate functions like COUNT, SUM, AVG, MAX, and MIN
that create a calculated field that combines values from the grouped rows into a single value.

Let's look at an example using the `orders` table we created earlier. We can use GROUP BY to find the total amount spent
by each customer:

```sql
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;
```

This query will return a result set that shows the total amount spent by each customer. The `SUM` function combines the
`total_amount` values for each customer, and the `GROUP BY` clause specifies that we want to group/roll up the results
by `customer_id`.

The result will look like this:

| customer_id | total_spent |
|-------------|-------------|
| 1           | 250.00      |
| 2           | 200.00      |
| 3           | 550.00      |
| NULL        | 100.00      |

An important constraint when using a GROUP BY clause is that all columns in the SELECT statement must have an aggregate
function applied to them to specify how to combine the columns into one field.

```sql
SELECT customer_id, order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;
```

This query will throw an error because `order_date` is not included in an aggregate function. 

If you think about it, this makes sense because the database engine doesn't know how to combine the `order_date` values.
The first row in the results are a combined row of two different orders for two different dates. If we were to
include the `order_date` column, which date would be shown?  It is ambiguous and so it is not allowed.

There is one other way that we can include a column in the SELECT statement without using an aggregate function. You can
add the column to the GROUP BY clause. This will group the results by that column as well.

```sql
SELECT customer_id, order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id, order_date;
```

This will return a result set that shows the total amount spent by each customer on each order date. The `GROUP BY`
clause specifies that we want to group/roll up the results by both `customer_id` and `order_date`.  This will include
the date, but will also create a new row for each unique combination of `customer_id` and `order_date`.

The result will look like this:

| customer_id | order_date | total_spent |
|-------------|------------|-------------|
| 1           | 2023-01-01 | 100.00      |
| 1           | 2023-02-01 | 150.00      |
| 2           | 2023-01-01 | 200.00      |
| 3           | 2023-04-01 | 550.00      |
| NULL        | 2023-04-01 | 100.00      |

Most of these rows are now unrolled back to only reflecting one order because in most cases, each customer only has one
order on each date.  The exception is customer 3, who has two orders on the same date.

### Check For Understanding

1. **Question:**  
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## HAVING and WHERE Clauses

The WHERE clause is used to filter rows before the aggregation takes place. This means that it will filter the rows
before the GROUP BY clause is applied. The HAVING clause is used to filter rows after the aggregation takes place. This
means that it will filter the rows after the GROUP BY clause is applied.

Let's add a WHERE clause to our previous example to filter the results to only include orders that are greater than
$200:

```sql
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount > 200
GROUP BY customer_id;
```

This query will return a result set that shows the total amount spent by each customer, but will only include orders
that are greater than $200 in the grouping.  Remember that the WHERE clause is applied before the GROUP BY clause.

The result will look like this:

| customer_id | total_spent |
|-------------|-------------|
| 2           | 200.00      |
| 3           | 550.00      |

A HAVING clause works just like a WHERE clause, but it is applied after the GROUP BY clause to filter aggregate 
columns. This means that it will filter the rows after the aggregation takes place.  Let's go back to the original
query and add a HAVING clause to filter the results to only include customers who have spent more than $200 *total*:

```sql
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200;
```

This query will return a result set that shows the total amount spent by each customer, but will only include customers
who have spent more than $200 in total.  Remember that the HAVING clause is applied after the GROUP BY clause.

### Check For Understanding

1. What is the purpose of the GROUP BY clause?
    - **Answer:** The GROUP BY clause is used to group rows that have the same values in specified columns into summary
      rows.
2. **Question:** What is the purpose of the HAVING clause?
    - **Answer:** The HAVING clause is used to filter rows after the aggregation takes place. This means that it will
    filter the rows after the GROUP BY clause is applied.
3. **Question:** What is the difference between a WHERE clause and a HAVING clause?
    - **Answer:** A WHERE clause is used to filter rows before the aggregation takes place, while a HAVING clause is
    used to filter rows after the aggregation takes place.

## INNER JOINs

Joins are used to extend the results of a table query by including data from another table that is related to the first
table through some common field value.

For example, consider the `orders` table we created earlier.  A simple query to get all the orders would look like this:

```sql
SELECT * FROM orders;
```

And the result would look like this:

| id | customer_id | order_date | total_amount |
|----|-------------|------------|--------------|
| 1  | 1           | 2023-01-01 | 100.00       |
| 2  | 1           | 2023-02-01 | 150.00       |
| 3  | 2           | 2023-01-01 | 200.00       |
| 4  | 3           | 2023-04-01 | 250.00       |
| 5  | 3           | 2023-04-01 | 300.00       |
| 6  | NULL        | 2023-04-01 | 100.00       |

What if we wanted to include the customer's first and last name in the results?  These aren't stored in the `orders`
table, but they are stored in the `customers` table.  We can look up the customer name by looking up the `customer_id`
in the `customers` table.  A join let's us do this lookup and include the results in our final output.  In a query,
it looks like this:

```sql
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders 
INNER JOIN customers ON orders.customer_id = customers.id;
```
This query will return a result set that shows all the orders, but will also include the customer's first and last name.
The `INNER JOIN` clause specifies that we want to join the `orders` table with the `customers` table on the
`customer_id` column in the `orders` table and the `id` column in the `customers` table.

The result will look like this:

| id | first_name | last_name | order_date | total_amount |
|----|------------|-----------|------------|--------------|
| 1  | John       | Doe       | 2023-01-01 | 100.00       |
| 2  | John       | Doe       | 2023-02-01 | 150.00       |
| 3  | Jane       | Smith     | 2023-01-01 | 200.00       |
| 4  | Alice      | Smith   | 2023-04-01 | 250.00       |
| 5  | Alice      | Smith   | 2023-04-01 | 300.00       |

These results include fields from both the `orders` and `customers` tables.  The `INNER JOIN` clause specifies that we
want to join the `orders` table with the `customers` table on the `customer_id` column in the `orders` table and the
`id` column in the `customers` table.  This means that we want to include each of the rows from the `orders` table,
with their corresponding customer's first and last name from the `customers` table.

Notice that order 6 is not included in the results.  This is because it has a `customer_id` of `NULL`, and there is no
matching `id` in the `customers` table.  This is the behavior of an `INNER JOIN`.  It only includes rows that have a
matching value in *both* tables.

### Check For Understanding

1. **Question:** What is the purpose of a JOIN in SQL?
    - **Answer:** Joins are used to extend the results of a table query by including data from another table that is
    related to the first table through some common field value.
2. **Question:** What happens if there is no matching value in the second table for a row in the first table in an 
    INNER JOIN?
    - **Answer:** The row is not included in the results.

## LEFT JOINs

A `LEFT JOIN` is similar to an `INNER JOIN`, but it includes all the rows from the first table, even if there is no
matching row in the second table.  If there is no matching row in the second table, the values from the columns from
the second table will be `NULL`.  An example will make this clearer. Let's modify our previous query to use a `LEFT
JOIN` instead of an `INNER JOIN`:

```sql
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;
```

Now, the result will look like this:

| id | first_name | last_name | order_date | total_amount |
|----|------------|-----------|------------|--------------|
| 1  | John       | Doe       | 2023-01-01 | 100.00       |
| 2  | John       | Doe       | 2023-02-01 | 150.00       |
| 3  | Jane       | Smith     | 2023-01-01 | 200.00       |
| 4  | Alice      | Smith   | 2023-04-01 | 250.00       |
| 5  | Alice      | Smith   | 2023-04-01 | 300.00       |
| 6  | NULL       | NULL      | 2023-04-01 | 100.00       |

Compare this to the results of the `INNER JOIN` query.  Notice that order 6 is now included in the results, with the
`first_name` and `last_name` columns set to `NULL`.

A `LEFT JOIN` is useful when you want to include all the rows from the first table, even if there is no matching row in
the second table.  This is a common scenario when you want to include optional data from another table.

### Check For Understanding

1. **Question:** What is the difference between an INNER JOIN and a LEFT JOIN?
    - **Answer:** An INNER JOIN only includes rows that have a matching value in both tables, while a LEFT JOIN includes
    all the rows from the first table, even if there is no matching row in the second table.
2. **Question:** When would you use a LEFT JOIN instead of an INNER JOIN?
    - **Answer:** You would use a LEFT JOIN when you want to include all the rows from the first table, even if there is
    no matching row in the second table.

## Other Types of JOINS

There are other types of joins that you can use in SQL, but they are very uncommon.  We will not review these in detail,
but you should be aware of them in case you encounter them in the future:

| Join Type | Description |
|-----------|-------------|
| RIGHT JOIN | Similar to a LEFT JOIN, but includes all the rows from the second table, even if there is no matching row in the first table. |
| FULL JOIN | Includes all the rows from both tables, regardless of whether there is a matching row in the other table. |
| CROSS JOIN | Returns the Cartesian product of the two tables.  This means that it returns all possible combinations of rows from the two tables.  This can be very large and is rarely used. |

## SubQueries

Joins are one way to combine data from multiple tables in a single query. Another way is to use subqueries. A subquery
lets us directly embed and use the results of one query as the input for another query.  There are several places that
we can use subqueries, each with their own rules and restrictions.

### Scalar Subqueries

Scalar subqueries are subqueries that return a single value (a single row with a single column).  You can use scalar
subqueries in a query anywhere you would use a single value, such as in a comparison or as an argument to a function.

```sql
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >= (SELECT AVG(total_amount) FROM orders); 
```

This query will return all orders where the `total_amount` is greater than or equal to the average `total_amount` of all
orders.  The subquery `(SELECT AVG(total_amount) FROM orders)` calculates the average `total_amount` of all orders, and
the main query filters the results to only include orders where the `total_amount` is greater than or equal to the
average.

| id | order_date | total_amount |
|----|------------|--------------|
| 3  | 2023-01-01 | 200.00       |
| 4  | 2023-04-01 | 250.00       |
| 5  | 2023-04-01 | 300.00       |

### Column Subqueries

Column subqueries are subqueries that return multiple values (multiple rows with a single column).  You can use column 
subqueries in a query anywhere you would use a list of values, such as in an `IN` clause.

```sql
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Smith');
```

This query will return all orders where the `customer_id` is in the list of `id` values of customers with the last name
'Smith'.  The subquery `(SELECT id FROM customers WHERE last_name = 'Smith')` returns a list of `id` values of customers
with the last name 'Smith', and the main query filters the results to only include orders where the `customer_id` is in
that list.

In the case of our sample data, this query will return all orders placed by *Alice Smith* or *Jane Smith*.

| id | order_date | total_amount | customer_id |
|----|------------|--------------|-------------|
| 3  | 2023-01-01 | 200.00       | 2           |
| 4  | 2023-04-01 | 250.00       | 3           |
| 5  | 2023-04-01 | 300.00       | 3           |

This only includes orders placed by customers with the last name 'Smith'.  If you look at the `customers` table, you
will see that *Jane Smith* (customer 2) and *Alice Smith* (customer 3) are the only customers with the last name
'Smith'.

### Table Subqueries

Table subqueries are subqueries that return multiple columns and rows.  You can use table subqueries in a query anywhere
you would use a table, such as in a FROM clause.

```sql
SELECT order_date
FROM (SELECT id, order_date, total_amount FROM orders) AS order_summary;
```

This query will return all the `order_date` values from the `orders` table.  The subquery `(SELECT id, order_date,
total_amount FROM orders)` returns all the columns from the `orders` table, and the main query selects only the
`order_date` column from the subquery.

### Check For Understanding

1. **Question:** What is a scalar subquery?
    - **Answer:** A scalar subquery is a subquery that returns a single value (a single row with a single column).
2. **Question:** What is a column subquery?
    - **Answer:** A column subquery is a subquery that returns multiple values (multiple rows with a single column).
3. **Question:** What is a table subquery?
    - **Answer:** A table subquery is a subquery that returns multiple columns and rows.

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

In this lesson, we learned about advanced SQL concepts like JOINS, SubQueries, and GROUP BY statements. These concepts
are important for complex data work and will help you retrieve and manipulate data more effectively, and will set you
apart in your career as a fullstack developer.

