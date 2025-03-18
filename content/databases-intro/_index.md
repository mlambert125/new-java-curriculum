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

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## Updating Data in a Table

- Prompt:
- Expected Outcomes: 
    - **Green**:
    - **Yellow**:
    - **Red**:

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## Deleting Data from a Table

- Prompt:
- Expected Outcomes: 
    - **Green**:
    - **Yellow**:
    - **Red**:

## Querying Data using SELECT

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

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

## Sharing Task

- Prompt:
- Format (individual, pair programming, presentation, group discussion, etc.): 
- Tools:

## Conclusion


