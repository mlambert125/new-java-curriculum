+++
title = "Classes and Objects 2"
type = "chapter"
weight = 80
+++

## Competency and Learning Objectives

### Competency:

Classes and Objects

### Learning Objectives:

- I can create a basic data class in java
- I can create constructors
- I can write a more complex class in java that includes methods
- I can use method overloading in java to make versions of a method that accept different quantities/types of parameters

## Introduction

Classes are the fundamental building blocks in an object-oriented programming language like java, and they are the
primary mechanism that will allow the simple programs you have been writing to grow into more complex, powerful
programs. In this lesson, we will learn how to create classes and objects to model complex data and behavior in java.

This chapter assumes that you have a basic understanding of how to write simple programs in java and that you can
use static methods to break up your code into smaller, more manageable pieces, and that you have a comprehensive
understanding of parameters and return values.

## Data Classes

Classes let us model and solve many problems, but we will start first with the most fundamental problem - creating
composite data types. A composite data type is a type that is made up of other types. For example, a `Person` is a
composite data type because it is made up of a `String` for the name, an `int` for the age, and a `String` for the
address.

### Simple Data Classes

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

### Adding Constructors

Let's return to our simple `Person` class with the `String name`, `int age`, and `String address` fields.  If you
look at the code above, it's a bit cumbersome to create a new `Person` object and then set the `name`, `age`, and
`address` fields separately.  It would be nice if we could create a new `Person` object and set the `name`, `age`,
and `address` fields all at once.  We can do this by adding a constructor to the `Person` class.  A constructor is a
special method that is called when a new object is created.  It has the same name as the class and no return type.
Here is how we can add a constructor to the `Person` class:

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

### Protecting Field Access with Getters and Setters

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
used to safely model people in our program.  This kind of class whose purpose is to hold a set of related fields and
provide getters and setters for those fields is called a often data class.

> [!NOTE]
> "Data Class" is a term used among software developers to describe a simple class.  It is not a formal term in the
> java language, and java does not have a special construct or rules for creating data classes.  It is just a
> convenient term to describe a class that holds a set of related fields and provides getters and setters for those
> fields.

### Check For Understanding

1. **Question:** What is a Composite Data Type?
    - **Answer:** A composite data type is a type that is made up of other types.
2. **Question:** What is the purpose of a Constructor?
    - **Answer:** A constructor is a special method that is called when a new object is created.  It is used to
        initialize the object's members directly from the `new` parameters.
3. **Question:**  What is a Data Class?
    - **Answer:** A data class is a class that holds a set of related fields and provides getters and setters for those
      fields.

## Full Java Classes

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

### Method Overloading

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

### Private Methods

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

1. **Question:** What is an Instance Method and how is it different from a Static Method?
    - **Answer:** An instance method is a method that is called on an instance of a class (an object) and can access
        and modify the fields of that object.  It is different from a static method in that it is called on an object
        rather than on the class itself.
2. **Question:** What is Method Overloading?
    - **Answer:** Method overloading is the ability to define multiple methods with the same name but different
        numbers or types of parameters.
3. **Question:** What is a Private Method?
    - **Answer:** A private method is a method that can only be called from within the class itself.  It
        is useful for breaking up complex methods into smaller, more manageable pieces.

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

In this lesson, we learned how to create classes and objects in java to model complex data and behavior.  We learned
how to create simple data classes with fields, constructors, getters, and setters, and how to create more complex
classes with methods that perform operations on the class's fields.  We learned about method overloading and how to
define multiple methods with the same name but different numbers or types of parameters.  We also learned about
private methods.

In the next lesson, we will learn about a powerful feature that lets us define similar classes in a hierarchy called
inheritance.

