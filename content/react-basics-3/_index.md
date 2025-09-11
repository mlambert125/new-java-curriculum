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

### What is JSX?

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

#### Compiling JSX

JSX is not valid JavaScript, so it needs to be compiled into regular JavaScript before it can
be executed by the browser.  This is typically done using a set of tools to "build" our application
before deploying it. 

Thankfully, this is already handled for us by the Vite tool that we used to create our application
in previous chapters.  Vite gave us a project and set of configuration files that include the necessary
tools to compile our JSX code into regular JavaScript.  As long as we use the template made by
Vite, and the `npm run dev` command to run our application, we don't need to worry about the details
of how JSX is compiled.

### Creating and Clearing a new React Project with Vite

In previous chapters, you learned how to create a React project using Vite.  From this point forward,
we will use this method, but for new projects, we will generally want to also remove the example styles and
components that Vite includes by default.  Here are the steps to do that:

1. Create a new React project with Vite if you haven't already:

   ```bash
   npm create vite@latest my-react-app -- --template react
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


### Creating a Greeting JSX Component

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
       return <h1 className="greeting">Hello, World!</h1>;
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

### Conditional Rendering

### Passing Data with Props

### Creating a User Display Component

### Creating Multiple Instances of a Component with `map()`


