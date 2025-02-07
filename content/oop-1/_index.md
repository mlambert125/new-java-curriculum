+++
title = "Oop 1"
type = "chapter"
weight = 90
+++

## Competency and Learning Objectives

### Competency:

Object Oriented Programming

### Learning Objectives:

- I can design and implement a basic class in java and use it in a java application.

## Introduction

Classes are the fundamental building blocks in an object-oriented programming language like java, and they are the
primary mechanism that will allow the simple programs you have been writing to grow into more complex, powerful
programs. In this lesson, we will learn how to create classes using all of the features offered by the Java language.

## Person Class

In this chapter, we're going to start with a simple Data Class representing a person.  This class will have three
fields: `name`, `age`, and `address`.  We will expand on this class throughout this lesson to demonstrate some of
the key concepts of Object Oriented Programming (OOP).

```java
public class Person {
    public String name;
    public int age;
    public String address;
}
```

We will also be working with a `Main` class that will contain the `main` method as usual.  In the `Main` class, we will
create instances of the `Person` class and demonstrate how to access the fields of the `Person` class.

```java
public class Main {
    public static void main(String[] args) {
        Person alice = new Person();
        alice.name = "Alice";
        alice.age = 30;
        alice.address = "123 Main St.";

        Person bob = new Person();
        bob.name = "Bob";
        bob.age = 40;
        bob.address = "456 Elm St.";
    }
}
```

## Constructors

If you look at the code above, it's a bit cumbersome to create a new `Person`
object and then set the `name`, `age`, and `address` fields separately.  It
would be nice if we could create a new `Person` object and set the `name`,
`age`, and `address` fields all at once. 

We can do this by adding a constructor to the `Person` class.  A constructor is
a special method that is called when a new object is created.  It has the same
name as the class and no return type. Here is how we can add a constructor to
the `Person` class:

```java
public class Person {
    public String name;
    public int age;
    public String address;

    public Person(String name, int age, String address) {
        this.name = name;
        this.age = age;
        this.address = address;
    }
}
```

The `this` keyword is used to refer to the current object.  In this case, it is used to distinguish between the
`name`, `age`, and `address` fields of the `Person` class and the `name`, `age`, and `address` parameters of the
constructor.

Now that we have added a constructor to the `Person` class, we must pass parameters to the constructor through the
`new` keyword when we create a new `Person` object.  Here is how we can create our new `Person` objects using the
constructor (in the `Main` class):

```java
...
Person alice = new Person("Alice", 30, "123 Main St.");
Person bob = new Person("Bob", 40, "456 Elm St.");
...
```

Notice that we can no longer call the default constructor with no parameters because we have defined a constructor
that takes three parameters.  If we want to be able to create a `Person` object with no parameters, while keeping
this new option to create a `Person` object with three parameters, we can define two constructors in the `Person`
class.

```java
public class Person {
    public String name;
    public int age;
    public String address;

    public Person() {
    }

    public Person(String name, int age, String address) {
        this.name = name;
        this.age = age;
        this.address = address;
    }
}
```

Our constructor that takes no parameters has no code in it, but it is required when we start adding constructors to
let java know that we still want to be able to create a `Person` object with no parameters.  We can now create a
`Person` object with no parameters or with three parameters.

```java
...
Person alice = new Person("Alice", 30, "123 Main St.");
Person bob = new Person("Bob", 40, "456 Elm St.");
Person charlie = new Person(); 
// TODO: Set the name, age, and address fields of the charlie object
...
```

We can define as many constructors as we want in a class, as long as they have different numbers or types of
parameters.  Java will automatically choose the correct constructor based on the parameters we pass to the `new 
Person()` call.

### Check For Understanding

1. **Question:** What is a Constructor?
    - **Answer:** A constructor is a special method that is called when a new object is created.  It has the same name
        as the class and no return type.
2. **Question:** Why might we want to define multiple constructors in a class?
    - **Answer:** We might want to define multiple constructors in a class to allow for different ways of creating
        objects of that class.  For example, we might want to allow for creating objects with different numbers or
        types of parameters.

## Protecting Fields with Getters and Setters

In the `Person` class, we have made the `name`, `age`, and `address` fields public.  This means that any code in our
program can access and modify these fields directly.  A better practice is to make the fields private and provide
public methods called getters and setters to access and modify the fields.  This is called encapsulation and is a
fundamental principle of object-oriented programming.  Here is how we can modify the `Person` class to use getters
and setters:

```java
public class Person {
    private String name;
    private int age;
    private String address;

    public Person(String name, int age, String address) {
        this.name = name;
        this.age = age;
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
```

Now, the `name`, `age`, and `address` fields are private, and we can only access and modify them through the `getName`,
`setName`, `getAge`, `setAge`, `getAddress`, and `setAddress` methods.  This allows us to control how the fields are
accessed and modified and to add validation logic if necessary.

Let's update our `Main` class to use the getters and setters:

```java
...
Person alice = new Person("Alice", 30, "123 Main St.");
Person bob = new Person("Bob", 40, "456 Elm St.");

System.out.println("Name: " + alice.getName());
System.out.println("Age: " + alice.getAge());
System.out.println("Address: " + alice.getAddress());

// Change Alice's name
alice.setName("Alice Smith");

System.out.println("New Name: " + alice.getName());
...
```

With proper constructors and our fields protected by getters and setters, we have a robust `Person` class that can be
used to safely model people in our program.  

At this point, we have a properly encapsulated data class that represents a person.  This kind of class is often
called a "Data Class" or a "POJO" (Plain Old Java Object).  A POJO is not a formal Java langauge construct, but it is
a common term used to describe a simple class that contains only fields, constrctors, and getters and setters for 
those fields.

### Check For Understanding

1. **Question:** What do we call the idea of making fields private and providing public methods to access and modify
    them?
    - **Answer:** Encapsulation
2. **Question:** What is a name for a simple class that contains only fields, constructors, and getters and setters?
    - **Answer:** POJO (Plain Old Java Object) or "Data Class"

## Adding Methods to the Person Class

Now that we have learned how to create simple data classes, let's move on to more complex classes that include
methods beyond the getters/setters explained above. 

First, look back at the getter and setter methods we created in the `Person` class.  Notice that these methods do
not have the `static` keyword in front of them.  This means that they are instance methods.  Instance methods are
methods that are called on an instance of a class (an object) and can access and modify the fields of that object.

So, for example, when we call `alice.getName()` in the `Main` class, we are calling the `getName` method on the `alice`
object.  The `getName` method is then able to access the `name` field of the `alice` object and return it.  If we 
call the same method on the `bob` object, it will return the `name` field of the `bob` object.

Just as we added public getter/setter methods to the `Person` class, we can add other public methods to the class
that perform various operations on the `Person` object.  For example, we could add a `greet` method that prints a
greeting to the console:

```java
public class Person {
    ...
    // (All the fields, constructors, getters, and setters from above, omitted for brevity)

    public void greet() {
        System.out.println("Hello, my name is " + this.name + "!");
    }
}
```

> [!NOTE] Private Field Access From Instance Methods
> Notice that in the `greet` method, we use the `this` keyword to refer to the current object, and that we can directly
> access the `name` field even though it is private because the `greet` method is an instance method of the `Person`
> class.  Since we are within the `Person` class, we can access the private fields of the `Person` class directly.

Now, we can call the `greet` method on a `Person` object like this:

```java
...
Person alice = new Person("Alice", 30, "123 Main St.");
alice.greet();
...
```

As with static methods, we can pass parameters to instance methods and return values from them.  For example, we could
add a `calculateAgeInMonths` method to the `Person` class that calculates the person's age in months:

```java
public class Person {
    ...
    // (All the fields, constructors, getters, setters, and greet method from above, omitted for brevity)

    public int calculateAgeInMonths() {
        return this.age * 12;
    }
}
```

And we can call the `calculateAgeInMonths` method on a `Person` object like this:

```java
...
Person alice = new Person("Alice", 30, "123 Main St.");
System.out.println("Alice's age in Months: " + alice.calculateAgeInMonths());
...
```

### Check For Understanding

1. **Question:** What is an Instance Method and how is it different from a Static Method?
    - **Answer:** An instance method is a method that is called on an instance of a class (an object) and can access
        and modify the fields of that object.  It is different from a static method in that it is called on an object
        rather than on the class itself.

## Private Methods

In addition to public instance methods, we can also define private instance methods in a class.  Private methods are
methods that can only be called from within the class itself.  They are useful for breaking up complex methods into
smaller, more manageable pieces.  For example, we could add a private `calculateAgeInDays` method to the `Person`
class that calculates the person's age in days:

```java
public class Person {
    ...
    // (All the fields, constructors, getters, setters, greet, calculateAgeInMonths, and calculateAgeInMonths methods from above, omitted for brevity)

    private int calculateAgeInDays() {
        return this.age * 365;
    }
}
```

Now, we can call the `calculateAgeInDays` method from within the `calculateAgeInMonths` method:

```java
public class Person {
    ...
    // (All the fields, constructors, getters, setters, greet, calculateAgeInMonths, and calculateAgeInMonths methods from above, omitted for brevity)

    private int calculateAgeInDays() {
        return this.age * 365;
    }

    public int calculateAgeInMonths() {
        return calculateAgeInDays() / 30;
    }

    public int calculateAgeInMonths(int monthsInYear) {
        return calculateAgeInDays() / monthsInYear;
    }
}
```

The `calculateAgeInDays` method is now a helper method that is used by the `calculateAgeInMonths` and 
`calculateAgeInMonths` methods to calculate the person's age in days.  It is private, so it cannot be called from
outside the `Person` class (e.g., from the `Main` class).


### Check For Understanding

3. **Question:** What is a Private Method?
    - **Answer:** A private method is a method that can only be called from within the class itself.  It
        is useful for breaking up complex methods into smaller, more manageable pieces.


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

- Prompt: Discuss and plan a set of classes that could be used to model a simple banking system.  What fields and
  methods would each class have?  How would the classes interact with each other?
- Format (individual, pair programming, presentation, group discussion, etc.):  Group Discussion
- Tools:  Whiteboard

## Conclusion

In this lesson, we learned how to create classes in Java using all of the features offered by the Java language.

With classes, we can model complex data structures and group behavior on those data structures with the data itself.
This is called Object-Oriented Programming (OOP), and it is a powerful paradigm that allows us to write concise and
well-organized code to solve complex problems.

