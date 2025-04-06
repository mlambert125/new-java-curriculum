+++
title = "Ai Fundamentals 2"
type = "chapter"
weight = 270
+++

## Competency and Learning Objectives

### Competency:

AI Fundamentals

### Learning Objectives:

- I can use coding assistants like GitHub Copilot to aid in development

## Introduction

In addition to writing your software to integrate with LLMs, you can also use them to help you write your software.
GitHub Copilot is a tool that uses OpenAI's Codex model to provide code suggestions as you write. This can help you
write code faster and with fewer errors. In this lesson, you will learn how to use GitHub Copilot to help you write
code.

GitHub Copilot is free for basic use, but you will need a GitHub account to use it. At this point, you should already
have a GitHub account, but if you don't, you can create one at [https://github.com](https://github.com).

## Installing GitHub Copilot

### Installing and Activating GitHub Copilot in Visual Studio Code

To use GitHub Copilot, you need to install the GitHub Copilot extension in Visual Studio Code. To do this, follow these
steps:

1. Open Visual Studio Code.
2. Click on the Extensions icon in the Activity Bar on the side of the window.
3. In the Extensions view, search for "GitHub Copilot".
4. Click on the Install button next to the GitHub Copilot extension.
5. Once the extension is installed, you will need to sign in with your GitHub account to activate it.

### Installing and Activating GitHub Copilot in IntelliJ IDEA

To use GitHub Copilot in IntelliJ IDEA, you need to install the GitHub Copilot plugin. To do this, follow these steps:

1. Open IntelliJ IDEA.
2. Go to the File menu and select Settings.
3. In the Settings dialog, click on the Plugins section.
4. In the Plugins section, click on the Marketplace tab.
5. Search for "GitHub Copilot" in the Marketplace.
6. Click on the Install button next to the GitHub Copilot plugin.
7. Once the plugin is installed, you will need to sign in with your GitHub account to activate it.

### Basic Suggestions

Once you have installed and activated GitHub Copilot, you can start using it to help you write code. As you type in your
editor, GitHub Copilot will provide suggestions for completing your code. These suggestions will be based on the context
of your code and the patterns it recognizes in the code you have written so far.

First, create a new java project in IntelliJ.  Remember to choose Maven as the project type.  Next, open the main class
file and start typing the following code under the main method:

```java
public static void printSquares(int lowerBound, int upperBound) {
}
```

Before you have even finished typing the method signature, GitHub Copilot will provide a suggestion for the method body.
You can press the `Tab` key to accept the suggestion and insert the code into your editor.

```java
public static void printSquares(int lowerBound, int upperBound) {
    for (int i = lowerBound; i <= upperBound; i++) {
        System.out.println(i + " squared is " + i * i);
    }
}
```

This is the basic way that GitHub Copilot works. It provides suggestions based on the context of your code and the
patterns it recognizes in the code you have written so far.  You can use these suggestions to help you write code
faster and with fewer errors.

It is important when using GitHub Copilot to review the suggestions it provides and make sure they are correct. GitHub
Copilot is a powerful tool, but it is not perfect, and it can make mistakes and sometimes provide suggestions that are
incorrect or suboptimal. Always review the suggestions GitHub Copilot provides and make sure they are correct before
accepting them.

It may be tempting to resort to what is sometimes called "vibe coding" where you just accept all the suggestions GitHub
Copilot provides without thinking about them. While this can be a fast way to generate very common examples, it quickly
generates code that is suboptimal and difficult to maintain.  The real power of using LLM coding tools like GitHub
Copilot is when it is used by a skilled developer who can evaluate the suggestions and make informed decisions about
which ones to accept and which ones to reject.  It's right in the name: Copilot.  It's there to help you, not to take
over.

### Copilot Chat

Another way to use GitHub Copilot is to use the Copilot Chat feature. This feature allows you to have a conversation
with GitHub Copilot in your editor. You can ask GitHub Copilot questions about your code, and it will provide answers
and suggestions based on the context of your code and the patterns it recognizes in the code you have written so far.

To use Copilot Chat in IntelliJ IDEA, click the Copilot Chat icon in the toolbar on the right side of the editor. This
will open the Copilot Chat window, where you can type your questions to GitHub Copilot.

![Copilot Chat](/images/copilot-chat.png)

With our current code, let's ask GitHub Copilot chat to have main prompt the user for a lower and upper bound and then
call the printSquares method with those values.  Here is a prompt that we can enter into the chat window:

```
In main, prompt the user for the lower and upper bound and then call the printSquares method to print them
```

GitHub Copilot will provide a suggestion for the code to add to the main method to complete this prompt. We can review
the suggestion and copy it into our editor to complete the task.

![Copilot Suggestion](/images/copilot-suggestion.png)

> [!NOTE]
> To launch Copilot Chat in Visual Studio Code, press `Ctrl+Shift+P` to open the Command Palette, then type "Copilot Chat"
> and select the "GitHub Copilot: Open Copilot Chat" command. This will open the Copilot Chat window, where you can type
> your questions to GitHub Copilot.


### Check For Understanding

1. **Question:** How do you install GitHub Copilot in Visual Studio Code?
    - **Answer:** Through the Extensions tab.
2. **Question:** What is the best way to use GitHub Copilot?
    - **Answer:** To review the suggestions it provides and make sure they are correct.

## Sharing Task

- Prompt: Collaborate on a SpringBoot ClassManager project using GitHub Copilot
- Format (individual, pair programming, presentation, group discussion, etc.): Group Project
- Tools: IntelliJ IDEA, GitHub Copilot, GitHub

This group project will give you the opportunity to work together to develop a simple SpringBoot application using
Git and GitHub to collaborate and GitHub Copilot to help you write the code.  This activity will reinforce your ability
to collaborate using Git and GitHub and your ability to use AI tools to help you write code.

### Step 0: Choose a Captain

Choose a team captain who will host and do the initial setup of the project. This member should share screen until later
steps.

### Step 1: Create a New SpringBoot Project

Use Spring Initializr to create a new SpringBoot project with the following dependencies:

- Spring Web
- Spring Data JPA
- PostgreSQL Driver

> [!NOTE]
> For the sake of simplicity, we will not be implementing authentication in this project.

### Step 2: Create the GitHub Repository

The team captain should create a new GitHub repository for the project on their account and push the initial project
code to the repository with IntelliJ IDEA.

### Step 4: Add Other Group Members as GitHub Collaborators

The team captain should add the other group members as collaborators on the GitHub repository.  You can do this by going
to the repository settings and selecting the "Collaborators" tab.

Have each member clone the repository to their local machine so that each of you have a copy.

### Step 5: Develop the Project Using GitHub Copilot

#### Driving

To get used to using AI in a collaborative environment, the team should take turns "driving."  The driver is the person
who is currently sharing their screen and writing code.  When you need to switch drivers, the current driver should
commit and push their changes to the repository, and then the next driver should load their copy into IntelliJ IDEA,
pull the changes using the "Source Control" tab, and then share their screen and continue coding.

#### Task

The team should work together to develop a simple class manager application making heavy use of GitHub Copilot to
generate the code.  This application should provide a simple REST API for managing teachers and students stored in a
PostgreSQL database.  The application should have the following endpoints:

- `GET /teachers` - Get a list of all teachers
- `GET /teachers/{id}` - Get a specific teacher by ID
- `POST /teachers` - Create a new teacher
- `PUT /teachers/{id}` - Update an existing teacher
- `DELETE /teachers/{id}` - Delete a teacher by ID
- `GET /students` - Get a list of all students
- `GET /students/{id}` - Get a specific student by ID
- `POST /students` - Create a new student
- `PUT /students/{id}` - Update an existing student
- `DELETE /students/{id}` - Delete a student by ID

### Step 7: Forking

Once you are all done with the project, each member should fork the repository to their own GitHub account so that they
have their own separate copy for review and portfolio purposes.

## Conclusion

In this lesson, you learned how to use GitHub Copilot to help you write code. GitHub Copilot is a powerful tool that can
provide code suggestions as you write, helping you write code faster and with fewer errors.  Coding assistants like
GitHub Copilot have become a standard tool in the modern developer's toolkit, and learning how to use them effectively
can help you become a more productive and efficient developer.

