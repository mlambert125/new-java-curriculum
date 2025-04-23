+++
title = "Database Design"
type = "chapter"
weight = 144
+++

## Competency and Learning Objectives

### Competency

Database Design

### Learning Objectives

- I can explain SQL data types
- I can write SQL create table and drop table statements
- I can create a full SQL database creation script

## Introduction

In this lesson we will learn about SQL data types, how to create tables in SQL,
and how to write a complete SQL database creation script.  It is important to
learn to write a create database script because it allows you to create a
database with a repeatable and portable process.  This is especially useful
when you need to set up a database in a new environment or share your database
with others.

When we have a database script, the database definition is contained completely
in a file and can be saved in our project directory and source controlled just
like any other code file.  This allows us to track changes to the database
and collaborate with others on the database design.

## SQL Data Types

Before we should review the SQL data types that are available to us.  SQL data
types are used to define the type of data that can be stored in a column of a
database table.  In MySql, there are several data types that we can use,
including:

- `INT`: Used for integer values.
- `VARCHAR(n)`: Used for variable-length (short) strings, where `n` is the
maximum length.
- `TEXT`: Used for long text strings.
- `TIMESTAMP`: Used for date and time values with timezone information.
- `BOOLEAN`: Used for true/false values.

### Check For Understanding

1. **Question:** What data type would you use for a long description of a product?
    - **Answer:** `TEXT` would be appropriate for a long description of a product.
2. **Question:**  What data type would you use for a user's age?
    - **Answer:** `INT` would be appropriate for a user's age since it is a
    whole number.

## CREATE TABLE

A `CREATE TABLE` statement is used to create a new table in a database. Here's a
basic example creating a table for storing user information:

```sql
CREATE TABLE users (
    id INT,
    username VARCHAR(50),
    email VARCHAR(100),
    password VARCHAR(255),
    created_at TIMESTAMP
);
```

Notice that the table name comes after the `CREATE TABLE` statement, and the
field declarations follow (enclosed in parentheses). Each field declaration
consists of a field name, a data type, and optional constraints (which we
will see in more detail later).

> [!NOTE]
> This is an incomplete example.  We will add constraints and other
> important elements in the next sections.

### Nullability Constraints

The first thing that we can add to these field declarations is a bit
of syntax to note whether the field can bej `NULL` or not.  By default, fields
are nullable, meaning they can contain a `NULL` value.  If we want to
make a field non-nullable, we can add the `NOT NULL` constraint to the
field declaration.  We can also explicitly declare a field as nullable
with the `NULL` constraint, but this is not necessary since it is the default.

Let's modify our `CREATE TABLE` statement to explicitly declare all fields
as `NOT NULL` except for the `email` field, which we will allow to be nullable:

```sql
CREATE TABLE users (
    id INT NOT NULL,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL
);
```

Constraints like `NULL` and `NOT NULL` for each field are specified after the
field type.

### Primary Key Constraint

The next important constraint we can add is the `PRIMARY KEY` constraint.
This constraint marks a field (or a combination of fields) as the primary key
of the table. The primary key uniquely identifies each row in the table and
must contain unique values.

Now let's modify our `CREATE TABLE` statement to specify that the `id` field is
the primary key:

```sql
CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL
);
```

Notice that we added the `PRIMARY KEY` constraint to the `id` field right
after the `NOT NULL` constraint. This means that the `id` field must
be unique for each row in the table and cannot be `NULL`.

### Auto Incrementing

We would probably like the `id` field to automatically be assigned a unique
incrementing value when a new row is inserted into the table vs. manually
specifying it when inserting a new row.  We can do this by adding the
auto-incrementing property to the `id` field. In MySQL, we can do this
by adding the `AUTO_INCREMENT` keyword to the field declaration:

```sql
CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL
);
```

The id field will now automatically be assigned a unique incrementing value
when a new row is inserted into the table.

### Default Values

Another constraint we can add is a default value for a field. A default value
is the value that will be used for a field if no value is specified when
inserting a new row. We can specify a default value by using the
default keyword followed by the value we want to use.

Let's add a default for the email field, which will be set to 'N/A' if no
email is provided when inserting a new row:

```sql
CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NULL DEFAULT 'N/A',
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

```

A particularly handy default value is the current timestamp. We can set the
`created_at` field to automatically use the current timestamp when a new
row is inserted by using the `CURRENT_TIMESTAMP` function:

```sql
CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NULL DEFAULT 'N/A',
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

### Foreign Key constraints

Finally, we will look at how to create foreign key constraints. A foreign key
constraint establishes a relationship between two tables and requires that
a field's values are present in the primary key of another table.

Let's create another table called `posts` that will have a foreign key
relationship to the `users` table. The `posts` table will have a field
called `user_id` that will reference the `id` field in the `users` table:

```sql
create table posts (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL REFERENCES users(id),
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL
);
```

The constraint here starts with the `REFERENCES` keyword, which specifies
that the field is a foreign key that references a field in another table.
In this case, the `user_id` field in the `posts` table references the `id`
field in the `users` table. This means that any value inserted into the
`user_id` field must already exist in the `id` field of the `users` table.

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

## Reflection Task

- Prompt:
- Expected Outcomes:
  - **Green**:
  - **Yellow**:
  - **Red**:

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
