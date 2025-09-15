+++
title = "ORMs"
type = "chapter"
weight = 165
+++

## Competency and Learning Objectives

### Competency:

ORMs

### Learning Objectives:

- I can explain the role of Hibernate in facilitating ORM between Java/Spring
  and MySQL.
- I can implement a code-first approach for database table creation with
  entities and repositories.
- I can implement a code-first approach for setting relationships between
  database tables (one-to-many, many-to-many, one-to-one).

## Introduction

In the last chapter, we learned how to use JPA to connect to a MySQL database
and perform CRUD operations. Specifically, we used a library called "Hibernate"
with JPA to connect our Spring application to a MySQL database by mapping Java
objects to database tables.

This idea of mapping Java objects to database tables is called
Object-Relational Mapping (ORM). JPA is a specification for ORM in Java, and
Hibernate is one of the most popular implementations of JPA.

So far, we have only used hibernate to perform basic CRUD operations on a
single table at a time. This only scratches the surface of what Hibernate and
ORM can do.

In this chapter, we will dive deeper into the Hibernate JPA library and ORM
concepts.

## What is ORM?

Relational databases store data in tables, which consist of rows and columns. Each
row represents a record, and each column represents a field within that
record.  For example, consider a simple `User` table:

| id | name    | email               |
|----|---------|---------------------|
| 1  | Alice   | alice@example.com   |
| 2  | Bob     | bob@example.com     |
| 3  | Charlie | charlie@example.com |

This approach allows for efficent storage and retrieval of data, as well as
the ability to establish relationships between different tables using foreign
keys.  The drawback of this approach is that it requires some indirection to
store heierarchical data structures, such as objects with nested objects.

For example, if we wanted to store multiple addresses for each user, we would
need to create a separate `Address` table and establish a relationship between
the `User` and `Address` tables using a foreign key.

| id | user_id | street        | city        | state | zip   |
|----|---------|---------------|-------------|-------|-------|
| 1  | 1       | 123 Main St   | Springfield | IL    | 62701 |
| 2  | 1       | 456 Oak St    | Springfield | IL    | 62702 |
| 3  | 2       | 789 Pine St   | Shelbyville | IL    | 62565 |

In this case, the `user_id` column in the `Address` table is a foreign key that
ties each address to a specific user in the `User` table.

In contrast, object-oriented programming languages like Java use classes to
model data, which can contain fields of other classes and let us model
heierarchical data structures more naturally. For example, we could define a
`User` class with a list of `Address` objects:

```java
public class User {
    private Long id;
    private String name;
    private String email;
    private List<Address> addresses;

    //...
}
public class Address {
    private Long id;
    private String street;
    private String city;
    private String state;
    private String zip;

    //...
}
```

This approach allows us to model complex data structures more naturally, but it
does not map directly to the tabular structure of a relational database.  If we
wanted to populate a `User` object from the databases, we'd have to write code to
query the `User` table, and use it's data to populate the fields of the `User` object.
Then, we'd have to write another query to get all the `Address` records that
belong to that user, and use that data to populate the `addresses` field of the
`User` object.

An **ORM** is a library that automates this problem of mapping data from database
tables onto objects in an object-oriented programming language.  An ORM will
also generally save us from having to write raw SQL queries, and instead allow
us to annotate how our classes are stored and related, and then provide methods to
query and manipulate the data in the database using those classes.  As users, we
just call normal java methods on our objects, and the ORM takes care of generating
and executing an appropriate SQL query to retrieve the data from the database. 

### Check for Understanding

- What is the main difference between how data is modeled in a relational
  database versus an object-oriented programming language like Java?

    Answer: Relational databases use tables with rows and columns to store data,
    while object-oriented programming languages use classes with fields and methods
    to model data.

- What is the purpose of an ORM?

    Answer: An ORM automates the process of mapping data between relational
    databases and object-oriented programming languages, allowing developers to
    work with database data using familiar object-oriented concepts and methods.

## Hibernate and JPA

[JPA](https://en.wikipedia.org/wiki/Java_Persistence_API) (Java Persistence API) is a
specification for ORM in Java.  It defines a set of annotations and interfaces
that can be used to map Java objects to database tables, as well as a query language
called JPQL (Java Persistence Query Language) that can be used to query the database
using Java objects.

[JPA](https://en.wikipedia.org/wiki/Java_Persistence_API) is just a specification, so it
does not provide an actual implementation.  A specification is simply a set of rules and
guidelines that define how something should work. Basically, someone carefully defined
*how* an ORM should work in Java, but they didn't actually write any Java code to implement
an ORM.  This allows multiple different libraries to implement the JPA specification
in different ways, while still adhering to the same set of rules and guidelines.

[Hibernate](https://hibernate.org/) is one of the most popular implementations of JPA.  It
provides a set of annotations and interfaces that can be used to map Java objects to
database tables, as well as a powerful query language called HQL (Hibernate Query Language)
that can be used to query the database using Java objects.  Hibernate also provides a lot
of additional features and functionality beyond what is defined in the JPA specification.

In the previous chapter, we used Hibernate as our JPA implementation to connect
our Spring application to a MySQL database.  We used JPA annotations to define
an `User` entity, and a `JpaRepository` to perform CRUD operations on the `User`
table in the database.

### Check for Understanding

- What is JPA?

    Answer: JPA (Java Persistence API) is a specification for ORM in Java 

- What is Hibernate?

    Answer: Hibernate is an implementation of the JPA specification

## Setting up a Spring Project to use Hibernate

To use Hibernate in a Spring project, we need to add the following dependencies
to our `pom.xml` file:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <scope>runtime</scope>
</dependency>
```

And then we need to configure the database connection in our `application.properties` file:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/mydatabase
spring.datasource.username=myusername
spring.datasource.password=mypassword
spring.jpa.hibernate.ddl-auto=update
```

Once we have added these dependencies and configured the database connection, we
can start using Hibernate in our Spring project.  Our Spring project now knows
what kind of database we are using, where the database is located, and how to
connect to it.

### Check for Understanding

- What dependencies do we need to add to our `pom.xml` file to use Hibernate
  in a Spring project?

    Answer: We need to add the `spring-boot-starter-data-jpa` and
    `mysql-connector-java` dependencies.

- What properties do we need to configure in our `application.properties` file
    to connect to a MySQL database?

    Answer: We need to configure the `spring.datasource.url`,
    `spring.datasource.username`, and `spring.datasource.password` properties.

## Creating a Model and Repository Class

To be able to get data from the database, we first need to define a model class that 
represents a table in the database.  We can do this by creating a Java class with
fields that correspond to the columns in the table, and then annotating the class
with JPA annotations to specify how the class should be mapped to the table.

For example, let's say we want to create a `User` table in the database.  We can
create a `User` class like this:

```java
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String email;

    // Getters and setters...
}
```

> [!NOTE]
> The getters and setters are omitted for brevity, but they are necessary for the
> JPA to work properly.

In this example, we have annotated the `User` class with the `@Entity` annotation
to indicate that it is a JPA entity.  We have also annotated the `id` field with the
`@Id` annotation to indicate that it is the primary key of the table, and the
`@GeneratedValue` annotation to indicate that the value of the `id` field should be
generated automatically by the database.

We now have a model class.  At the moment, this is just a plain old Java class, that
happens to be annotated with some JPA annotations.  We still need a way to actually
interact with the database using this model class.

To do this, we can create a repository interface that extends the `JpaRepository`
interface provided by Spring Data JPA:

```java
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
}
```

Notice that we have not defined a class here, only an interface with no methods.
This is because Spring Data JPA will automatically generate an implementation of
this interface at runtime.  The `JpaRepository` interface provides a set of methods
for performing CRUD operations on the `User` table in the database.

The messy business of how all of that happens is handled by Spring Data JPA and
Hibernate, and we just get a simple and short interface definition in our code.

Now that we have a model class and a repository interface, we can use the repository
to perform CRUD operations on the `User` table in the database.

### Check for Understanding

- What is the purpose of the `@Entity` annotation?

    Answer: The `@Entity` annotation indicates that a class is a JPA entity and
    should be mapped to a database table.

- What annotation do we use to indicate the primary key of a JPA entity?

    Answer: We use the `@Id` annotation to indicate the primary key of a JPA entity.

- What is the purpose of the `JpaRepository` interface?

    Answer: The `JpaRepository` interface provides a set of methods for performing
    CRUD operations on a JPA entity.


## Accessing the Repository from a Spring-managed Class

To get an instance of the `UserRepository`, we can use Spring's dependency injection
feature.  We can do this by adding a member variable of type `UserRepository` to
a Spring-managed class (like a controller or service), and annotating the member
variable with the `@Autowired` annotation.

For example, we can create a `UserController` class like this:

```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserRepository userRepository;
}
```

This tells Spring to inject an instance of the `UserRepository` into the `userRepository`
member variable when it creates an instance of the `UserController` class.  Spring
will automatically create an instance of the `UserRepository` class made by Spring Data JPA
from our interface definition, and inject it into the `UserController` class.

Now we can use the `userRepository` member variable to perform CRUD operations on
the `User` table in the database.

For example, we can create a method to get all users like this:

```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
}
```

And with very little code and effort, we now have a REST endpoint that
returns all users from the `User` table in the database.

### Check for Understanding

- How do we get an instance of the `UserRepository` in a Spring-managed class?

    Answer: Dependency injection using the `@Autowired` annotation.

- What method do we use to get all users from the `User` table in the database?

    Answer: We use the `findAll()` method provided by the `JpaRepository` interface.

## Modeling relationships with JPA Annotations

In addition to mapping Java classes to database tables, JPA also provides
annotations for modeling relationships between tables.  For example, if 
we wanted to set up a one-to-many relationship between the `User` and
`Address` tables, we could do this by adding a `List<Address>` field to the
`User` class, and annotating it with the `@OneToMany` annotation:

```java
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.OneToMany;
import java.util.List;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String email;

    @OneToMany(mappedBy = "user")
    private List<Address> addresses;

    // Getters and setters...
}
```
---
```java
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.JoinColumn;

@Entity
@Table(name = "addresses")
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String street;
    private String city;
    private String state;
    private String zip;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // Getters and setters...
}
```

With this relationship set up, now when we get a list of users, they will
also have the list of addresses associated with them populated automatically by
Hibernate.  So now if we were to hit the `/users` endpoint, we would get a
list of users, and each user would have a list of addresses associated with them:

```json
[
    {
        "id": 1,
        "name": "Alice",
        "email": "alice@example.com"
        "addresses": [
            {
                "id": 1,
                "street": "123 Main St",
                "city": "Springfield",
                "state": "IL",
                "zip": "62701"
            },
            {
                "id": 2,
                "street": "456 Oak St",
                "city": "Springfield",
                "state": "IL",
                "zip": "62702"
            }
        ]
    },
    {
        "id": 2,
        "name": "Bob",
        "email": "bob@example.com",
        "addresses": [
            {
                "id": 3,
                "street": "789 Pine St",
                "city": "Shelbyville",
                "state": "IL",
                "zip": "62565"
            }
        ]
    },
    // ...
]
```

This is a powerful feature of Hibernate and JPA, as it allows us to model 
complex relationships between tables in a natural way, and have Hibernate
automatically handle the details of querying and populating the related data.

These relationships also work with other CRUD operations, so if we were to
create a new `User` with a list of `Address` objects in java, and then
call `userRepository.save(user)`, Hibernate would automatically insert the
new user into the `User` table, and also insert the associated addresses
into the `Address` table, and set the foreign key fields appropriately.

This doesn't usually come up in REST apis as we are often dealing with
one table at a time, but it is a very useful feature when dealing with
more complex data structures or APIs.


### Check for Understanding

- How do we model a one-to-many relationship between two JPA entities?

    Answer: We use the `@OneToMany` annotation on the "one" side of the
    relationship, and the `@ManyToOne` annotation on the "many" side of the
    relationship.

- What annotation do we use to specify the foreign key column in a JPA entity?

    Answer: We use the `@JoinColumn` annotation to specify the foreign key
    column in a JPA entity.

## Summary

In this chapter, we learned about Object-Relational Mapping (ORM) and how it
allows us to map Java objects to database tables.  We learned about JPA, which
is a specification for ORM in Java, and Hibernate, which is one of the most
popular implementations of JPA.

Working with databases from your Java/Spring backend web application is a
fundamental skill to using Java/Spring for backend web development, and you
will encounter it in nearly every backend project that you work on.  Understanding
how to set up and use JPA/Hibernate models and repositories makes this an
easy and straightforward task.
