+++
title = "Ai Fundamentals 1"
type = "chapter"
weight = 260
+++

## Competency and Learning Objectives

### Competency:

AI Fundamentals

### Learning Objectives:

- I can write a Java application that integrates with a third-party API (Google Gemini).

## Introduction

In this chapter, we will explore Google Gemini, a generative AI API that will allow us to use generative AI in a
java application. There are several other offerings from cloud providers such as OpenAI's GPT-4, IBM Watson, and Azure
AI. However, for this chapter, we will focus on Google Gemini as it offers a generous free tier and is designed to be
easily integrated into various applications, including Java-based ones.

This chapter will also introduce you to the concept of reading documentation for a third-party API and integrating it
into your Java application. Understanding how to leverage third-party APIs is a crucial skill for modern developers, as
it allows you to enhance your applications with powerful features without having to build everything from scratch.

This chapter assumes that you have a complete understanding of Java and Spring Boot and are comfortable creating Spring
Boot applications.

## What is Google Gemini?

Google Gemini is a generative AI API developed by Google that allows developers to integrate advanced natural language
processing (NLP) capabilities into their applications. It is designed to generate human-like text based on the input it
receives, making it suitable for a wide range of applications, including chatbots, content generation, and more.

Gemini is part of Google's broader AI initiatives and is built on advanced machine learning models. It can understand
context, generate coherent and contextually relevant responses, and even mimic specific writing styles. This makes it a
powerful tool for developers looking to enhance their applications with AI-driven text generation capabilities.

## Getting a Gemini API Key

To get started with Google Gemini, you'll need to sign up for an API key. Follow these steps:

1. Visit [AI Studio's API Key Page](https://aistudio.google.com/apikey)
2. Sign in with your Google account or create one if you don't have it.
3. Click "Create API Key" to generate your API key.
4. Once your API key is generated, copy it and paste into a file that you can keep safe. This key will be used to
   authenticate your requests to the Gemini API.

Make sure to keep your API key secure and do not share it publicly, as it provides access to your account.

## Creating a Simple Java Application

Now that you have your Gemini API key, let's create a simple Java application that uses the Gemini API to generate text.
For now, we will just create a console application that will send a prompt to the Gemini API and print the generated
response.

### Step 1: Set Up Your Java Project

1. **Create a new Java project** in IntelliJ IDEA.  Remember to select "Maven" as the project type.
2. **Add dependencies** to your `pom.xml` file for making HTTP requests. You can use libraries like `OkHttp` or `Apache HttpClient`. For this example, we will use `OkHttp`.

```xml
<dependencies>
    <dependency>
        <groupId>com.google.genai</groupId>
        <artifactId>google-genai</artifactId>
        <version>0.2.0</version> <!-- {x-version-update:google-genai:released} -->
    </dependency>
</dependencies>
```

This dependency will allow you to interact with the Google Gemini API. 


### Step 2: Include the Import Statements

In your 'Main.java' file, start by including the necessary import statements for the libraries you will be using:

```java
import com.google.genai.Client;
import com.google.genai.types.GenerateContentResponse;

import org.apache.http.HttpException;
import java.io.IOException;
import java.util.Scanner;
```

The first two import statements are for the Google Gemini API client and response types, which will allow us to interact
with the Gemini API.

The `org.apache.http.HttpException` is used for handling HTTP exceptions, and `java.io.IOException`
is used for handling input/output exceptions.  These are built-in exceptions that are probably a lot more familiar to
you now that you have been working with Java for a while.


### Step 3: Write the Main Method

Now, let's write the `main` method that will prompt the user for input, send a request to the Gemini API, and print the
generated response. Fill in the `main` method in your `Main.java` file with the following code:

```java
Client client = new Client();

Scanner scanner = new Scanner(System.in);
System.out.println("Enter a question for the model:");
String query = scanner.nextLine();

GenerateContentResponse response = client.models.generateContent("gemini-2.0-flash-001", query, null);

System.out.println(response.text());
```

The first line creates a `Client` object for interacting with the Gemini API. This client will handle the communication
with the API and manage the underlying HTTP requests.  You may notice that there is no API key or authentication being
passed in here. This is because the `Client` object will automatically look for the API key in the environment variables
that we will set up later. This is a common practice to keep sensitive information like API keys secure and not
hard-coded into your application code.

The next three lines should be very familiar to you by now. We are using a `Scanner` object to read user input from the
console. The user is prompted to enter a question, which is then read and stored in the `query` variable.

Next, we call the `generateContent` method on the `client.models` object, passing in the model name
(`"gemini-2.0-flash-001"`), the user's query, and `null` for the optional parameters. This method sends a request to the
Gemini API to generate content based on the provided query and returns a `GenerateContentResponse` object.

Finally, we print the generated text using `response.text()`. This will display the response from the Gemini API in the
console. The generated text will be based on the input query the user provided.

### Setup Environment Variables

When we use the API, we will need to provide the API with our API key.  We did not hard-code the API key directly
into our application code.  Doing so would make our API key vulnerable to exposure if the code is shared or published
to publicly (like to GitHub). Instead, we will use an environment variable file that we will keep out of git.

To do this, you can create a `app.env` file in the root of your project directory and add the following line to it:

```
GOOGLE_API_KEY=your_actual_api_key_here
```

Make sure to replace `your_actual_api_key_here` with the actual API key you obtained from the Gemini API.

#### Adding the `app.env` file to `.gitignore`

To ensure that your `app.env` file is not tracked by Git and does not get pushed to your repository, you should add it
to the project's `.gitignore` file.  You can find this file in the root of your project.  Add this line to the end of
the `.gitignore` file to ensure that the `.env` file is ignored by Git:

```
app.env
```

This will prevent the `.env` file from being included in your version control, keeping your API key secure and private.

#### Creating a Run Configuration

Normally, when you run a Java application, you right-click on the `Main.java` file and select "Run".  However, in
some cases, you need to specify additional configuration options, such as environment variables. In IntelliJ IDEA, you
can create a run configuration to specify these options. This will allow you to run your Java application with the
environment variables you defined in the `.env` file.

To create a run configuration in IntelliJ IDEA:
1. Open your project in IntelliJ IDEA.
2. Click on the "Run" menu at the top of the window.
3. Select "Edit Configurations..." from the dropdown menu.
4. In the "Run/Debug Configurations" dialog, click on the "+" button to add a new configuration.
5. Choose "Application" from the list of configuration types.
6. In the "Name" field, give your configuration a meaningful name (e.g., "Run Gemini App").
7. In the "Main class" field, choose the main class of your application (e.g., `Main`).
8. In the "Environment variables" field, click the folder icon and choose the `app.env` file you created earlier. This
   will load the environment variables from the file into your run configuration.
9. Click "OK" to save the configuration.
10. Now, you can run your application using this configuration by selecting it from the dropdown menu next to the
    "Run" button and clicking the "Run" button.

### Step 4: Run Your Application

Now that you have written the code for your Java application, it's time to run it.  Run the application and try entering
different prompts to see how the Gemini API responds. You should see the generated text printed in the console based on
the input you provided. This is a simple demonstration of how to use the Gemini API to generate text in a Java

### Check For Understanding

1. **Question:**  What is the first step to integrating with a third-party API like Google Gemini?
    - **Answer:** Adding a dependency to your project for the API client library, which allows you to interact with the
      API. In this case, we added the `google-genai` dependency to our Maven `pom.xml` file.
2. **Question:**  Why do we create an environment variable file (`app.env`) instead of hard-coding the API key directly
   into the code?
    - **Answer:**  Creating an environment variable file helps keep sensitive information like API keys secure and private.
      Hard-coding the API key directly into the code can lead to accidental exposure if the code is shared or published
      publicly (e.g., on GitHub).

## Practice/Project Task

- Activity Description: Movie Management Spring Boot Application
- Prompt:
    - Create a simple Spring Boot application that allows users to manage a list of movies.
    - Your application only needs one entity: `Movie`, which should have the following attributes:
        - Title (String)
        - Rating (int)
        - Description (String)
    - Your application only needs a single controller: `MovieController`, which should have the following endpoints:
        - `GET /movies`: Get a list of all movies.
        - `POST /movies`: Add a new movie.
    - Users should be able to add a movie with a title and rating.
    - The description of the movie should be generated using the Google Gemini API based on the title provided by the user.
    - Display the list of movies with their title, rating, and generated description.
- Format (individual, pair programming, presentation, group discussion, etc.):
- Tools: IntelliJ IDEA, Google Gemini API
- Time Estimate: 120 minutes
- Expected Outcomes: 
    - **Green**: The application successfully integrates with the Google Gemini API to generate movie descriptions based on user input. 
      Users can add movies with titles and ratings, and the generated description is displayed alongside the movie details.
    - **Yellow**: The application integrates with the Google Gemini API, but there are some issues with generating descriptions. 
      For example, the descriptions may not be relevant or coherent. Users can still add movies, but the description may be 
      empty or incorrect.
    - **Red**: The user failed to create a functional Spring Boot application.

## Conclusion

In this chapter, we explored the basics of integrating with the Google Gemini API in a Java application. We learned how
to set up a Java project, include the necessary dependencies, and write code to interact with the Gemini API. We also
discussed the importance of keeping sensitive information like API keys secure by using environment variables instead of
hard-coding them into the application code.

