+++
title = "React State Management 1"
type = "chapter"
weight = 330 
+++

## Competency and Learning Objectives

### Competency:

React State Management 

### Learning Objectives:

- I can manage state with the `useState` hook.
- I can use conditional rendering, based on state, to display appropriate components.
- I can lift state and handle events triggered in child components by passing handlers as props.

### Component State

So far, we have only worked with components that are static and stateless.
The `Greeter` component we created in the previous chapter is a good example of a stateless component.
It always renders the same output, regardless of any user interaction or other factors.

We added a property to the component, but that property is passed in from the parent component,
and the component itself does not manage any state and does not change its output once it 
is rendered.

A stateful component is one that manages its own state and can change its output based on that state.
State is typically used to manage data that can change over time, such as user input,
the results of an API call, etc.

### A Stateful Counter Component with  `useState`

Let's create a counter component.  This component will display a number, and
two buttons that will allow the user to increment or decrement the number.
When the number is changed, the component will re-render to display the new number.

Let's first create a new vite application, clear it (as describe in the previous
chapter) and create a file called `Counter.js` in the `src` directory and add the
HTML based on what we know so far:

```jsx
import React from 'react';
export default function Counter() {
  return (
    <div>
      <h1>Counter</h1>
      <p>Current Count: 0</p>
      <button>Decrement</button>
      <button>Increment</button>
    </div>
  );
}
```
Now, let's import and render this component in `App.js`:

```jsx
import React from 'react';
import Counter from './Counter';
export default function App() {
  return (
    <div>
      <Counter />
    </div>
  );
}
```

If you run the application, you should see the counter component rendered with a
current count of 0 and two buttons.  We can click on the buttons, but they don't
do anything yet.

Now, let's add state to the component.  We will use the `useState` hook to manage
the state of the counter.  The `useState` hook takes an initial value as an
argument and returns an array with two elements: the current state value and a
function to update the state value.

We will use a destructuring assignment to assign the two elements of the array
to two variables: `count` and `setCount`.

```jsx
import React, { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <h1>Counter</h1>
      <p>Current Count: {count}</p>
      <button>Decrement</button>
      <button>Increment</button>
    </div>
  );
}
```

As you can see, we are also using the `count` variable to display the current
count in the component.

Try running the application again.  You should see the current count displayed
as 0.  Try changing the initial value passed to `useState` to something else,
like 10 and then run the application again. You should see the current count
displayed as 10.

Now, to make the buttons work, we will add `onClick` event handlers to the buttons
that will call the `setCount` function to update the state value.

```jsx
import React, { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <h1>Counter</h1>
      <p>Current Count: {count}</p>
      <button onClick={() => setCount(count - 1)}>Decrement</button>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

Here, we have set the `onClick` event handler for the Decrement button to call
a lambda function that calls `setCount` with the current count minus 1.
Similarly, we have set the `onClick` event handler for the Increment button to
call a lambda function that calls `setCount` with the current count plus 1.

Try running the application again.  You should be able to click on the buttons
to increment and decrement the count.  The component will re-render each time
the state is updated, and the new count will be displayed.

Notice that our increment and decrement functions just need to update the state
using the value and function returned by `useState`.  We don't need to worry about
telling the component to re-render.  React knows that our component is dependent
on the state variable `count`, and will automatically re-render the component
whenever the state is updated.

### Conditional Rendering Based on State

Let's modify our counter component to display a message when the count reaches a certain
value.  For example, we can display a message when the count reaches 10.

```jsx
import React, { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <h1>Counter</h1>
      <p>Current Count: {count}</p>
      {count === 10 && <p>Count has reached 10!</p>}
      <button onClick={() => setCount(count - 1)}>Decrement</button>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

Here, we have added a conditional rendering statement that checks if the count
is equal to 10.  If it is, we display a message saying "Count has
reached 10!".  

Notice that we did something a bit different here.  Instead of using the ternary
operator, we used the `&&` operator to conditionally render the message.  This is
a common pattern in React for writing a ternary where we only want to render something
if a condition is true, and render nothing if the condition is false.

Try running the application again and clicking the Increment button until the count
reaches 10.  You should see the message displayed when the count reaches 10.

See if you can modify the component to continue displaying the message when the count
is greater than 10, and hide the message when the count is less than 10.

### Lifting State to the Parent Component 

### Handling Events From the Parent Component
