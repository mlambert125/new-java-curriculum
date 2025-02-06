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

## Introduction

Once you have installed Java and IntelliJ, and have learned the basics of how to use the IDE to create a project, you
are ready to start writing Java programs.  In this lesson, we will explore the basic syntax and structure of Java and
we will learn to write basic Java console applications that take input from the user and display output to the console.

Writing and reading from the console are a fundamental part of learning to program.  While most of the programs that
you will be writing in the future will be more complex and will interact with the user in more sophisticated ways, 
learning basic input and output operations is a good and quick way to get started with Java programming and will 
provide us with some basic tools to explore the language further before getting into more complex applications.

The examples in this lesson will explore how to write to the console, how to read from the console, and how to use
variables to store and manipulate data.

## Writing to the Console

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

### Check For Understanding 1

- Question/Exercise: What is the `main` method in a Java program?

- Expected Output/Answer: The `main` method is the entry point of a Java
program.  It is where the program starts running.

## Reading from the Console

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

Notice on the line `String name = scanner.nextLine();` that we are reading a line of text from the user and storing it
in a variable named `name`.  We then use this variable to print a greeting to the console.  On this line, the type
`String` is the type of the variable `name`.  When we first *declare* a variable, we must specify its type.  If you
look at the first line of our code in this method, you'll notice we declared a variable there as well - a variable
named `scanner` with the type `Scanner`.

We only put types on variables when we first declare them.  After that, we can use the variable without the type.  We
could rewrite the code above to separate the declaration of the variables from their use like this:

```java
...
public static void main(String[] args) {
    Scanner scanner;
    String name;

    scanner = new Scanner(System.in);
    System.out.print("Enter your name: ");
    name = scanner.nextLine();
    System.out.println("Hello, " + name + "!");
}
...
```

We typically write our code the first way for simplicity and conciseness, but it is important to understand that the
second way is also valid and that the declaration of a variable is separate from its use.

### Check For Understanding 2

- Question/Exercise: What is the object that we use to read input from the user in Java?

- Expected Output/Answer: The `Scanner` object.

## Making a Simple Payment Calculator

Now that we know how to read input from the user and display output to the console, let's write a simple program that
calculates the total cost of a purchase.  We will prompt the user to enter the price of an item and the number of items
they want to purchase, and then we will calculate the total cost and display it to the console.

Instead of using `Scanner.nextLine()` (which reads a String from the keyboard input), we will use
`Scanner.nextDouble()` to read a double value from the user.  We will also use
the `*` operator to multiply two numbers together.  Here is the code:

```java
...
public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);

    // Prompt the user to enter the price of the item
    System.out.print("Enter the price of the item: ");
    double price = scanner.nextDouble();

    // Prompt the user to enter the quantity of the item
    System.out.print("Enter the quantity of the item: ");
    double quantity = scanner.nextDouble();

    // Calculate the total cost
    double total = price * quantity;
    System.out.println("The total cost is: $" + total);
}
...
```

When you run this program, it will prompt you to enter the price of the item and the quantity of the item.  After you
enter these values and press Enter, it will calculate the total cost and display it to the console:

```bash
Enter the price of the item: 5.99
Enter the quantity of the item: 3
The total cost is: $17.97
```

> [!NOTE] Comments
> Notice that there are several lines that start with a `//` in the code.
> These lines are called *comments*.  Comments are used to explain what the code is doing.  They are ignored by the
> compiler and are only there to help you understand the code.  It is a good practice to write comments in your code to
> help you and others understand what the code is doing.

It is important that you spend some time reviewing the code above and make sure you understand how each line works.
Copy and paste the code into your `Main.java` file and run the program to see it in action.  Throughout all of your
learning, it is important to actually enter the code into your IDE and run it to see how it works versus just reading
about it.

### Check For Understanding 3

- Question/Exercise: Where is the type of a variable specified when it is first declared?

- Expected Output/Answer: At the beginning of the line where the variable is declared.

## Practice/Project Task

- Activity Description: 
- Prompt: Write a Java program that prompts the user to enter their age and
then prints a message to the console that tells them how many years they have
until they are 100 years old.
- Format (individual, pair programming, presentation, group discussion, etc.):
- Tools: IntelliJ IDE
- Time Estimate: 30 minutes
- Expected Outcomes: 
    - **Green**: A complete, correctly functioning Java program that prompts the user to enter their age and then
    prints a message to the console that tells them how many years they have until they are 100 years old.
    - **Yellow**: The program code is generally on the right track, but there are errors in the code that prevent the
    application from compiling or running correctly.
    - **Red**: The program code is incomplete or missing key elements that prevent the application from compiling. 
    Major syntax errors and/or misunderstanding of the concepts are present.

- Reference Solution (`Main.java` file)

```java
package org.example;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter your age: ");
        int age = scanner.nextInt();

        int yearsUntil100 = 100 - age;
        System.out.println("You have " + yearsUntil100 + " years until you are 100 years old.");
    }
}
```

## Conclusion

In this lesson, we learned how to write Java console applications that take input from the user and display output to
the console.  We learned how to use the `Scanner` class to read input from the user and how to use the `System.out`
methods to write output to the console.  We also learned how to declare variables and how to use them to store and
manipulate data.

With this knowledge, you can now write simple Java programs that perform basic input and output operations.  In the
lessons to come, you will learn more about variables, data types, and control structures in Java that will help you
do even more in your applications.

Later, you will learn about methods, objects and classes that will allow you to write more complex and powerful
programs while keeping your code organized and easy to read.
