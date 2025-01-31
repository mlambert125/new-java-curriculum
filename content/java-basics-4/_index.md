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

### The `for` Loop

Another common loop in Java is the `for` loop. The `for` loop allows us to repeat a block of code a specific number of
times. The `for` loop has three parts: the initialization, the condition, and the update. For example:

```java
...
for (int i = 0; i < 10; i++) {
    System.out.println("This is iteration " + i));
}
...
```

The `for` loop is a more complex loop structure than the `while` and `do while` loops.  It is really just a shorthand
for a common pattern of a while loop that initializes a variable, checks a condition, and updates the variable each
iteration.  The initialization is done before the loop starts, the condition is checked before each iteration, and the
update is done after each iteration.  Each part of the for loop is separated by a semicolon `;` in that order:

```java
for (initialization; condition; update) { ... }
```

The equivalent while loop would look like this:

```java
int i = 0;  // initialization
while (i < 10) {  // condition
    System.out.println("This is iteration " + i);
    i++; // update
}
```

### For Loops with Arrays

One common use of the `for` loop is to iterate over the elements of an array.  For example:

```java
String[] names = {"Alice", "Bob", "Charlie", "David"};
for (int i = 0; i < names.length; i++) {
    String currentName = names[i];
    System.out.println(currentName);
}
```

This pattern is so common that Java provides a special syntax for iterating over arrays called the for-each loop.  The
for-each loop is a simpler way to iterate over the elements of an array.  For example:

```java
String[] names = {"Alice", "Bob", "Charlie", "David"};
for (String name : names) {
    System.out.println(name);
}
```

Both of these loops will print each name in the `names` array to the console.  Both syntaxes are very common, but you
will usually see the for-each loop when dealing with newer java code.

### Break and Continue

In addition to the basic loop structures, Java provides two special keywords that can be used inside loops to control
the flow of execution. The `break` keyword allows us to exit a loop prematurely, while the `continue` keyword allows us
to skip the rest of the current iteration and move on to the next iteration.  One way to think of these keywords is that
`break` jumps to the end of the loop (and out), while `continue` jumps to the beginning of the loop (and in).

For example:

```java
for (int i = 0; i < 10; i++) {
    if (i == 5) {
        break;
    }
    System.out.println("This is iteration " + i);
}
```

This loop will print "This is iteration 0", "This is iteration 1", "This is iteration 2", "This is iteration 3", and
"This is iteration 4" to the console, and then exit the loop when `i` is equal to 5.

```java
for (int i = 0; i < 10; i++) {
    if (i == 5) {
        continue;
    }
    System.out.println("This is iteration " + i);
}
```

This loop will print "This is iteration 0", "This is iteration 1", "This is iteration 2", "This is iteration 3", and
"This is iteration 4" to the console, and then skip printing "This is iteration 5" and continue with "This is iteration
6", "This is iteration 7", "This is iteration 8", and "This is iteration 9".


### Check For Understanding 2

- Question/Exercise:  Which kind of loop is best suited to print a rocket ship countdown from 10 to 1?
- Expected Output/Answer: A `for` loop
- Common Misconceptions to Address: Some students may think that a `while` loop is better because it is simpler.
However, the `for` loop is better suited to this task because it is designed to repeat a block of code a specific number
of times.

## Sharing Task

- Activity Description: Loop brainstorming
- Prompt: Brainstorm an example of a real-world situation where you would use each of the three types of loops.
- Format (individual, pair programming, presentation, group discussion, etc.): Group discussion
- Tools:  Whiteboard or paper
- Time Estimate: 15 minutes
- Expected Outcomes: 
    - **Green**: Groups can come up with creative and realistic examples for each type of loop.
    - **Yellow**: Group struggle to come up with examples for one or more types of loops.
    - **Red**: Group have difficulty understanding the concept of loops and their real-world applications.

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

