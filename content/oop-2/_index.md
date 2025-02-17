+++
title = "Oop 2"
type = "chapter"
weight = 100
+++

## Competency and Learning Objectives

### Competency:

Object Oriented Programming

### Learning Objectives:

- I can use method overloading and static methods in java to make more flexible and powerful classes.

## Introduction

In this lesson, we will learn how to use method overloading and static methods and members in Java to create more
flexible and powerful classes.  Method overloading allows us to define multiple methods with the same name but
different numbers or types of parameters, while static methods and members provide non-instance-specific methods and
properties that belong to the class itself rather than individual instances of the class.

## The `Person` Class

Throughout this lesson, we will be working with a `Person` class that represents a person with a name, age, and address:

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
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return this.age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void greet() {
        System.out.println("Hello, my name is " + this.name + " and I am " + this.age + " years old.");
    }

    public int calculateAgeInMonths() {
        return this.age * 12;
    }
}
```

### Check For Understanding

1. **Question:** What is the purpose of the `Person` class?
    - **Answer:** The `Person` class represents a person with a name, age, and address.
2. **Question:** Why are the fields in the `Person` class private?
    - **Answer:** The fields in the `Person` class are private to encapsulate the internal state of the object and
    prevent direct access from outside the class.

## Method Overloading

Remember that when we created constructors in the `Person` class, we were able to define multiple constructors as long 
as they had different numbers or types of parameters.  This is called method overloading, and we can use it with any
method in a class, not just constructors.  For example, we could add a `calculateAgeInMonths` method that takes a
parameter for the number of months in a year and returns the person's age in months based on that number:

```java
public class Person {
    ...
    // (All the fields, constructors, getters, setters, greet, and calculateAgeInMonths methods from above, omitted for brevity)

    public int calculateAgeInMonths() {
        return this.age * 12;
    }

    public int calculateAgeInMonths(int monthsInYear) {
        return this.age * monthsInYear;
    }
}
```

Java will automatically choose the correct method based on the number and types of parameters we pass to it.  For
example, if we call `calculateAgeInMonths` with no parameters, java will call the first version of the method that
calculates the person's age in months based on 12 months in a year.  If we call `calculateAgeInMonths` with an
`int` parameter, java will call the second version of the method that calculates the person's age in months based on
the number of months in a year that we pass to it.

### Check For Understanding

1. **Question:** What is method overloading?
    - **Answer:** Method overloading is the ability to define multiple methods with the same name but different
    numbers or types of parameters.
2. **Question:** How does Java determine which overloaded method to call?
    - **Answer:** Java determines which overloaded method to call based on the number and types of parameters passed.

## Static Methods and Members

So far, all the methods and fields we have defined in the `Person` class are instance-specific, meaning they belong to
individual instances of the `Person` class.  However, we can also define static methods and members that belong to the
class itself rather than individual instances of the class.  Static methods and members are shared among all instances
of the class and can be accessed without creating an instance of the class.

For example, we could add a static method to the `Person` class that compares the ages of two people and returns the
older person:

```java
public class Person {
    ...
    // (All the fields, constructors, getters, setters, greet, calculateAgeInMonths, and calculateAgeInMonths(int) methods from above, omitted for brevity)

    public static Person getOlderPerson(Person person1, Person person2) {
        if (person1.getAge() > person2.getAge()) {
            return person1;
        } else {
            return person2;
        }
    }
}
```

We can call the `getOlderPerson` method directly on the `Person` class, passing two `Person` objects as parameters, 
and it will return the older person passed to it.

```java
Person person1 = new Person("Alice", 30, "123 Main St");
Person person2 = new Person("Bob", 25, "456 Elm St");

Person olderPerson = Person.getOlderPerson(person1, person2);
System.out.println("The older person is: " + olderPerson.getName());
```

> [!NOTE] Java Objects are passed by reference
> In the example above, the `getOlderPerson` method takes in two `Person` objects as parameters and returns the older
> person.  Throughout this process, we are not copying the `Person` objects, but rather passing references to the
> objects themselves.  `olderPerson` is a reference to the same object as `person1` in this case, and if we were
> to modify `olderPerson`, we would also be modifying `person1` as they both point to the same object in memory.

Another common use of static methods is to provide utility methods that are not specific to any instance of the class.
For example, we could add a static method to the `Person` class that generates a random name:

```java
public class Person {
    ...
    // (All the fields, constructors, getters, setters, greet, calculateAgeInMonths, calculateAgeInMonths(int), and getOlderPerson methods from above, omitted for brevity)

    public static String generateRandomName() {
        String[] names = {"Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Hank", "Ivy", "Jack"};
        int randomIndex = (int) (Math.random() * names.length);
        return names[randomIndex];
    }
}
```

As before, we could call this form Main or elsewhere by calling `Person.generateRandomName()`:

```java
String randomName = Person.generateRandomName();
System.out.println("Random name: " + randomName);
```

Notice that no instance of the `Person` class is created to call the `generateRandomName` method.  We can call it
directly on the `Person` class itself because it is a static method.

### Check For Understanding

1. **Question:** What is a static method?
    - **Answer:** A static method is a method that belongs to the class itself rather than individual instances of the
    class and can be accessed without creating an instance of the class.
2. **Question:** How do you call a static method?
    - **Answer:** You call a static method directly on the class itself, rather than on an instance of the class.
3. **Question:** What is pass-by-reference?
    - **Answer:** Pass-by-reference is a way of passing arguments to a method by passing references to the actual
    objects rather than copying the objects themselves.

## Reflection Task

- Prompt: Reflect on the use of method overloading and static methods in the `Person` class.  Come up with a few
    additional examples of both method overloading and static methods that could be useful in the `Person` class.
- Expected Outcomes: 
    - **Green**: Student can provide multiple examples of method overloading and static methods that are relevant to
        the `Person` class.
    - **Yellow**: Student understands some of the concepts but struggles to come up with multiple examples.
    - **Red**: Student has difficulty understanding the concepts of method overloading and static methods.

## Practice/Project Task

- Activity Description: GitHub Project
- Prompt: Fork the [OOP 2](https://github.com/LaunchCodeEducation/software-dev-course-oop-2) project from github into
your own account, clone it to your local machine, and complete the exercises as describe in
the README.md file.  When you are finished, commit and push your changes to your forked repository.
- Format (individual, pair programming, presentation, group discussion, etc.): Individual
- Tools:  Git, GitHub, JetBrains IntelliJ IDEA
- Time Estimate: 1 hour
- Expected Outcomes: 
    - **Green**: All exercises are completed and the unit tests all pass.
    - **Yellow**: Some exercises are incomplete or some of the unit tests do not pass, but the code builds and is 
    generally correct or on the right track.
    - **Red**: The code is missing or unbuildable, and shows a lack of understanding of the concepts covered in this
    lesson.

## Conclusion

In this lesson, we learned how to use method overloading and static methods and members in Java to create more flexible
and powerful classes.  Method overloading allows us to define multiple methods with the same name but different numbers
or types of parameters, while static methods and members provide non-instance-specific methods and properties that
belong to the class itself rather than individual instances of the class.  By using these features, we can create more
versatile and reusable classes that can be adapted to a wide variety of situations.

With this knowledge, we have a complete understanding of classes other than inheritance and polymorphism.  We can now
create classes that are more flexible and powerful by using method overloading and static methods and members.  In the
next lesson, we will learn about inheritance and polymorphism, which will allow us to create more complex classes.

