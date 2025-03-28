+++
title = "Springboot JPA"
type = "chapter"
weight = 160
+++

## Competency and Learning Objectives

### Competency:

Spring Boot JPA

### Learning Objectives:

- I can add Spring Data JPA to a Spring Boot application.
- I can create a Spring Data JPA repository.
- I can use Spring Data JPA to perform CRUD operations on a database.
- I can create controllers that use Spring Data JPA repositories to provide RESTful APIs.

## Introduction

Spring Boot provides a powerful and flexible way to work with databases in your applications.  Spring Data JPA is a
part of the Spring Data project, which aims to simplify working with databases in Spring applications.  Spring Data JPA
allows us to store and retrieve java objects from a database without writing any SQL queries.  It provides a generic
data access framework that works with any database that has a JDBC driver.

You may be wondering how a database fits into the way that we have been using the Spring Boot framework so far.  You'll
recall that in the previous lesson, we learned about the MVC pattern.  In short, Spring Boot JPA lets us store
our model instances in a database, so that they can persist beyond the life of a single request and even to live between
restarts of the application or the computer/server that the application is running on.

In order to accomplish this, we are going to expand our Spring Boot application by:

1. Adding Spring Data JPA to our project.
2. Annotating our model classes for storage in the database, and adding an id field to each class to act as the
    primary key.
3. Adding a new kind of class to our project called a repository that will be in charge of storing and retrieving
    our model instances to and from the database.
4. Using the repository in our controller to provide RESTful APIs for interacting with the data.


There is a lot to cover in this lesson, so let's get started!

## Adding Spring Data JPA to a Spring Boot Application

Spring Data JPA is a part of the Spring Data project, which aims to simplify working with databases in Spring
applications.  Spring Data JPA is a generic data access framework that works with any database that has a JDBC driver.

A JDBC driver is a java library that allows your application to connect to a specific kind of database.  This driver
works in conjnction with Spring Data JPA to allow your application to communicate with the database.

To add Spring Data JPA to a Spring Boot application, you need to add the `spring-boot-starter-data-jpa` dependency to
your `pom.xml` file. This will include all the necessary dependencies for using Spring Data JPA in your application.
If you open your `pom.xml` file, you should see a `<dependencies>` section. You can add the following dependency to this
section:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
```

You also need to add the database driver dependency for the database you are using. In our case, we are using MySQL, so
we need to add the `mysql-connector-java` dependency.

```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <scope>runtime</scope>
</dependency>
```

> ![Note]
> When creating a new project with Spring Initializr, you can add the Spring Data JPA dependency and the mysql driver
> to your project by selecting them from the list of dependencies before generating the project.  Your project will
> then include the necessary dependencies in the `pom.xml` file and you can skip the steps above.

### Update the `application.properties` file

You also need to update the `application.properties` file to include the database connection information.  This file is
located in the `src/main/resources` directory of your project.  You need to add the following properties to this file:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/your_database_name
spring.datasource.username=your_username
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update
```

> ![Note]
> Once you have added JPA and the mysql driver to your project, it is **mandatory** that you add the above properties to
> your `application.properties` file.  If you do not add these properties, your application will not be able to connect
> to the database and will fail to even start properly.  JPA expects a properly configured `application.properties` file
> to be present in your project.

After adding these properties, you can run your application and it should start up properly.  We aren't doing anything
with the database yet, but we have successfully added Spring Data JPA to our project and configured it to connect to
the database so that we can start using it in our Spring Boot Web application.

### Check For Understanding

1. **Question:** What two dependencies do you need to add to your `pom.xml` file to use Spring Data JPA with mysql as
    your database?
    - **Answer:** 
        - `spring-boot-starter-data-jpa`
        - `mysql-connector-java`
2. **Question:** What properties do you need to add to your `application.properties` file to connect to your database?
    - **Answer:** 
        - `spring.datasource.url`
        - `spring.datasource.username`
        - `spring.datasource.password`
        - `spring.jpa.hibernate.ddl-auto`

## Annotating Model Classes for Storage

When using Spring Data JPA, you need to annotate your model classes so that Spring Data JPA knows how to map them to
the database.

1. Use the `@Entity` annotation on the class to mark it as an entity that should be stored in the database.
2. Use `@Column('my_column_name')` to specify the column name in the database.
3. Include a field to act as the primary key (unique identifier) for each instance of the class.  If there is not a
    field that is unique to each record, you can add an `int` field called `id` to the class and annotate it with
    `@GeneratedValue(strategy = GenerationType.IDENTITY)` to specify that the value should be an automatically
    incrementing field whose value is generated and managed by the database.
4. Whether it is autogenerated or not, the field that is the primary key, must be annotated with the `@Id` annotation
    to mark it as the primary key.
5. Make sure your class has a default/empty constructor

Here is an example of a model class that is annotated for storage in the database:

```java
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;
    
    // We must include a default constructor!
    public User() {}

    // getters and setters
    // ...
}
```
In this example, the `User` class is marked as an entity with the `@Entity` annotation.  The `id` field is marked as the
primary key with the `@Id` annotation, and the `@GeneratedValue` annotation specifies that the value should be generated
by the database.  The `firstName` and `lastName` fields are mapped to columns in the database with the `@Column`
annotation.

### Check For Understanding

1. **Question:** What annotation do you use to mark a class as an entity that should be stored in the database?
    - **Answer:** @Entity
2. **Question:**  What annotation do you use to specify the column name in the database?
    - **Answer:** @Column
3. **Question:** What annotation do you use to mark a field as the primary key?
    - **Answer:** @Id
4. **Question:** What annotation do you use to specify that the primary key value should be generated by the database?
    - **Answer:** @GeneratedValue

## Repository Interfaces

Once you have annotated your model classes, you need to create a repository interface for each model classthat you want
to store in the database.  A repository interface is an interface that extends the `JpaRepository` interface provided by
Spring Data JPA.  The `JpaRepository` interface provides methods for performing CRUD operations on the model class.

It may seem unusual to create an interface without providing an implementation, but Spring Data JPA will automatically
generate an implementation for the repository interface at runtime.  This is one of the powerful features of Spring Data
JPA - it allows you to create repositories without writing any implementation code!

First, create a new folder/package called `repositories` in the `src/main/java` directory of your project.  In this
folder, we will create a new interface for each model type that we want to store in the database.  The interface should
extend the `JpaRepository` interface and specify the model type and the type of the primary key as type parameters.

Let's look at an example of a repository for the `User` class:

```java
public interface UserRepository extends JpaRepository<User, Integer> {
}
```

And that's it.  We do not need to provide any body for this interface.  Spring Data JPA will automatically generate an
appropriate implementation for this interface at runtime.

### Check For Understanding

1. **Question:**  What is a repository interface?
    - **Answer:** 
        - An interface that extends the `JpaRepository` interface provided by Spring Data JPA.
2. **Question:** What is the purpose of a repository interface?
    - **Answer:** 
        - To provide methods for performing CRUD operations on the model class.

## Using the Repository in a Controller

To use the repository in a controller, we will take advantage of Spring's dependency injection feature.  There are
two ways to inject a repository into a controller:

- Define a constructor on the controller class that takes the repository as a parameter, and then sets a field in the
    class to the value of the constructor parameter.
- Use the `@Autowired` annotation on a field in the controller class.

### Constructor Injection

Here is an example of a controller class that uses constructor injection to inject the `UserRepository` into the
controller:

```java
@RestController
public class UserController {
    private final UserRepository userRepository;

    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // controller methods
    // ...
}
```

In this example, the `UserController` class has a constructor that takes a `UserRepository` as a parameter.  When
Spring creates an instance of the `UserController` class, it will automatically create the repository and pass it to
the constructor.

### Field Injection (Autowired)

Alternatively, you can use the `@Autowired` annotation on a field in the controller class to inject the repository:

```java
@RestController
public class UserController {
    @Autowired
    private UserRepository userRepository;

    // controller methods
    // ...
}
```

In this example, the `UserController` class has a field annotated with `@Autowired`.  When Spring creates an instance of
the `UserController` class, it will automatically inject the repository directly into the field.

### Using the Repository in Controller Methods

Either way, once you have injected the repository into the controller, you can use it in the controller methods to
add, update, delete, and retrieve entities from the database.  The repository provides methods for performing CRUD
operations on the model, such as `save`, `findById`, `findAll`, `delete`, etc.

Here is an example of a controller method that uses the repository to retrieve all users from the database:

```java
@GetMapping("/users")
public List<User> getUsers() {
    return userRepository.findAll();
}
```

In this example, the `getUsers` method uses the `findAll` method provided by the repository to retrieve all users from
the database.  Since this method has a return type of `List<User>`, it will return a list of all users in the database
to the client in JSON format.

If you type this into your controller class, you'll see the available methods that you can use with the repository
when you type `userRepository.`.  There are methods for saving, updating, deleting, and retrieving entities from the
database.  These methods automatically take care of generating the appropriate SQL queries to interact with the
database and mapping the results to the model objects for you.  This is the power of Spring Data JPA.  You can
focus on treating your data as Java objects and let Spring Data JPA take care of the rest.

### Check For Understanding

1. **Question:**  What are two ways to inject a repository into a controller?
    - **Answer:** 
        - Define a constructor on the controller class that takes the repository as a parameter.
        - Use the `@Autowired` annotation on a field in the controller class.

## A Completed CRUD Controller

We have created a model class, annotated it for storage in the database, created a repository interface for the model,
and used the repository in a controller to provide access to read the data from the database.  We can now add methods to
the controller to perform the other CRUD operations on the model type.

CRUD stands for Create, Read, Update, and Delete.  These are the basic operations that you can perform on a database.

- Create: Add a new instance of the model class to the database.
- Read: Retrieve an instance of the model class from the database.
- Update: Update a stored instance of the model class in the database.
- Delete: Remove a stored instance of the model class from the database.

To this point, we've used the `@GetMapping` annotation to retrieve all users from the database.  Conventionally, we use
other mapping attributes that correspond to other HTTP methods to perform the other CRUD operations:

| HTTP Method | Mapping Attribute | CRUD Operation | SQL Verb | Description | Repository Method(s) |
|-------------|-------------------|----------------|----------|-------------|-------------------|
| GET         | @GetMapping        | Read           | SELECT   | Retrieve data | findAll, findById |
| POST        | @PostMapping       | Create         | INSERT   | Add new data | save |
| PUT         | @PutMapping        | Update         | UPDATE   | Modify existing data | save |
| DELETE      | @DeleteMapping     | Delete         | DELETE   | Remove data | delete |

This may seem like a lot of different names for the same thing.  The reason for this is largely historical.  SQL came
first and had its own names for these four common data operations.  Later, when the web was invented, the HTTP protocol
was created and had its own names for these operations.  Academically, the CRUD names are used to describe the same
operations in a manner that is independent of the technology being used.

Once you understand the mapping between these many ways of describing the same operations, it becomes easier to
understand how to use Spring Boot to create a RESTful API that performs CRUD operations on a database.

To create all of these methods on our controller, we'll also need to understand some parameter annotations that Spring
Boot provides to help us map the different parts of an HTTP request to the appropriate method parameters.  First, a
refresher on the various parts of an HTTP request that can contain data that we might want map onto method parameters
and use in our controller methods:

| Part of Request | Description | Example | Spring Boot Annotation |
|-----------------|-------------|---------|------------------------|
| Path Variable   | Part of the URL that contains data | /users/**1** | @PathVariable |
| Request Parameter | Data sent as query parameters in the URL | /users?**sort=asc** | @RequestParam |
| Request Body    | JSON Data sent in the body of the request | **{ "firstName": "John", "lastName": "Doe" }** | @RequestBody |

Notice that while the path variable and request parameter are part of the URL and can only carry a single simple value,
the request body can carry a complex object with multiple fields by encoding it in JSON format.  With the appropriate
annotations, Spring Boot can map these parts of the request to method parameters in our controller methods and 
automatically read and convert the data from the request into the appropriate Java objects and pass them to our
controller methods.

Let's look at how we use each of these annotations in the context of a CRUD controller for the `User` type.

### Read Operations

As per the table above, for read operations, we use the `@GetMapping` annotation and the `findAll` and `findById`
methods provided by the repository.

We've already seen how to use the `@GetMapping` annotation to make a method to retrieve all users from the database:

```java
@GetMapping("/users")
public List<User> getUsers() {
    return userRepository.findAll();
}
```

We can also use the `@GetMapping` annotation with a path variable to define a method to retrieve a specific user from
the database. In this case, the client can specify the id of the user they want to retrieve in the URL
(e.g. `/users/42` to retrieve the user with id 42):

```java
@GetMapping("/users/{id}")
public User getUser(@PathVariable int id) {
    return userRepository.findById(id).orElse(null);
}
```

Notice here that the `@GetMapping` annotation contains a path where part of the URL is enclosed in curly braces.  This
part of the URL is called a path variable.  The `@PathVariable` annotation is used to map the path variable to a method
parameter.  In this case, the `id` path variable is mapped to the `id` method parameter.  Spring Boot matches the name
that we use in the `@PathVariable` annotation to the name of the path variable in the URL and automatically maps the
value of the path variable to the method parameter.

You may also notice that after `findById`, we need to chain a call to `orElse(null)`.  This is because `findById` actually
returns the album wrapped in a special type called `Optional`.  This class wraps a type in a container that may be null.
Since we are fine with just unwrapping the result and returning `null` if it's empty, we can just call `orElse(null)`.

### Create Operation

For the create operation, we use the `@PostMapping` annotation and the `save` method provided by the repository.  Since
we are creating a whole new entity that is an instance of a complex object, we'll expect the client to send the data in
the request body in JSON format.  We can use the `@RequestBody` annotation to map the request body to a method parameter
in our controller method:

```java
@PostMapping("/users")
public User createUser(@RequestBody User user) {
    return userRepository.save(user);
}
```

### Update Operation

For the update operation, we use the `@PutMapping` annotation and the `save` method provided by the repository. Much
like the create operation, we'll expect the client to send the data in the request body in JSON format.

We also conveniently have the id of the user we want to update in the URL.  This may seem redundant, but it is a
convention in RESTful APIs to include the id of the object that you want to update in the URL of a PUT request even though
it is also included in a field in the request body.  The reason for this is that with REST, the URL should always
identify the data that we are operating on.  This means that any operation that pertains to one record instead of the
entire set should always include the id of the item in the url.

With that said, here is an example of a method to update a user in the database:

```java
@PutMapping("/users/{id}")
public User updateUser(@PathVariable int id, @RequestBody User user) {
    user.setId(id);
    return userRepository.save(user);
}
```
Notice here that we have two method parameters: `id` and `user`.  The `id` parameter is mapped to the path variable in
the URL, and the `user` parameter is mapped to the request body as explained above.

There is also a line of code that sets the id of the user object to the id that is passed in the URL.  This is necessary
to ensure that the id of the user object matches the id in the URL.  The id in the URL is the authoritative source for
the id of the user that we want to update, so we overwrite the id in the user object with the id from the URL to ensure
that they match.

### Delete Operation

For the delete operation, we use the `@DeleteMapping` annotation and the `deleteById` method provided by the repository.
We also have the id of the user we want to delete in the URL, so we can use the `@PathVariable` annotation to map the id
to a method parameter.  There is no need to use the `@RequestBody` annotation in this case because we don't need any
data or copy of the user object to delete it, we only need the id:

```java
@DeleteMapping("/users/{id}")
public void deleteUser(@PathVariable int id) {
    userRepository.deleteById(id);
}
```

### Putting it all together

Here is a completed CRUD controller for the `User` model class:

```java
import org.springframework.web.bind.annotation.*;
import java.util.List;


@RestController
public class UserController {
    private final UserRepository userRepository;

    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/users")
    public List<User> getUsers() {
        return userRepository.findAll();
    }

    @GetMapping("/users/{id}")
    public User getUser(@PathVariable int id) {
        return userRepository.findById(id).orElse(null);
    }

    @PostMapping("/users")
    public User createUser(@RequestBody User user) {
        return userRepository.save(user);
    }

    @PutMapping("/users/{id}")
    public User updateUser(@PathVariable int id, @RequestBody User user) {
        user.setId(id);
        return userRepository.save(user);
    }

    @DeleteMapping("/users/{id}")
    public void deleteUser(@PathVariable int id) {
        userRepository.deleteById(id);
    }
}
```

The five methods in this controller are the typical methods that you would include in a CRUD controller:

- `getAll` to retrieve all of the entities from the database.
- `get` to retrieve a specific object from the database.
- `create` to add a new object to the database.
- `update` to update an object in the database.
- `delete` to remove an object from the database.

While these are the typical methods that you would include in a CRUD controller, you can also add additional methods to
perform other operations on the object as needed, for example, to search for entities that match certain criteria or to
perform other operations that are specific to your application.  You may also choose to remove some of these methods if
they are not needed in your application.  For example, some applications may not allow users to delete entities.

### Check For Understanding

1. **Question:** What annotation do you use to map a path variable in the URL to a method parameter?
    - **Answer:** @PathVariable
2. **Question:** What annotation do you use to map the request body to a method parameter?
    - **Answer:** @RequestBody
3. **Question:** What annotation do you use to map a request parameter in the URL to a method parameter?
    - **Answer:** @RequestParam
4. **Question:** Why do we include the id of the object we want to update in the URL of a PUT request?
    - **Answer:** Because the URL should always identify the data that we are operating on even if it is also included
        in the request body.
5. **Question:** What extra step needs to be taken in the update method other than saving the user object?
    - **Answer:** The id of the user object must be set to the id in the URL to ensure that they match.
6. **Question** What are the 5 methods typically included in a CRUD controller?
    - **Answer:** getAll, get, create, update, delete

## Practice/Project Task

- Activity Description: GitHub Project
- Prompt: Fork the [Spring Boot 2](https://github.com/LaunchCodeEducation/software-dev-course-spring-boot-2) project
    from github into your own account, clone it to your local machine, and complete the exercises as describe in the
    `README.md` file.  When you are finished, commit and push your changes to your
forked repository.
- Format (individual, pair programming, presentation, group discussion, etc.): Individual
- Tools:  Git, GitHub, JetBrains IntelliJ IDEA
- Time Estimate: 90 minutes
- Expected Outcomes: 
    - **Green**: All exercises are completed
    - **Yellow**: Some exercises are incomplete
    - **Red**: The code is missing or unbuildable, and shows a lack of understanding of the concepts covered in this
    lesson.

## Conclusion

In this lesson, we learned how to add Spring Data JPA to a Spring Boot application, and to integrate it with our
existing Spring Boot Web application.  We learned how to annotate our model classes for storage in the database, and
how to create a repository interface for each model class.  We also learned how to use the repository in a controller
to provide RESTful APIs for performing CRUD operations on each of our model classes.

Managing and persisting data is the primary purpose of our entire java web application.  Now that we have a solid
understanding of how to use Spring Data JPA to store and retrieve data from a database, we have a complete picture of
how to build a complete backend for our full stack web application.

