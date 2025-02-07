+++
title = "Java Setup 1"
type = "chapter"
weight = 10
+++

## Competency and Learning Objectives

### Competency:

Intro to Java

### Learning Objectives:

- I recognize Java’s relevance in the modern technology atmosphere.

## Introduction

<figure>

![java mascot](java_mascot.svg)

<figcaption>Image Source: <a href="https://www.oracle.com/java/">Oracle</a></figcaption>

</figure>


Welcome to Unit 2: Full Stack Development with Java! We will be coding in Java for the entirety of this Unit. This
lesson serves as an introduction to the Java programming language and to guide you through the Java install as well as
assisting in the setup of the support technologies used to assist us in executing and editing our Java applications.
You should have a working knowledge of your terminal and how to navigate basic commands and directories as well as be
familiar with an IDE.

Java is a high-level, multi-paradigm, object-oriented programming language famous for its ability to run platform
independent [bytecode](https://en.wikipedia.org/wiki/Java_bytecode). One of the world’s most popular programming
languages, it has been running on over 3 billion devices for nearly 30 years and as of 2022 boasts the 3rd most popular
programming language on Github.

Designed by James Gosling in 1990 with the general-purpose mission of [write once, run
anywhere](https://en.wikipedia.org/wiki/Write_once,_run_anywhere) encapsulating the core standard that Java could be
developed on any device, compiled into standard bytecode, and run on any device equipped with a [Java Virtual
Machine](https://en.wikipedia.org/wiki/Java_virtual_machine) without needing to recompile. As long as the computer has
the **Java Runtime Environment (JRE)** installed, Java is both a compiled and interpreted language simultaneously. This
paved the way for Java to power everything from mobile apps via Android, enterprise web apps with Spring Boot, big data
pipelines utilizing Hadoop, even the controller for NASA’s Maestro Mars Rover! 

In this lesson we will dive deeper into Java’s execution system, explore its foundational principles and set up the
tools required to get started building our very own Java applications!

## How Java Works

- Key Concepts
- What makes Java different from other programming languages
- Java can run on essentially any computer due to a unique ability to run platform independent bytecode.
- The JRE, JVM and JDK, which houses all of the Java software, work in conjunction to translate the data back and
forth and provide the proper resources necessary to bring a Java app to life on whatever operating system it needs
to live on.

### The Java Trifecta of Requirements: JRE, JVM, and JDK

Java requires three software platform components for any Java program to run successfully. These are the Java Runtime
Environment (JRE),  Java Virtual Machine (JVM) and the Java Development Kit (JDK), a veritable triforce when combined.
Let’s take a look at why each of these components are necessary and how they work together to help bring a Java app to
life.

#### Java Runtime Environment (JRE)

The JRE is the underlying technology that communicates between the Java program and the operating system. Think of it
like the translator and ambassador, complete with gifts. Software programs need runtime environments that provide
access to system resources such as memory, program files and dependencies. The JRE runs on top of the operating system,
providing additional Java specific resources without needing to utilize the operating system directly, so that the Java
code can run on any OS without needing further modifications - write once, run everywhere!

The JRE interacts with the Java Development Kit (JDK - we’ll circle back to that) to create a sustainable runtime
environment that runs Java program files on any machine. The JRE uses three core components to work:

- Bytecode verifier
- The compiler that verifies your written Java code for accuracy before loading it into the JVM
- Interpreter
- Once the bytecode loads successfully, the Java interpreter creates the JVM instance that runs the Java program on
the machine.
- ClassLoader
- Collection of Class libraries

#### Java Virtual Machine (JVM)

The Java Virtual Machine is exactly as advertised: a virtual machine that enables a computer to run Java programs as
well as programs in other languages that compile to Java bytecode. This compiled Java bytecode is given to the JVM to
read and translate into machine code, which can then be read by the computer and executed line by line. The JVM
settings can also be altered to manage program resources when the Java application runs, such as changing the JVM
memory setting to see how much internal memory the Java application uses at runtime. 

#### Java Development Kit (JDK)

The third and final piece of this trifecta is the **Java Development Kit**, where everything comes together. The JDK is
a collection of software tools used for developing Java applications, namely the Java compiler **javac** and our good
friend the **Java Virtual Machine** and **Java Runtime Environment** itself. This whole system, the JRE, JVM and JDK
all fits together like a well oiled machine and it is with the installation of the JDK where we will begin our Java
development journey.

##### Included in the JDK:
- [Development tools](https://docs.oracle.com/en/java/javase/11/tools/tools-and-command-reference.html)
- javac - compiler
- java - launches a Java application
- javadoc -generates HTML pages of API docs from Java source files
- Jar - creates an archive for classes and resources, and manipulates or restores individual classes or resources
from an archive
- JRE
- Bytecode verifier
- Libraries
- JVM
- Java interpreter
- Garbage collector
- [JIT](https://en.wikipedia.org/wiki/Just-in-time_compilation) compiler

Let’s break this Java process down one more time!

##### Steps to create a java application:
- Human write code in Java
- JDK compiles Java code into bytecode
- JRE verifies bytecode, loads into JVM
- In the JVM, bytecode is translated to machine code by interpreter
- Computer reads and executes machine code
- Celebration!

<figure>

![compiler](compiler.gif)

<figcaption>Image Source: <a href="https://www.oracle.com/java/">Oracle</a></figcaption>

</figure>


>[!note] Remember
>The code must be correct for the compiler to produce a version that can be executed. Compiling code
>may sometimes fail, which will cause errors. That’s when the debugging fun can begin!

### Check For Understanding 1

- Question/Exercise:
    - What three components are required for a Java program to run successfully and what is the difference between
    them?
- Expected Output/Answer:
    - Java Runtime Environment, Java Development Kit, Java Virtual Machine. 
    - They work together in harmony very closely to form a Java application that can essentially run on any operating
    system. The developer writes the code in the JDK, which compiles it into bytecode that is verified by the JRE and
    loaded into the JVM where the interpreter translates it into machine code to be read by the computer/any operating
    system.
    - Essentially, they all perform different functions, either translating, sending information back and forth, or
    providing resources, but all parts are necessary to ensure the Java app will run properly on any OS.
- Common Misconceptions to Address:
    - While the JDK does essentially contain all of the software, they do operate separately. 
    - Java and JavaScript are two completely separate programming languages.

## Getting Started with Java

### Install the JDK

Now that we have some base level understanding of how Java operates underneath the hood, it’s time to install Java on
your machine as well as some additional support technologies to allow you to run and edit Java code. 

While [Oracle](https://en.wikipedia.org/wiki/Oracle_Corporation) offers its own
[HotSpot](https://en.wikipedia.org/wiki/HotSpot_(virtual_machine)) Java Virtual Machine, the official reference
implementation is the [OpenJDK](https://openjdk.org/) JVM which is free open-source software. It is used by most
developers and what we will be using during this Unit. It is also the default JVM for almost all Linux distributions.

As of September 2024, Java 23 is the latest version (Java 22, and 20 are no longer maintained). Java 8, 11, 17, and 21
are previous LTS versions still officially supported and we will be using Java 17 for consistency.

On the [OpenJDK](https://openjdk.org/) website, choose your operating system and Java 17 to install the JDK.

Once your download has completed and you have finished installing Java, open your Terminal and enter the following
command:

```bash java --version ```

You should see an output similar to:

```bash openjdk 17.0.13 2024-10-15 ```

With additional information following that is more specific to your system. If not, go back and repeat the steps above.
Once you have java version 17 installed and ready to go, let’s move on!

### IntelliJ - Java's Favorite IDE

The next piece of software we will need to begin writing code in Java is our IDE, or integrated development
environment. While you may be familiar with other IDEs, IntelliJ, made by the company JetBrains, is particularly useful
for Java as it comes with a host of bonus features designed to make Java development even more enhanced. IntelliJ
offers code completion hints, debugging, and even its own compiler - basically its own JDK! We will be using it
exclusively throughout this course, so let’s get IntelliJ up and running and familiarize ourselves with the basics.

#### Install IntelliJ

Visit the [IntelliJ download site](https://www.jetbrains.com/idea/download). Select your operating system and be sure
to scroll down the page to select the Community version of IntelliJ!! The main version of IntelliJ is paid, and the
Community version is always free. We will be using the Community version throughout the course.

#### Install GitHub Desktop


Visit the [Github desktop site](https://desktop.github.com/download/). You may need to select your operating system,
but Github is smart, and the site should pick up on what OS is visiting it. Once it is installed, sign in with your
Github account to finish setup. [Here is the
documentation](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/installing-github-desktop)
if necessary. Once Github desktop is synced, select Options and Integrations to select JetBrains IntelliJ Idea
Community Edition as the External Editor.

### Check For Understanding 2

- Question/Exercise: Do I have all of the tools necessary to begin writing my Java code ready to go? How can I check to
make sure?
- Expected Output/Answer: java --version
    - Output: openjdk 17.0.13 2024-10-15
    - Check that Github desktop is connected to Github account and IntelliJ
- Common Misconceptions to Address: Java does not need to be downloaded from Oracle, in fact most devs utilize the open
source OpenJDK which houses many more versions of Java for free with easy steps for all operating systems.

## Reflection Task

Once you’re up and running, why not take the quick onboarding tour and familiarize yourself with Java?

- Prompt: Take the Java onboarding tour! Play around with your IDE! Research some plugins, maybe select a fun theme
that you really like to look at. Try out a few themes. Maybe dive further into the JetBrains community and sign up for
a JetBrains account. What benefits does this award you? What does the Java community recommend with research? This is
going to be what you’re staring at for many long hours, really take the time to get to know it! Maybe you want to
import the shortcuts from a previous IDE, or maybe you want to investigate the top new plugins of 2024. Be prepared to
share your findings!
- Learning Connection: Get the student used to navigating IntelliJ.
- Expected Outcomes: 
    - **Green**: Student feels comfortable using IntelliJ and feels excited to begin coding in Java in lesson 2.
    - **Yellow**: Student feels a bit nervous and still has questions regarding the lesson, but wants to put all of the
    pieces together in practice.
    - **Red**: Student feels overwhelmed in the IDE, does not explore naturally and needs things broken down further.

## Conclusion - Welcome, IntelliDevs

Congratulations, you just took your first steps into the wild world of Java development! Java may seem complicated but
once you fully grasp how the power of three software platforms compile, translate, and harness resources to create the
ultimate language built for any machine you too can harness its power to code nearly anything you can think of. In the
upcoming lessons we will begin to write our own Java applications, starting with the simple Hello World as we continue
to break down exactly what it is what is compiling where and why and moving into the syntax, data, and control flow of
one of the more unique multi-paradigm high-level programming languages out there. Whether you’re looking to develop
mobile apps, build video games, expand your developer knowledge with a new language, or send something out to Mars,
Java’s got the goods for you. Outer space is actually the limit here, developers. With Java, you can compile anything.
