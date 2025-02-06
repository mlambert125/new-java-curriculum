+++
title = "Oop 2"
type = "chapter"
weight = 100
+++

## Competency and Learning Objectives

### Competency:

Object Oriented Programming

### Learning Objectives:

- I can use method overloading in java to make versions of a method that accept different quantities/types of
    parameters
- I can implement static methods/members to provide non-instance-specific methods and properties.

## Introduction


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


