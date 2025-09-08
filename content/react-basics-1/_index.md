+++
title = "React Basics 1"
type = "chapter"
weight = 300 
+++

## Competency and Learning Objectives

### Competency:

React Basics

### Learning Objectives:

- I can explain the motivations and importance of JavaScript UI frameworks.
- I can explain the advantages, drawbacks and limitations of using React.

## Introduction

In this chapter, we will explore the fundamentals of React, a popular JavaScript
library for building user interfaces. We will cover the motivations behind
using React, its core concepts, and how it compares to other UI frameworks. By
the end of this chapter, you will have a solid understanding of why React is
widely used in web development and how to get started with it.

## What is a Framework?

In software development, a framework is a pre-defined structure and set of
conventions and tools that provide a foundation for building applications.
When working with a normal application, we build from the ground up, starting
with an empty file and adding code as needed.  A framework, on the other hand,
provides a skeleton or blueprint that developers can use to build their
applications more efficiently.

In a framework, we typically run a command to generate a new project, and we
add code to create our application in specific files and directories defined by
the framework.  When we run our application, the framework takes care of 
starting the application and laying the foundation, and our code only concerns
itself with the specific functionality that we want to implement.

## Why Use a JavaScript UI Framework?

The web platform consists primarily of HTML, CSS, and JavaScript.  These three
technologies provide everything that we need to create dynamic, interactive
web applications and drive most of the web that you interact with today.
However, as web applications have become more complex, managing the user
interface (UI) and state of the application using just these core technologies
can become challenging.  This is where JavaScript UI frameworks come into play.

JavaScript UI frameworks, such as React, Angular, and Vue.js, provide a
structured way to build and manage the UI of web applications.  They offer a set
of tools, libraries, and conventions that help developers create complex UIs
that respond to user interactions and changes in application state more easily
than using plain JavaScript.

### Advantages of Using a JavaScript UI Framework
- **Component-Based Architecture**: Most UI frameworks, including React,
  promote a component-based architecture. This means that the UI is broken down
  into smaller, reusable components, making it easier to manage and maintain
  the codebase.
- **State Management**: UI frameworks often provide built-in mechanisms for
   managing application state. This helps in keeping the UI in sync with the
   underlying data, reducing the chances of bugs and inconsistencies.
- **Declarative Syntax**: Many frameworks use a declarative syntax, allowing
  developers to describe what the UI should look like based on the current
  state. This makes the code more readable and easier to understand.
- **Ecosystem and Community**: Popular UI frameworks have large ecosystems
  with numerous libraries, tools, and community support. This can significantly
  speed up development and provide solutions to common problems.
- **Cross-Browser Compatibility**: UI frameworks often handle cross-browser
  compatibility issues, allowing developers to focus on building features rather
  than worrying about browser quirks.

### Drawbacks and Limitations

- **Learning Curve**: Each UI framework has its own learning curve. Developers
  need to invest time in learning the framework's concepts, syntax, and best
  practices.
- **Performance Overhead**: Some frameworks may introduce performance overhead
  due to their abstractions and additional layers. However, this can often be
  mitigated with proper optimization techniques.
- **Dependency on the Framework**: Relying heavily on a specific framework
  can lead to challenges if the framework becomes deprecated or if the project
  needs to switch to a different technology.
- **Complexity**: For simple applications, using a full-fledged UI framework
  may introduce unnecessary complexity. In such cases, plain JavaScript or
  lightweight libraries may be more appropriate.

## ReactJS

React is by far the most popular JavaScript UI framework in use today.  It was
developed by Facebook and released as an open-source project in 2013.  React has
gained widespread adoption due to its simplicity, performance, and flexibility.

### Core Concepts of React

- **Components**: React applications are built using components, which are
  reusable building blocks that encapsulate both the UI and the logic. Components
  can be functional or class-based, with functional components being the preferred
  approach in modern React development.
- **JSX**: React uses JSX (JavaScript XML), a syntax extension that allows
  developers to write HTML-like code within JavaScript. JSX makes it easier to
  visualize the structure of the UI and how it relates to the underlying logic.
- **Virtual DOM**: React uses a virtual DOM (Document Object Model) to optimize
  updates to the UI. When the state of a component changes, React creates a
  virtual representation of the DOM and compares it to the previous version. It
  then calculates the minimal set of changes needed to update the actual DOM,
  resulting in improved performance.
- **State and Props**: React components can manage their own state, which
  represents the data that can change over time. Props (short for properties) are
  used to pass data from parent components to child components. This unidirectional
  data flow helps maintain a clear and predictable structure in the application.
- **Lifecycle Methods**: Class-based components in React have lifecycle methods
  that allow developers to hook into different stages of a component's life,
  such as mounting, updating, and unmounting. Functional components can achieve
  similar functionality using hooks, such as `useEffect`.

