
## Create React Elements and Render Them To The Dom

In [this video, we create three elements and render them](https://teamtreehouse.com/library/react-basics-2/render-an-element).

```js
const title = React.createElement(
//  1. Type of Element 
//  2. Object, containing any attributes desired. If none, enter null
//  3. Contents or children of the element you are creating
    'h1',
    { id: 'main-title', title: 'This is a title.' },
    'My First React Element!'
); 

// Creates: <h1 id="main-title" title="This is a title">My First React Element!</h1>

const desc = React.createElement(
    'p',
    null,
    'I just learned how to create a react node and render it into the DOM."
);


const header = React.createElement(
    'header',
    null,
    //include title and desc above as children elements to `header`
    title,
    desc 
);

// render it to the dom: 
ReactDom.render(
//  1. What you want to render (React element or JS Object)
//  2. The HTML element (div) you want to mount. */}
   // title,
    header,
    document.getElementById('root') //in index.html div with id root
); 

```

## Rewrite the above with JSX

In [this video, we rewrite the above title and desc with JSX](https://teamtreehouse.com/library/react-basics-2/understanding-jsx).

In [this video, we rewrite the above header with JSX](https://teamtreehouse.com/library/react-basics-2/embed-javascript-expressions-in-jsx).



We used the stand alone Babel script tag instead of compiling in our index.html. 
In production you'd compile with a tool like webpack.

```html
<!-- Babel Standalone Script Tag: -->
    <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>
<!-- Add type text/babel to app.js source script: -->
    <script type="text/babel" src="./app.js"></script>
```

```js

const title = 'First React Element!';
// const title = React.createElement(
//     'h1',
//     { id: 'main-title', title: 'This is a title.' },
//     'My First React Element!'
// ); 

const desc = 'I just learned how to create a react node and render it into the DOM.';
// const desc = React.createElement(
//     'p',
//     null,
//     'I just learned how to create a react node and render it into the DOM.'
// );

const myTitleId = 'main-title';
const name = 'Joe'; 

//JSX expression tags {}. Exits jSX and { javaScript inside brackets }
const header = (
    <header>
        <h1 id={ myTitleId }>{ name }'s { title }</h1> 
        <p className="main-desc">{ desc }</p>
        <input value={10 * 20} />
    </header>
);
// const header = React.createElement(
//     'header',
//     null,
//     title,
//     desc 
// );

ReactDom.render(
    header,
    document.getElementById('root')
);

```

**JSX Reminders**
1. JSX users `className` instead of `class` since class is a reserved name in JavaScript. 
2. JSX Comments `{/* are like this */}`



## React Components

[Function Header:](https://teamtreehouse.com/library/react-basics-2/create-a-component).
 
[Complete Header:](https://teamtreehouse.com/library/react-basics-2/use-a-component-with-jsx).
 

JSX Tag name `<Header />` can be self closing or opening & closing uppercase tags to provide nested components. 
```js   
    <Header>
      // nested components
    </Header>,
    document.getElementById('root')
```

```js

function Header() {
  return (
    <header>
      <h1>Scoreboard</h1>
      <span className="stats">Players: 1</span>  
    </header>
  ); 
}

ReactDom.render(
//    header,
    <Header />,
    document.getElementById('root')
);

```


**Rewrite function as Arrow Function** [shown here](https://teamtreehouse.com/library/react-basics-2/components-as-arrow-functions).

```js
function Header() {
  return (
    <header>
      <h1>Scoreboard</h1>
      <span className="stats">Players: 1</span>  
    </header>
  ); 
}

const Header = () => (
  //return ( implicit return
    <header>
      <h1>Scoreboard</h1>
      <span className="stats">Players: 1</span>  
    </header>
  // ); 
)
```

