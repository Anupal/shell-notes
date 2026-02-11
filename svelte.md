# Svelte Notes
https://svelte.dev/tutorial/svelte

### Introduction
- Applications organized into Components which are reusable self-contained block with HTML, CSS and JS.
- shorthand attributes: `alt={alt}` can also be written as `alt`.
```svelte
// Component.svelte
<script lang="ts">
  let name = 'Svelte';
  let src = './image.gif'
  let alt = 'some image';
</script>

<h1>Hello, {name.toUpperCase()}!</h1>
<img src={src} {alt} />

<style>
  h1 {
    color: goldenrod;
    font-family: 'Comic Sans MS', cursive;
    font-size: 2em;
  }
</style>
```
- We can import Components from other files.
```svelte
// App.svelte
<script lang="ts">
  import Component from './Component.svelte';
</script>

<p>Some content</p>
<Component />
```
- To render html directly you can do:
```svelte
<script lang="ts">
  let string = "<p>This is inside a variable</p>"
</script>
<div>This is without @: {string}</div>
<div>This is with @: {@html string}</div>
```

### Reactivity
- Keeps your DOM in sync with your application state.
- Make a variable reactive by wrapping its value in `$state(...)`.
- Derive the state of one variable and assign it to another using `$derived(var.someOperation())`.
```svelte
<script lang="ts">
  // state reacts to reassignments
  let count = $state(0);

  // state also reacts to mutations
  let numbers = $state([1, 2, 3, 4]);

  // derive a state from another state
  let total = $derived(numbers.reduce((x, y) => x + y, 0));

  function increment() {
    count ++;
  }

  function addNumber() {
    numbers.push(numbers.length + 1);
  }
</script>

<button onclick={increment}>
  Clicked {count}
  {count === 1 ? 'time' : 'times'}
</button>

<p>{numbers.join(' + ')} = {total}</p>

<button onclick={addNumber}>
  Add a number
</button>
```
- `$snapshot` run is used to log current value of a variable
- Alternatively, we can use `$inspect`. These runes are auto-removed from production builds.
```svelte
function addNumber() {
  numbers.push(numbers.length + 1);
  console.log($state.snapshot(numbers));
}

$inspect(numbers);
```

#### Effects
- If a reactive variable is mentioned inside an `$effect` rune, effect run is called when the variable
  changes.
- In below example, `setInterval()` is called everytime the value of `interval` variable changes.
- Since `elapsed` is also reactive, its updated value is displayed in the `p` block.
- It is advised to use `$effect` as a last resort and always use event handlers like `onclick`.
```svelte
<script lang="ts">
  let elapsed = $state(0);
  let interval = $state(1000);

  $effect(() => {
    const id = setInterval(() => {
      elapsed += 1;
    }, interval);

    return () => {
      clearInterval(id);
    };
  });
</script>

<button onclick={() => interval /= 2}>speed up</button>
<button onclick={() => interval *= 2}>slow down</button>

<p>elapsed: {elapsed}</p>
```

#### Universal reactivity
- Storing reactive variables outside of Components to share a global state.
```svelte
// shared.svelte.js
export const counter = $state({
    count: 0
});
```
- Use the variable inside a component
```svelte
// Counter.svelte
<script lang="ts">
  import { counter } from './shared.svelte.js';

  <button onclick{() => counter.count ++}>
    clicks: {counter.count}
  </button>
</script>
```

```svelte
// App.svelte
<script>
  import Counter from './Counter.svelte';
</script>

<Counter />
<Counter />
<Counter />

```

### Props
- `$props` short for Properties is used to pass data from one component to its children.
```svelte
// Component.js
<script>
  let { answer = 'a mystery' } = $props(); // 'a mystery' is the default value
</script>

<p>The answer is {answer}</p>
```

```svelte
// App.js
<script>
  import Component from './Component.svelte';
</script>

<Component answer={42} />
<Component />
```
- passing multiple props
```svelte
// Component.js
<script>
  // destructuring
  let { name, code } = $props();
  console.log(name, code);

  // or use object paths
  let { person } = $props();
  console.log(person.name, person.code);
</script>

<p>The answer is {answer}</p>
```

```svelte
// App.js
<script>
  import Component from './Component.svelte';

  const values = {
    name: 'Anupal',
    code: 1
  }
</script>

// pass by destructuring
<Component name={values.name} code={values.code}/>
<Component {...values}/> // this is called rest property
```

### Logic
- Conditionally render a markup using `{#if }` block.
```svelte
<script lang="ts">
  let count = $state(0);

  function increment() {
    count++;
  }
</script>

<button onclick={increment}>
  Clicked {count}
  {count == 1 ? 'time' : 'times'}
</button>

{#if count > 10}
  <p>Count {count} is greater than 10.</p>
{:else if count < 5}
  <p>Count {count} is less than 5</p>
{:else}
  <p>Count {count} is between 5 and 10.</p>
{/if}
```

#### Loop using `{#each }`
- Loop over array like ds
```svelte
<script>
  const colors = ['red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet'];
  let selected = $state(colors[0]);
</script>

<h1 style="color: {selected}">Pick a colour</h1>

<div>
  {#each colors as color, i}
    <button
      style="background: {color}"
      aria-label="{color}"
      aria-current={selected === color}
      onclick={() => selected = color}
    >{i + 1}</button>
  {/each}
</div>

<style>
  h1 {
    font-size: 2rem;
    font-weight: 700;
    transition: color 0.2s;
  }

  div {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    grid-gap: 5px;
    max-width: 400px;
  }

  button {
    aspect-ratio: 1;
    border-radius: 50%;
    background: var(--color, #fff);
    transform: translate(-2px,-2px);
    filter: drop-shadow(2px 2px 3px rgba(0,0,0,0.2));
    transition: all 0.1s;
    color: black;
    font-weight: 700;
    font-size: 2rem;
  }

  button[aria-current="true"] {
    transform: none;
    filter: none;
    box-shadow: inset 3px 3px 4px rgba(0,0,0,0.2);
  }
</style>
```
- Loop over a map
  - This example also covers re-rendering DOM.
```svelte
<script>
  const emojis = {
    apple: '🍎',
    banana: '🍌',
    carrot: '🥕',
    doughnut: '🍩',
    egg: '🥚'
  };

  // `name` is updated whenever the prop value changes...
  let { name } = $props();

  // ...but `emoji` is fixed upon initialisation
  const emoji = emojis[name];
</script>

<p>{emoji} = {name}</p>
```

```svelte
// App.svelte
<script>
  import Thing from './Thing.svelte';

  let things = $state([
    { id: 1, name: 'apple' },
    { id: 2, name: 'banana' },
    { id: 3, name: 'carrot' },
    { id: 4, name: 'doughnut' },
    { id: 5, name: 'egg' }
  ]);
</script>

<button onclick={() => things.shift()}>
  Remove first thing
</button>

// by default when size of list/map changes, the last Element is removed and DOM of rest is updated.
// adding (thing) will remove first element and then render the rest
{#each things as thing (thing)}
  <Thing name={thing.name} />
{/each}
```

#### Avait value of promises in markup
```svelte
// utils.js

export async function roll() {
  // Fetch a random number from 1 to 6
  // (with a delay, so that we can see it)
  return new Promise((fulfil, reject) => {
    setTimeout(() => {
      // simulate a flaky network
      if (Math.random() < 0.3) {
        reject(new Error('Request failed'));
        return;
      }

      fulfil(Math.floor(Math.random() * 6) + 1);
    }, 1000);
  });
}
```

```svelte
// App.svelte
<script>
  import { roll } from './utils.js';

  let promise = $state(roll());
</script>

<button onclick={() => promise = roll()}>
  roll the dice
</button>

{#await promise}
  <p>...rolling</p>
{:then number}
  <p>you rolled a {number}!</p>
{:catch error}
  <p style="color: red">{error.message}</p>
{/await}
```
