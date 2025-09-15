+++
title = "React Basics 3"
type = "chapter"
weight = 320 
+++

## Competency and Learning Objectives

### Competency:

React Basics

### Learning Objectives:

- I can incorporate JSX syntax in my React components.
- I can use conditional rendering.
- I can use props to pass data from one component to another
- I can explain the role of props in React components.
- I can create multiple instances of a reusable component using the `map()` function.

## What is JSX?

As you've learned from working with native frameworkless JavaScript, HTML and JavaScript
are two different languages with a border between them.  This sometimes becomes inconvenient
when you are using JavaScript to create or manipulate HTML elements.  Consider a case where
you want to create a greeting message on a web page in response to a user action.  You might
write something like this:

```js
function createGreeting() {
    const greetingMessage = document.createElement('h1');
    greetingMessage.className = 'greeting';
    greetingMessage.textContent = 'Hello, World!';
    document.getElementById('messageContainer').appendChild(greetingMessage);
}
```

This code creates an `h1` element, styles it with a css class, sets its text content, and
adds it to a `messageContainer` div.  While this works, it is a bit verbose and doesn't
really look or feel like how we would have written it if it was just static HTML on a page:

```html
<h1 style="color: blue;">Hello, World!</h1>
```

JSX is a syntax extension to JavaScript that allows us to write HTML-like code within our
JavaScript files.  This makes it easier to visualize the structure of our UI components
and reduces the amount of boilerplate code needed to create and manipulate DOM elements.

Here is how we could rewrite the greeting message example using JSX:

```jsx
const Greeting = () => {
    return <h1 className="greeting">Hello, World!</h1>;
};
```

In this example, we define a `Greeting` component that returns an `h1` element with the
desired style and text content.
 
This makes the greeting, but it doesn't actually add it to the page.  To do that,
we can use the `ReactDOM.render()` method to render the component into a specific DOM element:

```jsx
import React from 'react';
import ReactDOM from 'react-dom';

const Greeting = () => {
    return <h1 className="greeting">Hello, World!</h1>;
};
ReactDOM.render(<Greeting/>, document.getElementById('messageContainer'));
```

### Compiling JSX

JSX is not valid JavaScript, so it needs to be compiled into regular JavaScript before it can
be executed by the browser.  This is typically done using a set of tools to "build" our application
before deploying it. 

Thankfully, this is already handled for us by the Vite tool that we used to create our application
in previous chapters.  Vite gave us a project and set of configuration files that include the necessary
tools to compile our JSX code into regular JavaScript.  As long as we use the template made by
Vite, and the `npm run dev` command to run our application, we don't need to worry about the details
of how JSX is compiled.

### Check for Understanding

- What is JSX?

    Ansewr: JSX is a syntax extension for JavaScript that allows developers to write HTML-like
    code within JavaScript files. 

- How does JSX differ from regular JavaScript and HTML?

    Answer: JSX allows you to write HTML and JavaScript together in the same file.

## Creating and Clearing a new React Project with Vite

In previous chapters, you learned how to create a React project using Vite.  From this point forward,
we will use this method, but for new projects, we will generally want to also remove the example styles and
components that Vite includes by default.  Here are the steps to do that:

1. Create a new React project with Vite if you haven't already:

   ```bash
   npm create vite@latest
   cd my-react-app
   npm install
   ```
2. Open the project in Visual Studio Code.
3. Open the terminal in Visual Studio Code and run the development server:

   ```bash
   npm run dev
   ```
   This will start the development server and open the application in your default web browser.
   Notice that the page displays a welcome message and some links to documentation.
   Notice also that the page has some styles applied to it.
   Our goal is to remove these styles and the example content.
4. Delete the `src/assets/react.svg` file.  (This is the React logo that Vite includes by default.)
5. Open the `src/App.css` file and clear all of its contents so that it is an empty file.
6. Open the `src/index.css` file and clear all of its contents so that it is an empty file.
7. Open the `src/App.jsx` file and replace its contents with the following code:
   ```jsx
   import React from 'react';

   function App () {
       return (
           <div>
               <h1>My React App</h1>
           </div>
       );
   }

   export default App;
   ```
8. Save all files and refresh the web page in your browser.  You should now see a blank
   page with just the "My React App" heading in the boring default font and style.

### Check for Understanding

- What command do you use to create a new React project with Vite?

    Answer: `npm create vite@latest`

- How do you start the development server for a React project created with Vite?

    Answer: `npm run dev`

## Creating a Greeting JSX Component

Now that we have a clean React project, we can start adding our own components using JSX.
Take a look at the `App.jsx` file that we just created.  Notice that this is a `jsx` file
and that it contains JSX code.  The `App` component is a simple functional component that
returns a `div` element with a heading inside it.  This is a good starting point for our
application.

We can just start putting more JSX code directly into the `App` component, but it is
often better to create separate components for different parts of our UI.  This makes
our code more modular and easier to maintain.  It also allows us to reuse components in different
parts of our application.

So, let's leave the `App` component alone for now and create a new component:

In the `src` directory, create a new file named `Greeting.jsx` and add the following code:

   ```jsx
   import React from 'react';

   const Greeting = () => {
       return <h1 className="greeting">Good Morning!</h1>;
   };

   export default Greeting;
   ```

This code defines a `Greeting` component that returns an `h1` element with the desired
style and text content.  Notice that we use `className` instead of `class` to set the CSS class
of the element.  This is because `class` is a reserved word in JavaScript.

Let's also add that CSS class to our `index.css` file so that the greeting looks a bit nicer.
Add the following CSS to the `src/index.css` file:

```css
.greeting {
    color: blue;
    font-family: Arial, sans-serif;
    text-align: center;
}
```

>[!note] Why the `index.css` file?
> The `index.css` file is a good place to put global styles that apply to the entire application
> rather than styles that are specific to a single component.  We could have also created a separate
> CSS file for the `Greeting` component, but for this simple example, it is fine to create the style
> in the `index.css` file.

Now save all files and refresh the web page in your browser.  You should still see just the
"My React App" heading.  This is because all react applications start with a single root component,
which is the `App` component in our case, and that component is the only one that is rendered
to the page.  To build our application, we create components and then use them within the
`App` component or other components that are used by the `App` component.

#### Using the Greeting Component in App.jsx

You may have notice that our `Greeting` component contained a final line that said
`export default Greeting;`.  This line makes the `Greeting` component available to other
files that import it.  Importing and exporting is how we share code between different
files in JavaScript.  To use the `Greeting` component in our application,
we need to import it into the `App.jsx` file and then use it within the `App` component.

In the `src` directory, open the `App.jsx` file and modify it to import and use the `Greeting` component:
    
```jsx
import React from 'react';
import Greeting from './Greeting';

const App = () => {
     return (
          <div>
            <Greeting />
          </div>
     );
};

export default App;
```

Now save all files and refresh the web page in your browser.  You should now see the
"Hello, World!" greeting in blue text.

### Check for Understanding

- How do you create a new React component using JSX?

    Answer: Create a new `.jsx` file, define a functional component that returns JSX code,
    and export the component.

- How do you use a React component in another component?

    Answer: Import the component using an `import` statement and then use it as a JSX tag
    within the parent component's JSX code.

## Conditional Rendering

Let's make a new component called `EveningGreeting` that displays a different greeting message.
Create a new file named `EveningGreeting.jsx` in the `src` directory and add the following code:

```jsx
import React from 'react';
const EveningGreeting = () => {
    return <h1 className="greeting">Good Evening!</h1>;
};
export default EveningGreeting;
```

Now we have two different greeting components, but we only want to display one of them
based on the time of day.  We can use conditional rendering to achieve this.

Open the `App.jsx` file and modify it to conditionally render either the `Greeting` or
`EveningGreeting` component based on the current time:

```jsx
import React from 'react';
import Greeting from './Greeting';
import EveningGreeting from './EveningGreeting';

const App = () => {
    const currentHour = new Date().getHours();
    const isMorning = currentHour < 12;

    return (
        <div>
            {isMorning ? <Greeting /> : <EveningGreeting />}
        </div>
    );
};
export default App;
```

Now save all files and refresh the web page in your browser.  You should see either
the "Good Morning!" or "Good Evening!" greeting based on the current time of day.

If you want to test both greetings, you can temporarily change the `isMorning` variable
to `true` or `false` to see the different greetings.

Notice that we had to import the `EveningGreeting` component at the top of the file
in order to use it.  This is because each file is a separate module in JavaScript
and we need to explicitly import any code that we want to use from other modules.

Let's look at the conditional rendering part of the code:

```jsx
{isMorning ? <Greeting /> : <EveningGreeting />}
```

This line uses a JavaScript ternary operator to choose which component to render based
on the value of the `isMorning` variable.  If `isMorning` is `true`, the `Greeting` component
is rendered; otherwise, the `EveningGreeting` component is rendered.

The ternary operator, which you learned in previous chapters, is a concise way to write an `if-else` statement
in a single line of code.  It has the following syntax:

```js
condition ? expressionIfTrue : expressionIfFalse
```

In our case, the `condition` is `isMorning`, the `expressionIfTrue` is `<Greeting />`,
and the `expressionIfFalse` is `<EveningGreeting />`.

### Check for Understanding

- How do you conditionally render components in React?

    Answer: Use a JavaScript expression, such as the ternary operator, within curly braces
    in the JSX code to choose which component to render based on a condition.

- What is the syntax of the ternary operator?

    Answer: `condition ? expressionIfTrue : expressionIfFalse`

## Passing Data with Props

In addition to conditional rendering, we can also pass data to our components using props.
Props (short for "properties") are a way to pass data from a parent component to a child component.
Let's modify our `Greeting` component to accept a `name` prop and display a personalized greeting message.
First, update the `Greeting.jsx` file to accept a `name` prop:

```jsx
import React from 'react';
const Greeting = ({ name }) => {
    return <h1 className="greeting">Good Morning, {name}!</h1>;
};
export default Greeting;
```

We define properties for a component by creating an object parameter in the function definition,
and then creating named properties for that object.  In this case, we created a `name` property
by using destructuring assignment in the function parameter list.

Once we have defined a prop in this way, we can use it within the component's JSX code.

Now, update the `App.jsx` file to pass a `name` prop to the `Greeting` component:

```jsx
import React from 'react';
import Greeting from './Greeting';
import EveningGreeting from './EveningGreeting';

const App = () => {
    const currentHour = new Date().getHours();
    const isMorning = currentHour < 12;
    const userName = 'Alice'; // You can change this to any name you like

    return (
        <div>
            {isMorning ? <Greeting name={userName} /> : <EveningGreeting />}
        </div>
    );
};
export default App;
```

In this code, we define a `userName` variable and pass it as a prop to the `Greeting`
component when it is rendered.  We pass properties to a component by adding attributes
to the component's JSX tag. In this case, we added a `name` attribute to the
`<Greeting />` tag and set its value to the `userName` variable.

Now save all files and refresh the web page in your browser.  You should see a personalized
greeting message that includes the name you specified in the `userName` variable.

### Check for Understanding

- How do you define and use props in a React component?

    Answer: Add a deconstructed object parameter to the component function definition.

- How do you pass props to a React component?
    Answer: Add attributes to the component's JSX tag with the desired prop names and values.

## Creating Multiple Instances of a Component

We can use props to create multiple instances of a component with different data.
Let's modify our `App` component to display a list of greetings for multiple users.

First, update the `App.jsx` file to include a list of user names and render a `Greeting` component for each name:

```jsx
import React from 'react';
import Greeting from './Greeting';
import EveningGreeting from './EveningGreeting';

const App = () => {
    const currentHour = new Date().getHours();
    const isMorning = currentHour < 12;

    return (
        <div>
            <Greeting name="Alice" />
            <Greeting name="Bob" />
            <Greeting name="Charlie" />
        </div>
    );
};
export default App;
```

In this code, we render three instances of the `Greeting` component, each with a different
`name` prop.  This will display three personalized greeting messages on the page.

Now save all files and refresh the web page in your browser.  You should see three
greeting messages, one for each name.

### Check for Understanding

- How do you create multiple instances of a React component with different data?

    Answer: Render the component multiple times with different props.

## Using `map()` to Render Multiple Components Based on an Array

Usually when we want to render multiple instances of a component, we have a list of data
that corresponds to the components we want to create.  In this case, we can use the `map()` function
to iterate over the list and create a component for each item in the list.

`map` in javascript is used to transform an array of data into a new array of data.  In
this case, we want to transform an array of names into an array of `Greeting` components.

Let's modify our `App` component to use `map()` to render a list of greetings for multiple users.

Update the `App.jsx` file to include an array of user names and use `map()` to render a 
`Greeting` component for each name:

```jsx
import React from 'react';
import Greeting from './Greeting';
import EveningGreeting from './EveningGreeting';

const App = () => {
    const currentHour = new Date().getHours();
    const isMorning = currentHour < 12;
    const userNames = ['Alice', 'Bob', 'Charlie', 'Diana'];

    return (
        <div>
            {{ userNames.map((name) => <Greeting key={name} name={name} />) }}
        </div>
    );
};
export default App;
```

In this code, we define an array of user names and use the `map()` function to convert
the array of names into an array of `Greeting` components.  Each component is passed a `name` prop
with the corresponding name from the array.

Now save all files and refresh the web page in your browser.  You should see a list of
greeting messages, one for each name in the `userNames` array.

### Check for Understanding

- How do you use the `map()` function to render multiple instances of a React component?

    Answer: Use the `map()` function to iterate over an array of data and return a component
    for each item in the array.

## Expression-Based Approach

React uses a functional/expression-based approach to building user interfaces.

As you have probably noticed, this means that we use the functional versions of 
control structures like `if` statements and loops rather than the statement-based
versions.

- We don't use `if` statements to conditionally render components; instead, we use
the ternary operator.
- We don't use `for` loops to iterate over arrays to create multiple components;
instead, we use the `map()` function.
- We don't use `switch` statements to choose between multiple components to render;
instead, we can use chained ternary operators or helper functions that return
the desired component.

### Check for Understanding

- Why does React use an expression-based approach to building user interfaces?

    Answer: It allows for a more declarative style of programming, making it easier
    to understand and reason about the UI based on the current state of the application.

## The Magic of React and Vite

At this point, this way of creating an application probably seems a bit strange and
a bit magical.  With native javascript, HTML, and CSS, our code all loads and runs
in an *imperative* way.  We write code that tells the browser *how* to do things
step-by-step.  With a React application, we write *declarative* code that describes
*what* we want the UI to look like based on the current state of the application.

This approach is very powerful and allows us to create complex user interfaces
with relatively little code.  However, it does require a different way of thinking
about how to build applications.

The Vite tool that we used to create our React application handles all of the
complexity of setting up a build process that compiles our JSX code into regular
JavaScript that the browser can understand.  React itself takes care of rendering
the UI based on the current state of the application.

A lot is happening behind the scenes to make this work, but as long as we
use the tools and libraries that are designed to work with React, we can focus
on writing our application code without worrying about the details of how it all
works.

### Check for Understanding

- What is the difference between imperative and declarative programming?

    Answer: Imperative programming focuses on *how* to do things step-by-step,
    while declarative programming focuses on *what* the desired outcome is
    based on the current state.

## Conclusion

In this chapter, you learned the basics of creating a React application using JSX,
components, props, and conditional rendering.  You also learned how to create multiple
instances of a component using the `map()` function.

React is a powerful library for building user interfaces, and it is the industry standard
way to build modern web applications.  Understanding and being able to use React is an
absolutely essential skill for a modern web developer, and at most companies, it is 
the primary way that web applications are built.

In the next chapter, you will learn how to manage state in a React application, and
how to connect your React application to a backend API to create a full-stack web application
that allows users to create, read, update, and delete data.
