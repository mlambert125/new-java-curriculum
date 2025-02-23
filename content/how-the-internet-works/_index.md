+++
title = "How the Internet Works"
type = "chapter"
weight = 130
+++

## Competency and Learning Objectives

### Competency:

How the Internet Works

### Learning Objectives:

- I can explain what a web server is and what it does.
- I understand how the request and response cycle sends information back and forth from client to server.

## Introduction

In the modern world, most people have used the internet in some form or another. Whether it's checking email, watching
videos, or browsing social media, the internet is an integral part of our daily lives. But how does it work? In this
lesson, we'll explore the basics of how the internet works, including what a web server is and how information is sent
back and forth between a client and server.

## Client-Server Model

At its core, the internet is based on a client-server model. In this model, there are two types of computers: clients
and servers. Clients are the devices that you use to access the internet, such as your laptop, smartphone, or tablet.
Servers are the computers that store and serve up information to clients. When you visit a website, your browser acts as
the client, and the website's server sends the information to your browser.

### Web Browser

A web browser is a software application that allows you to access and view websites on the internet. When you type a
website's URL into your browser's address bar and press `Enter`, the browser sends a request to the website's server,
asking for the website's information. The server then sends the information back to your browser, which displays the
website on your screen.

Some common web browsers include:

- Google Chrome
- Mozilla Firefox
- Microsoft Edge
- Apple Safari

### Web Servers

A web server is a computer that stores and serves up websites to clients. When you type a website's URL into your
browser, the browser sends a request to the website's server, asking for the website's information. The server then
sends the information back to your browser, which displays the website on your screen.

## HTTP Request and Response

The process of sending information back and forth between a client and server is known as the **request and response
cycle**. When you visit a website, your browser sends a request to the website's server, asking for the website's
information. The server then sends the information back to your browser, which displays the website on your screen.

To send information back and forth between a client and server, the internet uses a set of rules called protocols. The
protocol used to send information over the web is called HTTP (Hypertext Transfer Protocol). When your browser sends a
request to a web server, it uses the HTTP protocol to communicate with the server. The server then sends the
information back to your browser using the same protocol.

#### HTTP Request

When your browser sends a request to a web server, it includes information about the request, such as the URL of the
website you want to visit. The request also includes other information, such as the type of browser you're using and any
cookies that the server has sent to your browser.  A typical HTTP request looks like this:

```
GET /index.html HTTP/1.1
Host: www.example.com
User-Agent: Mozilla/5.0
```

This example corresponds to you typing `http://www.example.com/index.html` into your browser's address bar and pressing
`Enter`.

##### Request Line

The first line of the request includes the method (GET), the URL (/index.html), and the HTTP version (HTTP/1.1).  This
line is called the request line.  The "method" part of this line tells the server what type of request you're making.
In HTTP, there are several different methods, but the most common ones are GET and POST.

| Method | Description |
|--------|-------------|
| GET    | Requests data from a server. Corresponds to you entering a web address or clicking a link. |
| POST   | Submits data to be processed by a server. Corresponds to you pressing a button on an website form.  |

There are other less common methods that are sent by some web sites, but they require the web developer to explicitly
choose them, vs. being the default behavior for browser behaviors.

| Method | Description |
|--------|-------------|
| PUT    | Updates (replaces) data on a server. |
| PATCH  | Partially updates data on a server. |
| DELETE | Deletes data from a server. |
| HEAD   | Requests the headers of a resource without the body. |
| OPTIONS| Requests the available methods for a resource. |

##### Headers

The other  lines of the request are called headers.  Headers provide additional information about the request, such as
the host you're trying to reach, the type of browser you're using, and any cookies that the server has sent to your
browser.  Headers are key-value pairs separated by a colon (:), where the key is the name of the header and the value
is the information that the header provides.  Some common headers include:

| Header       | Description |
|--------------|-------------|
| Host         | The host you're trying to reach. |
| User-Agent   | The type of browser you're using. |
| Cookie       | Any cookie that the server has sent to your browser that your browser is sending back with an update. |
| Content-Type | The type of data that the  browser is sending to the server. |
| Content-Length | The length of the data that the browser is sending to the server. |
| Accept       | The type of data that the browser is willing to accept from the server. |

Headers are optional in the protocol, but they are commonly used to provide additional information about the request,
and every browser will send some headers with every request.

##### Body

The body of the request is the data that the browser is sending to the server.  For a typical GET request, (a request
caused by you entering a URL into the browser's address bar or clicking a link on a web page), the body is usually
empty, but for a POST request, the body contains the data that the browser is submitting to the server.  Let's look at
anothere request example that includes a body:

```
POST /submit-form HTTP/1.1
Host: www.example.com
User-Agent: Mozilla/5.0
Content-Type: application/x-www-form-urlencoded
Content-Length: 13

name=John+Doe
```

This example corresponds to you submitting a form on a website where you entered the name "John Doe". The body of the
request contains the data that you're submitting to the server, in this case, the name "John Doe".  Don't worry too
much about the format of the body (`name=John+Doe`) in this example as the format can vary depending on the type of
data being sent.

##### JavaScript Requests (i.e. API Requests)

In addition to requests made by you entering a URL into the browser's address bar or submitting a form, requests can
also be made by JavaScript code running in the browser.  If you've used a front-end framework like React, Angular, or
Vue, you've likely used JavaScript to make requests to a server to fetch data or submit data to a server using the 
`fetch` or `XMLHttpRequest` APIs.  These requests are similar to the requests made by the browser when you enter a URL
into the address bar, but they are made by JavaScript code running in the browser instead of by you.

As we learn to build web servers and web applications that handle browser requests, we can typically expect the
following details for "API Requests" from JavaScript code:

- The method can be any of the HTTP methods, not just GET and POST.
- Requests are likely to include a body with data that the server needs to process.
- The headers are likely to include a `Content-Type` header that tells the server what type of data is in the body.
- The javascript code is likely to expect a response from the server in a format other than HTML, (typically JSON.) 

#### HTTP Response

When the server receives your request, it sends a response back to your browser. The response includes information
about the request, such as the status code, the type of data being sent, and the data itself. A typical HTTP response
looks like this:

```
HTTP/1.1 200 OK
Content-Type: text/html

<!DOCTYPE html>
<html>
<head>
    <title>Example Website</title>
</head>
<body>
    <h1>Welcome to Example Website</h1>
</body>
</html>
```

Notice that the format of the response is similar to the request, with a status line, headers, and a body.

##### Status Line

The first line of the response includes the HTTP version (HTTP/1.1), the status code (200), and a status message (OK).
This is different from the request line in that it includes the status code and message instead of the method and URL.
The status code is a three-digit number that indicates the status of the response. Some common status codes include:

| Status Code | Description |
|-------------|-------------|
| 200         | OK. The request was successful. |
| 404         | Not Found. The requested resource could not be found. |
| 500         | Internal Server Error. There was an error on the server. |
| 301         | Moved Permanently. The requested resource has been moved to a different URL. |
| 302         | Found. The requested resource has been temporarily moved to a different URL. |

If all goes well, your browser will typically see a status code of 200, which means that the request was successful and
the browser can go on to read the body of the response and display it in the browser window.

##### Headers

The other lines of the response are headers, which provide additional information about the response, such as the type
of data being sent.  These are generally the same as the request headers, they just correspond to the response instead
of the request.

#### Ending the Cycle

Once the browser has received the response from the server, the request and response cycle is complete, and the
browser displays the website on your screen and hangs up the connection until you click on another link or enter
another URL.

> [!NOTE]
> In newer versions of the HTTP protocol, the connection is not closed after the response is sent, but instead is kept
> open so that the connection can be reused for future requests. This is known as HTTP/1.1 persistent connections.
> Nonetheless, it is still useful to think of the request and response cycle as a series of discrete steps.

#### Further Requests

If the website you're visiting returns HTML that references other resources, such as images, stylesheets, or scripts,
your browser will send additional requests to the server to fetch each of those resources. This is why you'll often see
multiple requests being made when you visit a single web page.  The first request is for the HTML of the page, and then
the browser makes additional requests for each of the resources that the HTML references.

### Check For Understanding

1. **Question:** What are the three parts of an HTTP request?
    - **Answer:** The request line, headers, and body.
2. **Question:** What is the purpose of the body in an HTTP *request*?
    - **Answer:** The body contains the data that the browser is sending to the server from a form or the javascript
        code that is making the request via fetch or XMLHttpRequest.
3. **Question:** What are the three parts of an HTTP response?
    - **Answer:** The status line, headers, and body.
4. **Question:** What is the difference between a normal web request and an API request?
    - **Answer:** API requests are made by JavaScript code running in the browser, not by you entering a URL into the
        address bar or submitting a form.  API requests can use any of the HTTP methods, not just GET and POST, and
        they are likely to include a body with data that the server needs to process.  Also, the body of both the
        request and the response is likely to be in a format other than HTML, typically JSON.

## Reflection Task

- Prompt: Consider a site that you frequently visit. When you load the site, what requests are being made to the server?
    - What is the first request that is made?
    - What additional requests are made after the first request?
    - What resources are being requested in each of the requests?
    Use the chrome developer tools to inspect the network tab to see the requests that are being made.
- Expected Outcomes: 
    - **Green**: The student can identify the requests that are being made when they visit a website and why and in what
        order they are being made.
    - **Yellow**: The student understands the basic idea of the HTTP request/response cycle, but may not be able to
        identify the specific requests that are being made when they visit a website, or how to identify referenced
        resources in the original HTML response.
    - **Red**:  The student does not understand the basic idea of the HTTP request/response cycle.

## Conclusion

In this lesson, we've explored the basics of how the internet works, including what a web server is and how information
is sent back and forth between a client and server. We've learned that the internet is based on a client-server model,
where clients are the devices that you use to access the internet, and servers are the computers that store and serve up
information to clients. We've also learned about the request and response cycle, which is the process of sending
information back and forth between a client and server using the HTTP protocol. Before diving into building a web
server application with Java, it's important to understand the basics of how the web works so that you can understand
how your server application will receive and respond to requests from browsers.

