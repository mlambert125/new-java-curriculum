+++
title = "Api 2"
type = "chapter"
weight = 250
+++

## Competency and Learning Objectives

### Competency:

Working with APIs

### Learning Objectives:

- I can programmatically communicate with a WebAPI from a java application using RestTemplate
- I can programmatically communicate with a WebAPI from javascript using fetch()

## Introduction

In the previous chapter, we learned how to use Postman to send HTTP requests to a REST API and inspect the responses.
In this chapter, we will learn how to programmatically communicate with a WebAPI from a Java application using the
RestTemplate class, and from JavaScript using the fetch() function.

We will be using the same REST API that we used in the previous chapter, which is a simple JSONPlaceholder API that
provides fake data for testing purposes.  The API has several endpoints that we can use to perform CRUD (Create, Read,
Update, Delete) operations on resources such as users, posts, comments, etc.

The base URL for the API is https://jsonplaceholder.typicode.com, and the endpoints that we will be using are as
follows:

- **GET /todos**: Returns a list of todos
- **GET /todos/{id}**: Returns a single todo by ID
- **POST /todos**: Creates a new todo
- **PUT /todos/{id}**: Updates an existing todo by ID
- **DELETE /todos/{id}**: Deletes a todo by ID

The JSON format for the todo resource is as follows:

```json
{
  "userId": 1,
  "id": 1,
  "title": "delectus aut autem",
  "completed": false
}
```

## Calling an API from JavaScript

The fetch() function in JavaScript is used to make network requests to a server and retrieve data from a URL.  It
returns a Promise that resolves to the Response object representing the response to the request.  The fetch()
function takes two arguments: the URL to send the request to, and an optional options object that can be used to
specify additional options such as the HTTP method, headers, request body, etc.  The fetch() function is a modern
and powerful way to make network requests in JavaScript, and it is supported in all modern browsers.

### Making a GET Request

To make a GET request using the fetch() function, you can simply call the function with the URL of the resource you
want to retrieve.  The fetch() function will return a Promise that resolves to the Response object representing
the response to the request.  You can then use the json() method of the Response object to parse the response body
as JSON and access the data.

```javascript
let response = await fetch('https://jsonplaceholder.typicode.com/todos')
let todos = await response.json()
```
The todos variable will now contain an array of todo objects, which you can use in your application.

You can also make a GET request to retrieve a single todo by ID.  To do this, you can use template literals to
construct the URL with the ID of the todo you want to retrieve.  The rest of the process is the same as making a
GET request to retrieve a list of todos.

```javascript
let id = 1
let response = await fetch(`https://jsonplaceholder.typicode.com/todos/${id}`)
let todo = await response.json()
```

### Making a POST Request

To make a POST request using the fetch() function, you need to specify the HTTP method as "POST" in the options
object, and provide the request body as a JSON string.  You also need to set the "Content-Type" header to
"application/json" to indicate that the request body contains JSON data.  The fetch() function will return a
Promise that resolves to the Response object representing the response to the request.  You can then use the
json() method of the Response object to parse the response body as JSON and access the data.

```javascript
let todo = {
  userId: 1,
  title: 'New Todo',
  completed: false
}

let response = await fetch('https://jsonplaceholder.typicode.com/todos', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(todo)
})

let newTodo = await response.json()
```

The newTodo variable will now contain the newly created todo object, which will have an "id" property assigned by
the server.

### Making a PUT Request

To make a PUT request using the fetch() function, you need to specify the HTTP method as "PUT" in the options
object, and provide the request body as a JSON string.  You also need to set the "Content-Type" header to
"application/json" to indicate that the request body contains JSON data.  The fetch() function will return a
Promise that resolves to the Response object representing the response to the request.  You can then use the
json() method of the Response object to parse the response body as JSON and access the data.

```javascript
let id = 1
let todo = {
  userId: 1,
  id: id,
  title: 'Updated Todo',
  completed: true
}

let response = await fetch(`https://jsonplaceholder.typicode.com/todos/${id}`, {
  method: 'PUT',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(todo)
})
let updatedTodo = await response.json()
```

The updatedTodo variable will now contain the updated todo object, which will have the same "id" property as the
original todo.

### Making a DELETE Request

To make a DELETE request using the fetch() function, you need to specify the HTTP method as "DELETE" in the
options object.  The fetch() function will return a Promise that resolves to the Response object representing
the response to the request.  You can then check the status of the response to determine if the request was
successful.

```javascript
let id = 1
let response = await fetch(`https://jsonplaceholder.typicode.com/todos/${id}`, {
  method: 'DELETE'
})
if (response.ok) {
  console.log('Todo deleted successfully')
} else {
  console.error('Error deleting todo')
}
```

The response.ok property will be true if the request was successful (status code 200-299), and false otherwise.

### Check For Understanding

1. **Question:** What two steps are required when making a GET request using the fetch() function?
    - **Answer:** You need to call the fetch() function with the URL of the resource you want to retrieve, and then use
      the json() method of the Response object to parse the response body as JSON.
2. **Question:** How do you set the format of the request body when making a POST request using the fetch() function?
    - **Answer:** You need to include a `headers` property in the options object with a "Content-Type" header set to
      "application/json"

## Calling an API from Java

From a Java Spring Boot application, we can use the RestTemplate class to make HTTP requests to a REST API.  The
RestTemplate class provides methods for making GET, POST, PUT, and DELETE requests, and it can automatically
convert the response body to a Java object using the Jackson library.  The RestTemplate class is a powerful and
flexible way to make HTTP requests in Java, and it is widely used in Spring Boot applications.

### Creating a Todo Class

To use the RestTemplate class to make HTTP requests to the JSONPlaceholder API, we first need to create a Java
class that represents the todo resource.  This class will be used to serialize and deserialize the JSON data when
making requests to the API.  The class should have fields for each property of the todo resource, along with
getters and setters for each field.

```java
public class Todo {
  private int userId;
  private int id;
  private String title;
  private boolean completed;

  // Getters and setters for each field
  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public boolean isCompleted() {
    return completed;
  }

  public void setCompleted(boolean completed) {
    this.completed = completed;
  }
}
```

### Making a GET Request

To make a GET request using the RestTemplate class, you can use the getForObject() method, which takes the URL
of the resource you want to retrieve and the class type of the response object.  The method will return an
instance of the specified class, populated with the data from the response body.  You can also use the
getForObject() method to retrieve a single todo by ID, by including the ID in the URL.

```java
RestTemplate restTemplate = new RestTemplate();
String url = "https://jsonplaceholder.typicode.com/todos";
Todo[] todos = restTemplate.getForObject(url, Todo[].class);
```

You can also retrieve a single todo by ID by including the ID in the URL.  The getForObject() method will return
an instance of the Todo class, populated with the data from the response body.

```java
int id = 1;
String url = "https://jsonplaceholder.typicode.com/todos/" + id;
Todo todo = restTemplate.getForObject(url, Todo.class);
```

### Making a POST Request

To make a POST request using the RestTemplate class, you can use the postForObject() method, which takes the
URL of the resource you want to create, the request body as an instance of the Todo class, and the class type
of the response object.  The method will return an instance of the specified class, populated with the data
from the response body.  You can also use the postForObject() method to create a new todo by providing the
request body as an instance of the Todo class.  The method will return an instance of the Todo class, populated
with the data from the response body, including the "id" property assigned by the server.

```java
RestTemplate restTemplate = new RestTemplate();
String url = "https://jsonplaceholder.typicode.com/todos";

// Create a new todo
Todo todo = new Todo();
todo.setUserId(1);
todo.setTitle("New Todo");
todo.setCompleted(false);

// Make the POST request
Todo newTodo = restTemplate.postForObject(url, todo, Todo.class);
```

The newTodo variable will now contain the newly created todo object, which will have an "id" property assigned
by the server.

### Making a PUT Request

To make a PUT request using the RestTemplate class, you can use the put() method, which takes the URL of the
resource you want to update and the request body as an instance of the Todo class.  The method does not
return a value, but it will update the resource on the server with the data from the request body.  You can
also use the put() method to update an existing todo by providing the ID of the todo in the URL and the
request body as an instance of the Todo class.  The method will update the resource on the server with
the data from the request body, including the "id" property of the todo.

```java
RestTemplate restTemplate = new RestTemplate();
int id = 1;
String url = "https://jsonplaceholder.typicode.com/todos/" + id;

// Get the existing todo
Todo todo = restTemplate.getForObject(url, Todo.class);

// Update the todo
todo.setTitle("Updated Todo");
todo.setCompleted(true);

// Make the PUT request
restTemplate.put(url, todo);
```

### Making a DELETE Request

To make a DELETE request using the RestTemplate class, you can use the delete() method, which takes the URL
of the resource you want to delete.  The method does not return a value, but it will delete the resource
from the server.  You can also use the delete() method to delete a todo by providing the ID of the todo
in the URL.  The method will delete the resource from the server.

```java
RestTemplate restTemplate = new RestTemplate();
int id = 1;
String url = "https://jsonplaceholder.typicode.com/todos/" + id;
restTemplate.delete(url);
```

### Check For Understanding

1. **Question:**  What class provides methods for making HTTP requests in a Spring Boot application?
    - **Answer:** `RestTemplate`
2. **Question:** What method of the RestTemplate class is used to make a GET request and retrieve a single resource by
   ID?
    - **Answer:** `getForObject()`
3. **Question:** What method of the RestTemplate class is used to make a POST request and create a new resource?
    - **Answer:** `postForObject()`
4. **Question:** What method of the RestTemplate class is used to make a PUT request and update an existing resource?
    - **Answer:** `put()`
5. **Question:** What method of the RestTemplate class is used to make a DELETE request and delete a resource?
    - **Answer:** `delete()`

## Practice/Project Task

- Activity Description: 
- Prompt:
- Format (individual, pair programming, presentation, group discussion, etc.):
- Tools:
- Time Estimate:
- Test Case
    - Input: 
    - Output:
- Expected Outcomes: 
    - **Green**:
    - **Yellow**:
    - **Red**:

## Conclusion

In this chapter, we have learned how to programmatically communicate with a WebAPI from a Java application using
the RestTemplate class, and from JavaScript using the fetch() function.  We have learned how to make GET,
POST, PUT, and DELETE requests to the JSONPlaceholder API, and how to handle the response data.  We have also
learned how to create a Java class to represent the todo resource, and how to use it to serialize and deserialize
the json data when making requests to the api.


