+++
title = "React State Management 3"
type = "chapter"
weight = 350 
+++

## Competency and Learning Objectives

### Competency:

React State Management 

### Learning Objectives:

- I understand the component life-cycle and can use the `useEffect` hook to perform side effects in function components.
- I can utilize the `useEffect` hook to fetch data when a component mounts and update state with the fetched data.

### Understanding the Component Life-Cycle

React components go through a life-cycle that includes mounting, updating, and
unmounting phases. Understanding these phases is crucial for managing side
effects in your applications.

Each phase has specific hooks that can be used to perform actions at different points
in the component's life-cycle.

1. **Mounting**: This phase occurs when a component is being inserted into the DOM.
2. **Updating**: This phase occurs when a component is being re-rendered as a
result of changes to either its props or state.
3. **Unmounting**: This phase occurs when a component is being removed from the DOM.

### Using `useEffect` to Perform Side Effects

In function components, the `useEffect` hook is used to perform side effects. Side
effects are code that we want to run every time one of the component life-cycle
phases occurs.

### Performing a Side Effect on Component Mount

You can use the `useEffect` hook to perform a side effect when a component mounts
for the first time. This is done by passing an empty dependency array (`[]`) as the
second argument to `useEffect`. This tells React to only run the effect once, after
the initial render.

#### Example: Logging a Message on Component Mount

```jsx
import React, { useState, useEffect } from 'react';

function MyComponent() {
  const [data, setData] = useState(null);

  useEffect(() => {
    // This code runs once when the component mounts
    console.log('Component mounted');
    // You can perform side effects here, such as fetching data
  }, []); // Empty dependency array

  return (
    <div>
      <h1>My Component</h1>
      {data ? <p>Data: {data}</p> : <p>Loading...</p>}
    </div>
  );
}

export default MyComponent;
```

This example demonstrates how to use the `useEffect` hook to log a message when the
component mounts.  

#### Example: Fetching Data with `useEffect` on Component Mount

A more practical example is fetching data from an API when the component mounts.

We can use the public pokemon API to demonstrate this by creating a component
that fetches and displays a list of Pokémon when it mounts.:

```jsx
import React, { useState, useEffect } from 'react';

function PokemonList() {
  const [pokemon, setPokemon] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const response = await fetch('https://pokeapi.co/api/v2/pokemon?limit=10');
      const data = await response.json();
      setPokemon(data.results);
    };
    fetchData();
  }, []); // Empty dependency array ensures this runs only once on mount
    return (
        <div>
          <h1>Pokémon List</h1>
          <ul>
          {pokemon.map((p) => (
            <li key={p.name}>{p.name}</li>
          ))}
          </ul>
        </div>
    );
}

export default PokemonList;
```

In this example, the `useEffect` hook is used to fetch a list of Pokémon from the
PokeAPI when the `PokemonList` component mounts. The fetched data is then stored in
the component's state using the `setPokemon` function, and the list of Pokémon is
rendered in the component.

You may notice that we created a function inside the `useEffect` callback and then 
called it immediately without `await`. This is because the `useEffect` callback itself cannot be
async, but we can define and call an async function inside it.  This is a common pattern
when dealing with asynchronous operations in `useEffect`.

It can look a bit odd at first, but with practice, it becomes second nature.
`useEffect` must not be async (it has to return immediately), but we can
define an async function inside it and call it immediately.  This will cause
the async function to run in the background, and update state when it completes
which will cause a re-render to display the pokemon.

### Hooking into the Unmount Life-Cycle Event

Sometimes, side effects need to be cleaned up when a component unmounts. This is
done by returning a cleanup function from the `useEffect` hook. The cleanup function
will be called when the component is about to unmount.

#### Example: Logging a Message on Component Unmount

```jsx
import React, { useState, useEffect } from 'react';
function MyComponent() {
  useEffect(() => {
    // This code runs when the component mounts
    console.log('Component mounted');

    // Cleanup function runs when the component unmounts
    return () => {
      console.log('Component unmounted');
    };
  }, []); // Empty dependency array

  return (
    <div>
      <h1>My Component</h1>
    </div>
  );
}

export default MyComponent;
```

What we have done here is create a mounted handler as before, and then returned a function
from the `useEffect` callback.  This returned function is the unmount handler, and
will be called when the component is about to be removed from the DOM.

### Performing a Side Effects on the update Life-Cycle Event 

You can also use the `useEffect` hook to perform side effects when a component
updates due to changes in its props or state. This is done by passing an array
of which state or props values to watch for changes as the second argument to
`useEffect`. When any of the values in the dependency array change, the effect
will run again.

#### Example: Logging a Message on State Update in a Counter Component

```jsx
import React, { useState, useEffect } from 'react';
function Counter() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    // This code runs every time the 'count' state changes
    console.log(`Count updated: ${count}`);
  }, [count]); // Dependency array with 'count'

  return (
    <div>
      <h1>Counter: {count}</h1>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}

export default Counter;
```

In this example, the `useEffect` hook logs a message to the console every time the
`count` state changes. The dependency array `[count]` tells React to run the effect
whenever the `count` state is updated.

We can pass any value created with `useState` or any prop passed to the component
in the dependency array.  This allows us to run side effects in response to changes
in state (internally) or props (externally).

### Putting it All Together (Handling all three kinds of side effects)

We can combine all of these handlers to have our counter component log messages when
it mounts, updates, and unmounts:

```jsx
import React, { useState, useEffect } from 'react';
function Counter() {
    const [count, setCount] = useState(0);
    useEffect(() => {
        // This code runs when the component mounts
        console.log('Component mounted');

        // Cleanup function runs when the component unmounts
        return () => {
            console.log('Component unmounted');
        };
    }, []); // Empty dependency array (for mount and unmount)

    useEffect(() => {
        // This code runs every time the 'count' state changes
        console.log(`Count updated: ${count}`);
    }, [count]); // Dependency array with 'count' (for updates)

    return (
        <div>
            <h1>Counter: {count}</h1>
            <button onClick={() => setCount(count + 1)}>Increment</button>
        </div>
    );
}

export default Counter;
```

In this example, we have two `useEffect` hooks:
1. The first `useEffect` hook handles the mount and unmount phases by logging messages
when the component mounts and unmounts.
2. The second `useEffect` hook handles the update phase by logging a message every time
the `count` state changes.

This demonstrates how to effectively manage side effects in a React function component
using the `useEffect` hook for all three phases of the component life-cycle.

### Summary

In this lesson, we explored the component life-cycle in React and how to use the
`useEffect` hook to manage side effects during the mounting, updating, and unmounting
phases of a component. We learned how to perform actions when a component mounts,
update in response to state or prop changes, and clean up when a component unmounts.

Understanding the component life-cycle and effectively using the `useEffect` hook is essential
for building React applications.  Nearly every application makes use of side effects
to fetch data, set up subscriptions, or perform other operations that need to occur
at specific points in a component's life-cycle.  


