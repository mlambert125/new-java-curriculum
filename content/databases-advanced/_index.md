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
    id int primary key,
    first_name varchar(50),
    last_name varchar(50)
);

create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10, 2),
    foreign key (customer_id) references customers(id)
);

insert into customers (id, first_name, last_name, email) values
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Johnson'),
(4, 'Bob', 'Brown');

insert into orders (id, customer_id, order_date, total_amount) values
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00);
```

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
| 4  | Alice      | Johnson   | 2023-04-01 | 250.00       |
| 5  | Alice      | Johnson   | 2023-04-01 | 300.00       |

These results include fields from both the `orders` and `customers` tables.  The `INNER JOIN` clause specifies that we
want to join the `orders` table with the `customers` table on the `customer_id` column in the `orders` table and the
`id` column in the `customers` table.  This means that we want to include all the rows from the `orders` table, but only
the rows from the `customers` table that match the `customer_id` in the `orders` table.

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## LEFT and RIGHT JOINs

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## SubQueries

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## CREATE TABLE

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## Writing a Create Script

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

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


