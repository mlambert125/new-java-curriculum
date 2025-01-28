+++
title = "Java Basics 2"
type = "chapter"
weight = 40
+++

## Competency and Learning Objectives

### Competency:

Java Basics

### Learning Objectives:

- I can write java console applications that perform basic input and output operations.
- I can make use of variables in java to store and manipulate data.
- I can use basic conditional and iterative control structures in java.

## Introduction

Once you have installed Java and IntelliJ, and have learned the basics of how to use the IDE to create a project, you
are ready to start writing Java programs.  In this lesson, we will explore the basic syntax and structure of Java and
we will learn to write basic Java console applications that take input from the user and display output to the console.

This lesson assumes that you have installed and familiarized yourself with the the IntelliJ IDE and that you know
how to create a new project in IntelliJ and how to connect and push your project to GitHub.

## Reading and Writing to the Console

### Writing to the Console

When you create a new Java project in IntelliJ, you will see a file named `Main.java` in the `src` folder. This is the
entry point of your Java application. This file defines a class named `Main` that contains a method named `main`.  We
don't need to worry about what a class is or what a method is just yet.  Just know that the `main` method is where the
application starts running, and that we will write all of our code in between the curly braces `{}` of the `main`
method.

The default `main` class looks like this:

```java
package org.example;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello world!");
    }
}
```

The line `System.out.println("Hello world!");` is a statement that prints the text "Hello world!" to the console.  You
can run this program by clicking the green play button in the top right corner of the IntelliJ window.  You should see
"Hello world!" printed to the console tab at the bottom of the window.

We will be changing that line of code as we continue to one or more other lines of code that will allow us to take input
from the user and display output to the console.

First, let's adjust the code to print out a list of our favorite foods:

```java
...
public static void main(String[] args) {
    System.out.println("My favorite foods are:");
    System.out.println("Pizza");
    System.out.println("Tacos");
    System.out.println("Ice Cream");
}
...
```

> [!NOTE] Partial Code Samples
> The three dots `...` in the code samples above indicate that there is other code in the file that is not shown.  You
> should not include the three dots in your code.

Notice that what we did here was to remove the line that printed "Hello world!" and replaced it with three lines of
code that print out a list of our favorite foods.  You can run this program and see the output in the console.

```bash
My favorite foods are:
Pizza
Tacos
Ice Cream
```

### Reading from the Console

Now that we know how to write to the console, let's learn how to read input from the user.  We will use the
`Scanner` class to do this.  The `Scanner` class is part of the `java.util` package, so we need to import it at the top
of our file, right after the package declaration:

```java
package org.example;

import java.util.Scanner;
...
```

Next, we will return to the inside of the `main` method, clear out what we had written before and create a new
`Scanner` object that reads from `System.in`:
```java
...
public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
}
...
```

> [!NOTE] Creating Objects
> This is an example of creating an object in Java.  We will learn more about objects in a later lesson.
> For now, just know that we are creating a new `Scanner` object and assigning it to a variable named `scanner`,
> and that we will be using this variable to read input from the user.

Now that we have set up a `Scanner` object, we can use it to read input from the user.  Let's prompt the user to enter
their name and then print a greeting to the console:

```java
...
public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    System.out.print("Enter your name: ");
    String name = scanner.nextLine();
    System.out.println("Hello, " + name + "!");
}
...
```

When you run this program, it will prompt you to enter your name.  After you enter your name and press Enter, it will
print a greeting to the console:

```bash
Enter your name: John
Hello, John!
```

### Check For Understanding 1

- Question/Exercise:
- Expected Output/Answer:
- Common Misconceptions to Address:

## Using Conditional Structures

### Check For Understanding 2

- Question/Exercise:
- Expected Output/Answer:
- Common Misconceptions to Address:

## Using Iteration Structures

### Check For Understanding 3

- Question/Exercise:
- Expected Output/Answer:
- Common Misconceptions to Address:

## Reflection Task
- Prompt: 
- Expected Outcomes: 
    - **Green**: 
    - **Yellow**: 
    - **Red**: 

## Sharing Task

- Activity Description:
- Prompt:
- Format (individual, pair programming, presentation, group discussion, etc.):
- Tools:
- Time Estimate:
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
- Expected Outcomes: 
    - **Green**:
    - **Yellow**:
    - **Red**:

## Conclusion

