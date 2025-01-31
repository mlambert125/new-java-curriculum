+++
title = "Java Basics 3"
type = "chapter"
weight = 50
+++

## Competency and Learning Objectives

### Competency:

Java Basics

### Learning Objectives:

- I can write java applications that make use of Java's arrays and collection classes.

## Introduction

When writing java applications, we sometimes need to store several values together in a single variable so that they
can be processed together. Java provides two ways to do this: arrays and collections. In this lesson, we will learn
how to use arrays and collections in Java.

This lesson assumes that you have a basic understanding of how to write simple Java programs using IntelliJ, and that
you are familiar with core language concepts such as variables, data types, and control structures.

## Arrays

Sometimes in an application, it makes sense to store multiple values of the same type together in a single variable
and to primarily treat them as a single entity. This is where arrays come in. An array is a data structure that can
store multiple values of the same type together in a single variable. Each value in an array is called an element, and
each element is accessed by its index. The index of an element is a number that represents the position of the element
in the array. The first element in an array has an index of 0, the second element has an index of 1, and so on.

Here is an example of how to declare and initialize an array in Java:

```java
int[] numbers = new int[5];
numbers[0] = 10;
numbers[1] = 20;
numbers[2] = 30;
numbers[3] = 40;
numbers[4] = 50;
```

In this example, we declare an array of integers called `numbers` that can store 5 integers. We then assign values to
each element of the array using the index notation `numbers[index]`.

Notice that the size of the array is specified when the array is declared. Once an array is created, its size cannot be
changed. If you need to store more values than the size of the array, you will need to create a new array with a larger
size and copy the values from the old array to the new array.

Let's look at another way to declare and initialize an array in Java:

```java
int[] numbers = {10, 20, 30, 40, 50};
```

In this example, we declare an array of integers called `numbers` and initialize it with the values 10, 20, 30, 40,
and 50. This is the same as the previous example, but it is more concise.

### Check For Understanding 1

- Question/Exercise:
- Expected Output/Answer:
- Common Misconceptions to Address:

## Section 2

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

