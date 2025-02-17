+++
title = "Classes and Objects 1"
type = "chapter"
weight = 70
+++

## Competency and Learning Objectives

### Competency:

Classes and Objects

### Learning Objectives:

- I can use methods in a java application to break up functionality and solve more complex problems.

## Introduction

The fundamental building blocks in an object-oriented programming language like java are classes and methods.
You have probably already been using one class in your programs, the `Main` class, and you've been writing all
of your code in the `main` method. In this lesson, we will learn how to create our own classes and methods.

## Methods

Methods are blocks of code that perform a specific task. They are defined within a class and can be called from
anywhere in the program. Methods are used to break up a program into smaller, more manageable pieces. This makes
the code easier to read and understand, and it also makes it easier to debug and maintain.

### Simple Methods

Consider the following program:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        for (int i = 0; i < 10; i++) {
            System.out.println(i);
        }
        System.out.println("Hello, World!");
    }
}
```

This program prints "Hello, World!" to the console and then prints the numbers 0 through 9, and then prints "Hello,
World!" again. We can break this program up into two separate methods to make it easier to read:

```java
public class Main {
    public static void main(String[] args) {
        printHelloWorld();
        printNumbers();
        printHelloWorld();
    }

    public static void printHelloWorld() {
        System.out.println("Hello, World!");
    }

    public static void printNumbers() {
        for (int i = 0; i < 10; i++) {
            System.out.println(i);
        }
    }
}
```

All that these simple methods do is block off a section of code that performs a specific task, and gives it a name
that we can call from the `main` method. This makes the code easier to read, and removes some repetition (in this
case, the code to write "Hello, World!" is only written once).

These simple methods start with `public static void`, followed by the name of the method, and then a pair of empty
parentheses. The code that the method runs is enclosed in a pair of curly braces `{}`. The program still runs the
`main` method first, but now the `main` method calls the `printHelloWorld` and `printNumbers` methods to do the
actual work.  Calling these methods from the `main` method is as simple as writing the name of the method followed
by a pair of parentheses.

### Introducing Parameters

Let's say that we want to change this method so that instead of printing "Hello, World!" at both the start and end
of the program, we want to print "Goodbye, World!" at the end. We can do this by adding a **parameter** to the
`printHelloWorld` method that will let us reuse this method to print different messages.  We will also rename
the method to `printMessage` to reflect this change:

```java
...
    public static void printMessage(String message) {
        System.out.println(message);
    }
...
```

Notice that the `printMessage` method now has some text inside the parentheses. This is a **parameter** declaration.
A parameter is a variable that is passed into a method when it is called so that the method can be used with
different values. In this case, the `printMessage` method takes a single parameter, which is a `String` called
`message`. When the `printMessage` method is called, the value of the `message` parameter is set to the value that
is passed in the parentheses.  Let's update the `main` method to use this new `printMessage` method:

```java
...
    public static void main(String[] args) {
        printMessage("Hello, World!");
        printNumbers();
        printMessage("Goodbye, World!");
    }
...
```

In the first call to `printMessage`, the value of the `message` parameter is set to "Hello, World!", and in the
second call, the value of the `message` parameter is set to "Goodbye, World!". This allows us to reuse the same
method to print different messages.

### Returning Values

Methods can also return values. For example, let's say that we want to write a method that adds two numbers
together. We can do this by creating a method that takes two parameters, adds them together, and then **returns** the
result:

```java
...
    public static int add(int a, int b) {
        return a + b;
    }
...
```

A return value is a value that is sent back to the code that called the method.  Previously, all of our methods had
the keyword `void` in the method declaration after `static`.  This means that the method does not return a value.
Now that we want to return a value, we replace `void` with the type of value that we want to return. In this case, we
want to return an `int`, so we replace `void` with `int`. The `return` keyword is then used in the method body to send
a value back to the caller.

> [!NOTE] Return exits the method immediately
> As soon as a `return` statement is executed, the method will exit and the value that is returned will be sent back
> to the caller.  This means that any code that comes after the `return` statement will not be executed.

Let's update the `main` method to use this new `add` method:

```java
...
    public static void main(String[] args) {
        printMessage("Hello, World!");
        printNumbers();
        printMessage("Goodbye, World!");
        int sum = add(5, 7);
        System.out.println("The sum of 5 and 7 is " + sum);
    }
...
```

When a method with a return value is called, it's code executes as before, but it also has the property that the
method call will be replaced with the value that is returned.  In this case, we are assigning the value that is
returned by the `add` method to the variable `sum`, and then printing the value of `sum` to the console.


We can make this even shorter by skipping the variable assignment and putting the call right into the `println`
method call:

```java
...
    public static void main(String[] args) {
        printMessage("Hello, World!");
        printNumbers();
        printMessage("Goodbye, World!");
        System.out.println("The sum of 5 and 7 is " + add(5, 7));
    }
...
```

> [!NOTE]
> This "replace the method call with the return value" behavior is why we can use methods like `scanner.nextInt()`
> in the way that we have.  The `nextInt` method returns an `int`, so we can call it and store it in a variable:

Before we move on, let's take a look at a larger program that prompts a user for two numbers and then adds them,
subtracts them, multiplies them, and divides them:

```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the first number: ");
        int a = scanner.nextInt();
        System.out.print("Enter the second number: ");
        int b = scanner.nextInt();
        System.out.println("The sum is " + add(a, b));
        System.out.println("The difference is " + subtract(a, b));
        System.out.println("The product is " + multiply(a, b));
        System.out.println("The quotient is " + divide(a, b));
    }

    public static int add(int a, int b) {
        return a + b;
    }

    public static int subtract(int a, int b) {
        return a - b;
    }

    public static int multiply(int a, int b) {
        return a * b;
    }

    public static int divide(int a, int b) {
        return a / b;
    }
}
```

> [!NOTE] Multiple Parameters
> Notice that we can have a method take multiple parameters.

> [!NOTE] One Return Value
> We can only return one value from a method.  If we need to return multiple values, we have to use
> classes, which we will learn about in the next section.

### Check For Understanding

1. **Question:** What is a "return value"?
    - **Answer:** A return value is a value that is sent back to the code that called the method.
2. **Question:** What are the benefits of using methods?
    - **Answer:** Methods allow us to break up a program into smaller, more manageable pieces, which makes the code
      easier to read, understand, debug, and maintain.  They also allow us to avoid repeating the same code multiple
      times.

## Reflection Task

- Prompt: Consider a program or piece of code that you wrote in previous lessons before learning about methods. How
  would you break that program up into methods? What methods would you create, and what parameters would they take?
- Expected Outcomes: 
    - **Green**: The student is able to identify the different parts of the program that can be broken up into
      separate methods, and is able to create methods that take the appropriate parameters.
    - **Yellow**: The student is able to identify some parts of the program that can be broken up into separate
      methods, but has trouble creating methods that take the appropriate parameters, or only uses `void` methods
      with no parameters.
    - **Red**: The student does not understand the concept of methods well enough to integrate them into
      their existing code.

## Practice/Project Task

- Activity Description: GitHub Project
- Prompt: Fork the [Java Classes and Objects 1](https://github.com/LaunchCodeEducation/software-dev-course-classes-and-objects-1)
project from github into your own account, clone it to your local machine, and complete the exercises as describe in
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

## Sharing Task

- Prompt:
- Format (individual, pair programming, presentation, group discussion, etc.): 
- Tools:

## Conclusion

In this lesson, we learned how to create methods in java. Methods are blocks of code that perform a specific task,
and they are used to break up a program into smaller, more manageable pieces. Methods can take parameters, which
are values that are passed into the method when it is called, and they can return values, which are values that are
sent back to the code that called the method. Methods are a powerful tool that allow us to write more complex
programs that are easier to read, understand, debug, and maintain.

