+++
title = "Unit Testing"
type = "chapter"
weight = 120
+++

## Competency and Learning Objectives

### Competency:

Unit Testing

### Learning Objectives:

- I can create unit tests in java using JUnit and IntelliJ’s built-in test runner.
- I can identify edge cases and branches in code to provide sufficient test coverage. 

## Introduction

Unit testing is a software testing method by which individual units of source code are tested to determine if they are
fit for use. A unit is the smallest testable part of an application, typically a function or method. In Java, unit tests
are written using the JUnit framework. 

The exercises that you have completed in previous lessons have all included unit tests that were using JUnit. In this
lesson, we will take a closer look at how to write unit tests using JUnit and how to run them in IntelliJ IDEA.

## Basic Unit Testing Implementation

### Creating a Simple Calculator Class

To demonstrate how to write unit tests, we will create a simple calculator class that has methods for adding,
subtracting, multiplying, and dividing two numbers.  If you want to follow along, create a new class called
`Calculator` in the `main/java` directory of your project. 

```java
package org.example;

public class Calculator {
    public int add(int a, int b) {
        return a + b;
    }

    public int subtract(int a, int b) {
        return a - b;
    }

    public int multiply(int a, int b) {
        return a * b;
    }

    public int divide(int a, int b) {
        return a / b;
    }
}
```

### Creating a Test Class

Typically, to create a unit test, we begin by creating a new folder called `test/java` in the `src` directory of our project
next to the `main` folder. If you right-click on the `src` folder in IntelliJ IDEA, you can select `New -> Directory`
and one of the suggested choices will be to create this `test` directory.

[!Make Test Directory](../images/make-test-directory.png)

> [!NOTE]
> Depending on how your project was created, you may already have a `test` directory in your project. If you do, you
> can skip the previous step.

Next, we will create a new package in the `test/java` directory. This package should have the same name as the package
for your project (by default `org.example`). You can create a new package by right-clicking on the `test/java` directory
and selecting `New -> Package` and entering the package name.

[!Make Test Package](../images/make-test-package.png)

Finally, we right-click on the package we just created and select `New -> Java Class` to create a new test class. The
name of the test class should be the same as the name of the class we are testing with the word `Test` appended to the end.
In this case, we will create a class called `CalculatorTest`.

### Adding a Test Method

Let's add a test method to the `CalculatorTest` class that tests the `add` method of the `Calculator` class. The test
method should be annotated with `@Test` and should have a name that describes what is being tested. The method should
create an instance of the `Calculator` class, call the `add` method with some values, and then use an assertion to check
that the result is what we expect.

Let's look at this example, and then examine and walkthrough the code.

```java
package org.example;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {
    @Test
    public void testAdd() {
        Calculator calculator = new Calculator();
        int result = calculator.add(2, 3);
        assertEquals(5, result);
    }
}
```

> [!NOTE]
> When pasting this code in, you may see some red squiggly lines under the `@Test` and `assertEquals` annotations. This
> is because IntelliJ IDEA does not know where to find the classes that these annotations are part of. You can fix this
> by hovering over the red squiggly line and selecting the option to import the class.
>
> You may be prompted to add the JUnit library to your project. If you are, click the `Add JUnit4 to classpath` button
> that appears in the top right corner of the editor.  In general, the first time you add a `@Test` annotation, you will
> be prompted to add the JUnit library to your project.

You can run this test now by right-clicking the class file in the file tree and selecting `Run 'CalculatorTest' just
as you have for previous exercises. You should see a green bar indicating that the test passed.

A basic JUnit test method always takes no arguments and returns `void`. The `@Test` annotation tells JUnit that this
method is a test method.

If you look at the code for our `testAdd` method, the first two lines should be familiar. We create an instance of the
`Calculator` class and call the `add` method with the values `2` and `3`. The next line is where the magic happens. We
use the `assertEquals` method from the `org.junit.jupiter.api.Assertions` class to check that the result of the `add`
method is `5`. If the result is not `5`, the test will fail.

The import for `Assertions` probably looks a little strange. The `Assertions` class is a static class that contains
many useful assertion methods. By using `import static`, we can import all of the static methods from the `Assertions`
class in a way that lets us use them without having to prefix them with the class name.  This method is usually how we
import the static assertion methods that we use in our test classes.

A test method fails if:

1. The method encounters a normal exception while running.
2. An assertion fails.

Otherwise, the test passes.

### Causing a Failure

To see what a failing test looks like, let's change the `add` method in the `Calculator` class to always return `0`.
Once you have done this, try re-running the test. You should see a red dot indicating that the test failed.

### Adding an Assertion Message

As you can see from the failing test, it can be difficult to determine what went wrong just by looking at the output.
To make it easier to understand what went wrong, we can add a message to the `assertEquals` method that will be
displayed if the assertion fails.  This is done by simply adding an optional third argument to the `assertEquals` method
that is a string containing the message you want to display in the unit test output if the assertion fails.

```java
assertEquals(5, result, "2 + 3 should equal 5");
```

### Other Assertion Methods

The `Assertions` class contains many other assertion methods that you can use in your test methods. Some of the most
commonly used methods are:

| Method | Description |
|--------|-------------|
| `assertEquals` | Asserts that two objects are equal. |
| `assertNotEquals` | Asserts that two objects are not equal. |
| `assertTrue` | Asserts that a condition is true. |
| `assertFalse` | Asserts that a condition is false. |
| `assertNull` | Asserts that an object is null. |
| `assertNotNull` | Asserts that an object is not null. |
| `assertArrayEquals` | Asserts that two arrays are equal. |
| `assertThrows` | Asserts that a method throws an exception. |

You can use these methods to test different aspects of your code. For example, you could use `assertNull` to check that
a method returns `null` when it should, or `assertArrayEquals` to check that an array is sorted correctly.

### Adding More Test Methods

You should now know everything you need to write more test methods for the `Calculator` class. Try writing test methods
for the `subtract`, `multiply`, and `divide` methods. You can use the `assertEquals` method to check that the results
are correct.

### Check For Understanding

1. **Question:** What is a unit test?
    - **Answer:** A unit test is a software testing method by which individual units of source code are tested to
    determine if they are fit for use.
2. **Question:** What is `import static` used for?
    - **Answer:** `import static` is used to import all of the static methods from a class in a way that lets us use
    them without having to prefix them with the class name.
3. **Question:** What is the purpose of the `@Test` annotation?
    - **Answer:** The `@Test` annotation tells JUnit that a method is a test method, and will make the method run and
    show up in IntelliJ's test runner.

## Designing Good Unit Tests

Now that you know how to write a basic unit test, let's talk about how to design good unit tests

### Test Classes should Mirror the Class Being Tested

When writing unit tests, it is a good idea to create a test class for each class you are testing. The test class should
have the same name as the class being tested with the word `Test` appended to the end. If your project has multiple
classes, you should have a test class for each class.

### Test Methods should be Descriptive

When writing test methods, it is important to give them descriptive names that explain what is being tested. This often
results in you writing very long method names, beyond what you might normally do in your code. This is okay, as it makes
it easier to understand what the test is doing.

### Test Methods should be Independent

Each test method should be independent of the others. This means that the order in which the test methods are run should
not matter, and that each test method should not rely on the results of other test methods. This makes it easier to
determine what went wrong when a test fails, and makes it so that a developer can run a single test method without
needing to run all of the tests.

### Parameter Values

When writing test methods, you should generally write one test for the "happy path" (the normal case where everything
works as expected) and one or more tests for edge cases (cases where the input is at the limit of what is allowed). This
ensures that your code is tested in a variety of situations.

#### Happy Path

The "happy path" is the normal case where everything works as expected. For example, when we wrote our test above, we
tested the `add` method with the values `2` and `3`. There is nothing unusual or special about these values, and they
are very typical values that we would expect to be passed into our add method.

#### Edge Cases

Edge cases are unusual values that may cause unexpected behavior in your code. Let's consider some unusual values for
the parameters of our `add` method. What happens if we pass in `0` and `0`? What happens if we pass in the largest
number that an `int` can hold and try to add to it?

Here are some good examples of edge cases for our add method:

| Value | Description |
|-------|-------------|
| `0` and `0` | Adding `0` to `0` should return `0`. |
| `-1` and `1` | Adding `-1` to `1` should return `0`. |
| `-1` and `-1` | Adding `-1` to `-1` should return `-2`. |
| `Integer.MAX_VALUE` and `1` | Adding `Integer.MAX_VALUE` to `1` should throw an exception. |
| `Integer.MIN_VALUE` and `-1` | Adding `Integer.MIN_VALUE` to `-1` should throw an exception. |

> [!NOTE]
> You may not have encountered `Integer.MAX_VALUE` and `Integer.MIN_VALUE` before. These are constants in the `Integer`
> class that represent the largest and smallest values that an `int` can hold. `Integer.MAX_VALUE` is `2147483647` and
> `Integer.MIN_VALUE` is `-2147483648`.  These are useful constants to know about when writing tests for methods that
> take `int` parameters.


### Testing Exceptional Cases

When writing unit tests, it is important to test exceptional cases. These are cases where the expected behavior is to
throw an exception. For example, if we try to add `Integer.MAX_VALUE` to `1`, we would expect an exception to be thrown
because the result is too large to fit in an `int`.

To test that an exception is thrown, we can use the `assertThrows` method from the `Assertions` class. This method takes
three arguments: the type of exception that is expected, a `Executable` (a functional interface that takes no arguments
and returns `void`), and an optional message.

These arguments use some new concepts that we have not seen before. Let's look at an example and then walk through the
code.

```java
    @Test
    public void testAddMaxValues() {
        Calculator calculator = new Calculator();
        assertThrows(ArithmeticException.class, () -> { calculator.add(Integer.MAX_VALUE, Integer.MAX_VALUE); });
    }
```

The first argument to `assertThrows` is the type of exception that is expected.  The way that we communicate a type name
or class in Java is by using the `.class` syntax. In this case, we are expecting an `ArithmeticException` to be thrown,
so we refer to that class by name and use the `.class` syntax to get a reference to the type itself.

The second argument to `assertThrows` is a lambda expression that contains the code that we expect to throw the
exception.  A lambda expression is a way to specify a block of code that can be passed around and executed later. In
this case, we are passing a block of code that calls the `add` method on the `calculator` object with
`Integer.MAX_VALUE` as both parameters. This code will throw an `ArithmeticException` because the result is too large
to fit in an `int`.

Lambda expressions start with a set of parentheses that contain the arguments to the lambda expression (in this case,
there are no arguments), followed by an arrow `->`, and then the body of the lambda expression enclosed in curly braces.

We will use lambda expressions more in later topics, but for now, you can think of them as a way to pass a block of code
to the `assertThrows` method that you expect to throw an exception.



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


