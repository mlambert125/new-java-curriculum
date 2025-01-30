+++
title = "Java Basics 4"
type = "chapter"
weight = 60
+++

## Competency and Learning Objectives

### Competency:

Java Basics

### Learning Objectives:

- I can use conditional statements in Java to control the flow of execution in my programs.
- I can use loops in Java to repeat blocks of code.

## Introduction

In this lesson, we will explore how to use conditional statements and loops in Java. Conditional statements allow us to
execute different blocks of code based on certain conditions, while loops allow us to repeat blocks of code multiple
times. These are fundamental concepts in programming that enable us to create dynamic and flexible applications.

This lesson assumes that you have a basic understanding of Java syntax and structure, data types and variables in java,
basic input and output processing in java, and familiarity with the IntelliJ IDE.

## Conditional Statements

### The `if` Statement

In Java, we can use conditional statements to execute different blocks of code based on certain conditions. The most
common conditional statement in Java is the `if` statement. The `if` statement allows us to execute a block of code if a
certain condition is true. For example:

```java
package org.example;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter your age: ");
        int age = scanner.nextInt();

        if (age >= 18) {
            System.out.println("You are an adult.");
            System.out.println("Congratualations!");
        }
    }
}
```

This program prompts the user to enter their age and then checks if the age is greater than or equal to 18. If the
age is greater than or equal to 18, the program prints "You are an adult." and "Congratualations!" to the console.

Notice the format of the if statement.  First, we have the keyword `if` followed by a set of parentheses `()`.  Inside
the parentheses, we place a boolean expression that evaluates to either true or false.  In this case, we are checking if
the value of the `age` variable is greater than or equal to 18.  If the expression evaluates to true, then the block of
code between the curly braces `{}` will execute.  If it evaluates to false, then the block of code will be skipped.

> [!NOTE]
> The rest of this lesson will assume that you have imported the approriate libraries and that you are writing the
> examples in the `main` method of the `Main` class.

### The `else` Statement

Every if statement can optionally be followed by an else statement that allows us to execute a block of code if the
condition in the `if` statement is false.  When you have an if/else statement, one and only one of the blocks of code
will execute.  For example:

```java

For example:

```java
...
Scanner scanner = new Scanner(System.in);
System.out.print("Enter your age: ");
int age = scanner.nextInt();

if (age >= 18) {
    System.out.println("You are an adult.");
    System.out.println("Congratualations!");
} else {
    System.out.println("You are not an adult.");
    System.out.println("Sorry!");
}
...
```

This program prompts the user to enter their age and then checks if the age is greater than or equal to 18. If the
age is greater than or equal to 18, the program prints "You are an adult." and "Congratualations!" to the console. If
the age is less than 18, the program prints "You are not an adult." and "Sorry!" to the console.

Notice that the program will always execute either the block of code inside the if statement or the block of code
inside the else statement, but not both.  This is because the if statement and the else statement are mutually
exclusive.

### The `else if` Statement

In addition to the `if` and `else` statements, we can also use the `else if` statement to check multiple conditions
in sequence until one of them matches.  For example:

```java
...
Scanner scanner = new Scanner(System.in);
System.out.print("Enter your age: ");
int age = scanner.nextInt();
if (age >= 18) {
    System.out.println("You are an adult.");
    System.out.println("Congratualations!");
} else if (age >= 13) {
    System.out.println("You are a teenager.");
    System.out.println("Enjoy your youth!");
} else {
    System.out.println("You are a child.");
    System.out.println("Have fun!");
}
...
```
This program prompts the user to enter their age and then checks if the age is greater than or equal to 18. If the
age is greater than or equal to 18, the program prints "You are an adult." and "Congratualations!" to the console. If
the age is less than 18 but greater than or equal to 13, the program prints "You are a teenager." and "Enjoy your
youth!" to the console. If the age is less than 13, the program prints "You are a child." and "Have fun!" to the
console.

Notice that the second condition in the `else if` statement is only checked if the first condition in the `if`
statement is false.  So when checking for a teenager, we did not need to check if the age was less than 18, because
if the age was greater than or equal to 18, the first condition would have already been true and this condition
would not have been checked.

As with the simple `if/else` chain, longer `if/else if/else` chains are also mutually exclusive.  This means that
if the first condition is true, the block of code inside the first if statement will execute and the rest of the
chain will be skipped.  If the first condition is false, the program will check the second condition, and so on,
until it finds a condition that is true or reaches the end of the chain.

### Check For Understanding 1

- Question/Exercise:
- Expected Output/Answer:
- Common Misconceptions to Address:

## Loops

### The `while` Loop

In Java, we can use loops to repeat blocks of code multiple times. The most common loop in Java is the `while` loop. The
`while` loop allows us to execute a block of code repeatedly as long as a certain condition is true. For example:

```java
...
Scanner scanner = new Scanner(System.in);
System.out.print("Enter a number: ");
int number = scanner.nextInt();
while (number > 0) {
    System.out.println("The number is positive.");
    System.out.print("Enter a number: ");
    number = scanner.nextInt();
}
...
```

This program prompts the user to enter a number and then checks if the number is greater than 0. If the number is
greater than 0, the program prints "The number is positive." to the console and prompts the user to enter another
number. This process continues until the user enters a number that is less than or equal to 0.

Notice that the form of a while loop is very similar to an if statement.  The only difference is that the block of code
inside the curly braces `{}` will execute repeatedly, rechecking the condition each time the block of code restarts, 
until the condition evaluates to false.

### The `do while` Loop

In addition to the `while` loop, we can also use the `do while` loop to repeat blocks of code. The `do while` loop is
similar to the `while` loop, but the condition is checked after the block of code has executed. This means that the
block of code will always execute at least once. For example:

```java
...
Scanner scanner = new Scanner(System.in);
System.out.print("Enter a number: ");
int number = scanner.nextInt();
do {
    System.out.println("The number is positive.");
    System.out.print("Enter a number: ");
    number = scanner.nextInt();
} while (number > 0);
...
```

### Check For Understanding 2

- Question/Exercise:
- Expected Output/Answer:
- Common Misconceptions to Address:

## Section 3

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

