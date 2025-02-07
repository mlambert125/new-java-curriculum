+++
title = "Classes and Objects 2"
type = "chapter"
weight = 80
+++

## Competency and Learning Objectives

### Competency:

Classes and Objects

### Learning Objectives:

- I can write basic classes in java to model composite data types.

## Introduction

Classes are the fundamental building blocks in an object-oriented programming language like java, and they are the
primary mechanism that will allow the simple programs you have been writing to grow into more complex, powerful
programs. In this lesson, we will learn how to create basic classes.

## Data Classes

Classes let us model and solve many problems, but we will start first with the most fundamental problem - creating
composite data types. A composite data type is a type that is made up of other types. For example, a `Person` is a
composite data type because it is made up of a `String` for the name, an `int` for the age, and a `String` for the
address.

### Simple Public Data Classes

In java, we create a new file for each class we want to define. The file should have the same name as the class, and
the class should be defined in the file. For example, if we want to create a class called `Person`, we would create
a file called `Person.java` by right-clicking on the `src` folder in the project explorer, selecting `New`, and then
`Class`. We would then type `Person` in the `Name` field and click `Finish`.  This will create a new file called
`Person.java` with the following contents:

```java
public class Person {
}
```

This is the simplest class we can create in java. It has no fields, no methods, and no constructors. Let's add three
public fields to the `Person` class to represent the name, age, and address of a person:

```java
public class Person {
    public String name;
    public int age;
    public String address;
}
```

This class is now a composite data type that can be used to represent a person. We can create a new `Person` object
in our `Main` class like this:

```java
public class Main {
    public static void main(String[] args) {
        Person person = new Person();
        person.name = "Alice";
        person.age = 30;
        person.address = "123 Main St.";

        System.out.println("Name: " + person.name);
        System.out.println("Age: " + person.age);
        System.out.println("Address: " + person.address);
    }
}
```

Notice that we use the `new` keyword to create a new `Person` object, and we use the `.` operator to access the
fields of the `Person` object.  This is a bit different from the way we have been using variables to this point with
primitive types and strings.  With primitive types and strings, we can create a variable and then just assign a
literal value like `10` or `"hello"` to the variable.  With objects, we have to create a new object with the `new`
keyword and then use the `.` operator to access the fields of the object.

Now that we have our `Person` class, we can create as many `Person` objects as we want.  We can even make a list of
`Person` objects like this:

```java
...
// Make Alice
Person alice = new Person();
alice.name = "Alice";
alice.age = 30;
alice.address = "123 Main St.";

// Make Bob
Person bob = new Person();
bob.name = "Bob";
bob.age = 40;
bob.address = "456 Elm St.";

// Make a list of people and add Alice and Bob
List<Person> people = new ArrayList<>();
people.add(alice);
people.add(bob);

// Loop through the list of people and print their information
for (Person person : people) {
    System.out.println("Name: " + person.name);
    System.out.println("Age: " + person.age);
    System.out.println("Address: " + person.address);
}
...
```

We can even compose classes within classes. For example, we could replace our `String address` field with a 
more complex `Address` class that has fields for the street, city, state, and zip code.  Again, right-click on the
`src` folder in the project explorer, select `New`, and then `Class`. Type `Address` in the `Name` field and click
`Finish`.  This will create a new file called `Address.java` which we will define as follows: 

```java
public class Address {
    public String street;
    public String city;
    public String state;
    public String zip;
}
```

Now, let's update our `Person` class to use the `Address` class:

```java
public class Person {
    public String name;
    public int age;
    public Address address;
}
```

And update our `Main` class to use the new `Address` class:

```java
...
// Make Alice
Person alice = new Person();
alice.name = "Alice";
alice.age = 30;
alice.address = new Address();
alice.address.street = "123 Main St.";
alice.address.city = "Springfield";
alice.address.state = "IL";
alice.address.zip = "62701";
...
```

> [!NOTE]
> Creating public fields in a class is not a good practice because it breaks encapsulation.  Encapsulation is the
> idea that the internal state of an object should be hidden from the outside world.  Instead of creating public
> fields, we should create private fields and provide public methods to access and modify the fields.  We will
> learn how to do this in the next section.

### Check For Understanding

1. **Question:** What is a Class?
    - **Answer:** A class is a blueprint for creating objects.
2. **Question:** What is a Composite Data Type?
    - **Answer:** A composite data type is a type that is made up of other types.

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

- Prompt: Design a set of data classes to model a game or hobby of your choice.  Include at least one class that
  has a member variable whose type is another class.
- Format (individual, pair programming, presentation, group discussion, etc.):  Group Discussion
- Tools:  Whiteboard

## Conclusion

In this lesson, we learned how to create basic data classes and objects in java to model composite data types.

In the next lesson, we will add constructors, access modifiers and methods to our classes to make them more powerful
and flexible.

