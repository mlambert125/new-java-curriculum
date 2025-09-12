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

Sometimes, we want to share state between components.  For example, we might have three
of our counters on the page and we want to have them all share the same count value.

To do this, we need to lift the state up to the parent component.  This means that
we will move the state management from the `Counter` component to the `App` component,
and then pass the state value and the function to update the state value as props
to the `Counter` component.

Let's modify our `App` component to manage the state for the count:

```jsx
import React, { useState } from 'react';
import Counter from './Counter';

export default function App() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <Counter count={count} setCount={setCount} />
      <Counter count={count} setCount={setCount} />
      <Counter count={count} setCount={setCount} />
    </div>
  );
}
```

As you can see, we have moved our counter's state management to the `App` component on
this line:

```jsx
  const [count, setCount] = useState(0);
```

We are also rendering three `Counter` components, and passing the `count` and `setCount`
as props to each of them.  This means that all three `Counter` components will share the same
counter state.

Let's modify our `Counter` component to use the `count` and `setCount` props instead of
managing its own state:

```jsx
import React from 'react';

export default function Counter({ count, setCount }) {
  return (
    <div>
      <h1>Counter</h1>
      <p>Current Count: {count}</p>
      {count >= 10 && <p>Count has reached 10!</p>}
      <button onClick={() => setCount(count - 1)}>Decrement</button>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

If you run the application now, you should see three counters on the page that all
share the same count value.  Clicking the Increment or Decrement buttons on any of
the counters will update the count value for all of them.

### Computed State

Let's say we want to go back to having separate counts for each counter, but we also want to
display the total count of all counters in the `App` component.

We will continue managing the individual counter states in the `App` component, but we will also
compute the total count based on the individual counts.

First, let's modify our `App` component to manage the state for three separate counts, 
and to prepare a spot to display the total count:

```jsx
import React, { useState } from 'react';
import Counter from './Counter';

export default function App() {
  const [count1, setCount1] = useState(0);
  const [count2, setCount2] = useState(0);
  const [count3, setCount3] = useState(0);

  return (
    <div>
      <Counter count={count1} setCount={setCount1} />
      <Counter count={count2} setCount={setCount2} />
      <Counter count={count3} setCount={setCount3} />
      <h2>Total Count: </h2>
    </div>
  );
}
```

Next, we will compute the total count based on the individual counts and display it in the
`App` component:

```jsx
import React, { useState } from 'react';
import Counter from './Counter';

export default function App() {
  const [count1, setCount1] = useState(0);
  const [count2, setCount2] = useState(0);
  const [count3, setCount3] = useState(0);

  return (
    <div>
      <Counter count={count1} setCount={setCount1} />
      <Counter count={count2} setCount={setCount2} />
      <Counter count={count3} setCount={setCount3} />
      <h2>Total Count: {count1 + count2 + count3}</h2>
    </div>
  );
}
```

All that we had to do was add an expression in curly braces to compute the total count:

```jsx
      <h2>Total Count: {count1 + count2 + count3}</h2>
```

If you run the application now, you should see three counters on the page that each
have their own count value, and a total count that is the sum of all three counts.

### Handling Events From the Parent Component

In the example above, we passed a variable down to the `Counter` component, which is
something we've done before.  But we also passed a function down to the `Counter` component,
which is something new, and it is a very powerful technique.

Being able to pass a function down to a child component means that we can have interactivity
in a child component (for example a button click) that calls a function that can be customized
by the parent component.

Let's make a new component called `FancyButton` that will render a nice looking button.
Because we want to this to be a general purpose button, we can't really hard code what
happens when the button is clicked.  Instead, we will have our fancy button accept an
`onClick` property that will be a function to call when the button is clicked.

We will also add a `text` property to specify the text to display on the button.

```jsx
import React from 'react';
export default function FancyButton({ onClick, text}) {
  return (
    <button
      onClick={onClick}
      style={{
        backgroundColor: 'purple',
        color: 'white',
        border: 'none',
        borderRadius: '5px',
        padding: '10px 20px',
        cursor: 'pointer',
      }}
    >
        {text}
    </button>
  );
}
```

The actual button in our `FancyButton` component handles the `onClick` event by calling the
`onClick` function that was passed in as a property.  This means that the parent
that uses this `FancyButton` component can specify what happens when the button is clicked.

>[!note]
> The style property here has a different syntax than what we've encountered so far.
> Instead of being a string, it is an object.  The keys of the object are the CSS property names
> in camelCase, and the values are the CSS property values as strings.  This is
> a special nicer syntax that React supports specifically for the `style` property.

Now, let's use our `FancyButton` component in our `Counter` component instead of the
regular HTML button:

```jsx
import React from 'react';
import FancyButton from './FancyButton';

export default function Counter({ count, setCount }) {
  return (
    <div>
      <h1>Counter</h1>
      <p>Current Count: {count}</p>
      {count >= 10 && <p>Count has reached 10!</p>}
      <FancyButton onClick={() => setCount(count - 1)} text="Decrement" />
      <FancyButton onClick={() => setCount(count + 1)} text="Increment" />
    </div>
  );
}
```

If we run the application now, we should see our fancy buttons instead of the regular
HTML buttons.  The buttons should still work the same way, because we are passing
the same `onClick` functions to the `FancyButton` components.

### Bringing It All Together to Add a Reset Button

Now, let's modify our `App` component to add a reset button that will reset all
the counters to 0.  We will use our `FancyButton` component for this button
as well:

```jsx
import React, { useState } from 'react';
import Counter from './Counter';
import FancyButton from './FancyButton';

export default function App() {
  const [count1, setCount1] = useState(0);
  const [count2, setCount2] = useState(0);
  const [count3, setCount3] = useState(0);

  function resetCounts () {
    setCount1(0);
    setCount2(0);
    setCount3(0);
  }

  return (
    <div>
      <Counter count={count1} setCount={setCount1} />
      <Counter count={count2} setCount={setCount2} />
      <Counter count={count3} setCount={setCount3} />
      <h2>Total Count: {count1 + count2 + count3}</h2>
      <FancyButton onClick={resetCounts} text="Reset All Counts" />
    </div>
  );
}
```

Here, we have added a `resetCounts` function inside of our component function
that resets all of the counts by calling the `setCount` functions to set
all the counts to 0.

### Conclusion

In this chapter, we learned how to manage state in React components using the `useState` hook.
We also learned how to use conditional rendering based on state to display appropriate components.
We learned how to lift state to a parent component to share state between multiple child components.
Finally, we learned how to handle events triggered in child components by passing event handlers
as props from the parent component.

With these advanced techniques for composing components and managing state and communication
between components, we can build complex and interactive user interfaces with React.

In the next chapter, we will learn how to manage forms with React to obtain data from users
and update state based on that data.

