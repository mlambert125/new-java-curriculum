+++
title = "Security 2"
type = "chapter"
weight = 230
+++

## Competency and Learning Objectives

### Competency:

Security Best Practices

### Learning Objectives:

- I can add token-based authentication to a Spring Boot application using a provided third-party library (e.g.
https://github.com/bratkartoffel/security-jwt)

## Introduction

In this lesson, we will learn about hashing and how to use it to secure passwords. We will also learn how to implement
user authentication in Spring Boot and secure REST endpoints.

Throughout this lesson, we will be using projects in a repository located here:

https://github.com/LaunchCodeEducation/software-dev-course-security-2

You should clone this repository and follow along with the code as we go through the lesson.

> [!NOTE]
> You will not need to modify the code in this repository.  You will only need to review the code and run the
> applications to see how they work.

You will also need to create a new MySql database called `securityexample` and update the `application.properties` file
in the `jpa-authentication` project to point to this database with your local MySql credentials.

## Hashing

When securing passwords, the first idea that occurs to many developers is to encrypt the password. However, encryption
is not the best way to secure passwords.

Passwords are a unique case because of the fact that our requirements are a bit different than the usual encryption
requirements.  Most importantly, we don't need to decrypt the password. We only need to verify that the password is
correct. This is where hashing comes in.

Hashing is one-way encryption. When you hash a value, you will get a fixed-length string that is unique to that value.
The same value will always hash to the same string. However, you cannot reverse the process. You cannot take the hash
and get the original value back.  This is because hashing is lossy. When you hash a value, you lose information.  The
hashed value does not contain all the information that was in the original value.

So how does this help us secure passwords?

1. When a user creates an account, we hash their chosen password and store the hash in the database.
2. When the user logs in, we hash the password they provide and compare it to the hash in the database.
3. If the hashes match, we know the password is correct.
4. The password is never stored or recoverable from the hash.

This way, we never store the actual password in the database. If the database is compromised, the attacker will only
have access to the hashed passwords, which are not enough to log in or to reverse-engineer the original password.

This is also why, if a site is properly storing your passwords using hashing, they cannot send you your password if you
forget it. They can only reset it.  In fact, if a site can send you your password, that is a red flag that they are not
storing your password securely.

### Check For Understanding

1. **Question:** What is hashing?
    - **Answer:** Hashing is one-way encryption. 
2. **Question:** Why is hashing a better choice than encryption for securing passwords?
    - **Answer:** The password can not be read or recovered from the hash, even if the hash is compromised.
3. **Question:** Why can't a site send you your password if they are storing it securely?
    - **Answer:** The password is hashed and cannot be recovered from the hash.

## Implementing User Authentication in Spring Boot

Token-based authentication is a stateless authentication mechanism.  The process is:

1. The user sends their credentials to the login endpoint.
2. The server validates the credentials and generates a token.
3. The server sends the token back to the user.
4. The user sends the token with each request.
5. The server validates the token and allows access to the requested resource.
6. Eventually, the token expires and the user must log in again or refresh the token.

This is a simplified version of the process. There are many variations and additional features that can be added to this
process to implement multi-factor authentication, role-based access control, and more.

At the center of this process is password hashing. When the user logs in, the server hashes the password and compares it
to the hash stored in the database. If the hashes match, the server generates a token and sends it back to the user.

In the repository that you cloned earlier, there is a Spring Boot application that has already been set up with this
library and with hard-coded credentials for a single user.  You can find this project in the `hardcoded-authentication`
directory.  You should load this project and follow along with the code as we go.


Adding a complete JWT-based authentication system to a Spring Boot application can be complex. Fortunately, there are
libraries that can help simplify the process. One such library is `security-jwt`.  You can read more about it
[here](https://github.com/bratkartoffel/security-jwt).  This application is already set up with this library.

If you look in the `pom.xml` file, you will find the following dependencies:

```xml
<dependency>
    <groupId>eu.fraho.spring</groupId>
    <artifactId>security-jwt-base</artifactId>
    <version>5.0.12</version>
</dependency>
<dependency>
    <groupId>eu.fraho.spring</groupId>
    <artifactId>security-jwt-base-spring-boot-starter</artifactId>
    <version>5.0.12</version>
</dependency>
```

To use this library, a project to implement the `UserDetailsService` interface and tell the library how we want to
authenticate users.

In the `src/main/java/com/example/securityexample` directory, you will find a class called `CustomUserDetailsService`. 
This class implements the `UserDetailsService` interface and provides a simple implementation that only allows a single
user to log in with hard-coded credentials.

If you open this class, you will see that it implements the `UserDetailsService` interface from the included library
by providing an implementation of the `loadUserByUsername` method.  This method takes a username as an argument and
returns a `UserDetails` object or throws a `UsernameNotFoundException` if the user is not found.

```java
...
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        if (username.equals("admin")) {            JwtUser user = new JwtUser();
            JwtUser jwtUser = new JwtUser();
            jwtUser.setUsername("admin");
            jwtUser.setPassword(passwordEncoder.encode("admin"));
            jwtUser.setAuthorities(Collections.singletonList(new SimpleGrantedAuthority("ROLE_ADMIN")));
            jwtUser.setAccountNonExpired(true);
            jwtUser.setAccountNonLocked(true);
            jwtUser.setApiAccessAllowed(true);
            jwtUser.setCredentialsNonExpired(true);
            jwtUser.setEnabled(true);
            return jwtUser;
        } else {
            throw new UsernameNotFoundException("User not found");
        }
    }
...
```

This implementation checks if the username is `admin` and if so, it returns a `JwtUser` object with the username
`admin`, the password `admin` (encoded), and a single authority `ROLE_ADMIN`.

Let's try  running this application testing the login endpoint.  The login endpoint is `/login` by
default.  We can test it using postman to visit `http://localhost:8080/login` and send a POST request with the
following JSON body:

```json
{
    "username": "admin",
    "password": "admin"
}
```

![Postman Login](postman-login.png)

If the credentials are correct, we will get a response with a token.  If the credentials are incorrect, we will get a
401 Unauthorized response.  Try this with different credentials to see the different responses.

## JPA and User Authentication

In a real application, we would probably be querying a database to find the user and their roles.  We can use JPA to
do this.

> [!NOTE]
> If you did not do so at the start of this lesson, you will need to create a new MySql database called
> `securityexample` and update the `application.properties` file in the `jpa-authentication` project to point to this
> database with your local MySql credentials.

Open the `jpa-authentication` project in the repository that you cloned earlier. Review the classes present in this
project:

- `models/User` - A class that represents a user in the database.
- `repositories/UserRepository` - A repository interface that extends `JpaRepository` and allows us to query the database for users.
- `UserLoader` - A class that provides a `CommandLineRunner` that runs at spring boot startup and creates an admin user
  in the database if one does not already exist.
- `CustomUserDetailsService` - A class that implements the `UserDetailsService` interface and provides an implementation
for the `loadUserByUsername` method that uses the `UserRepository` to find the user in the database.
- `SecurityExampleApplication` - The main class that runs the Spring Boot application.

The model and repository class is just a simple JPA entity and repository.  You can review it if you like, but assuming
you are familiar with JPA, you shouldn't see anything surprising here.

The `UserLoader` class is a `CommandLineRunner` that runs at startup and creates an admin user in the database if one
does not already exist.  One point of interest here is that when we set the password for the user, we use the
`passwordEncoder` bean to encode the password before storing it in the database.  This is important because the
`CustomUserDetailsService` class will use the same `passwordEncoder` to encode the password provided by the user when
they log in.  This requirement ensures that the password is hashed before it is stored in the database and that the
password provided by the user is hashed before it is compared to the password in the database.

Finally, let's take a look at the `CustomUserDetailsService` class.  This class is similar to the one in the previous
project, but instead of hard-coding the user, it queries the database for the user using the `UserRepository`.  If the
user is found, it returns a `JwtUser` object with the user's information.  If the user is not found, it throws a
`UsernameNotFoundException`:

```java
...
    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException("User not found"));

        List<GrantedAuthority> roles = new ArrayList<>();

        for (String role : user.getRoles()) {
            roles.add(new SimpleGrantedAuthority(role));
        }

        JwtUser jwtUser = new JwtUser();
        jwtUser.setUsername(user.getUsername());
        jwtUser.setPassword(user.getPassword());
        jwtUser.setAuthorities(roles);
        jwtUser.setAccountNonExpired(true);
        jwtUser.setAccountNonLocked(true);
        jwtUser.setApiAccessAllowed(true);
        jwtUser.setCredentialsNonExpired(true);
        jwtUser.setEnabled(true);

        return jwtUser;
    }
...
```

This time, we are basically loading the user and their roles from the database and then manually converting the `User`
JPA class to a `JwtUser` object that will be used by the `security-jwt` authentication library.

Once again, let's try running this application and testing the login endpoint:

![Postman Login](postman-login.png)

We should get the same results as before, but this time the user is being loaded from the database.

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## Using the Token

Once we have successfully logged in and received a token, we should include this token with each request to the server
moving forward.  By passing this token with each request, Spring Boot will be able to validate the token and allow us
to consider the user and their roles when processing the request.

You may be wondering *where* to include the token.  We don't include it in the URL or the body of the request for a few
reasons:

- Including it in the URL would expose it in the browser history and server logs.
- Including it in the body would expose it in the request body and server logs.
- It logically doesn't "fit" here, because it is not "part" of the request.  It's an extra bit of information.

Thankfully, there is a place in the HTTP request specifically for the purpose of including extra information like this:
the headers.  The token should be included in the `Authorization` header of the request.  Because there are many ways to
use the `Authorization` header, we need to prefix the value of the header with the word `Bearer` to indicate that the
value is a token.

| Key | Value |
| --- | --- |
| Authorization | Bearer 0a3f4b5c-6d7e-8f9a-b0c1-d2e3f4a5b6c7 |

This process of getting a token and then including it in the `Authorization` header of each request is called
"stateless authentication" because the server does not need to keep track of the user's state.  The token contains all
the information the server needs to authenticate the user and determine their roles.  The token is secure because it
is signed by the server and cannot be forged or tampered with.  Only the server has the secret key needed to decode the
token, change the information, and re-encode it.

### Using Tokens in Postman

In Postman, you first run the `GET /login` request to get a token.  Then you copy the token from the response and paste
it into the `Authorization` header after the word `Bearer` and a space for any subsequent Postman requests.

### Check For Understanding

1. **Question:**  How do you include the token in a request to a REST endpoint?
    - **Answer:** You include the token in the `Authorization` header with the value `Bearer` followed by a space and
      then the token.
2. **Question:**  Why do we include the token in the `Authorization` header?
    - **Answer:**  So that the server can validate the token and authenticate the user and use the user's information
      and roles to authorize and process the request.

## Securing REST endpoints

Once we have implemented authentication, we can move on to authorization.  Authorization is the process of determining
if a user has permission to access a resource.  In this case, we are talking about securing REST endpoints.

Authorization is done with simple attributes in Spring Boot.

There are three main ways to secure REST endpoints in Spring Boot:

- Restrict access to only allow authenticated users.
- Restrict access to only allow users with specific roles.
- Restrict access to only allow specific users by username.

We can use the `@PreAuthorize` annotation to accomplish all three of these cases.  In every case, the annotation takes a
string that is a SpEL (Spring Expression Language) expression that evaluates to a boolean.  SpEL is a tiny language
that allows us to write expressions that evaluate to a boolean.  We can use this language to write expressions that
check if the user is authenticated, has a specific role, or is a specific user.

### Restrict Access to Authenticated Users

To restrict access to only authenticated users, we can use the `@PreAuthorize` annotation with the expression
`isAuthenticated()`:

```java
@PreAuthorize("isAuthenticated()")
```

We can add this annotation to a controller to secure all the endpoints in that controller.  For example:

```java
@RestController
@RequestMapping("/books")
@PreAuthorize("isAuthenticated()")
public class BookController {
    @GetMapping
    public List<Book> getBooks() {
        return bookService.getBooks();
    }
}
```

We can also add this annotation to individual methods to secure only those methods.  For example:

```java
@RestController
@RequestMapping("/books")
public class BookController {
    @GetMapping
    @PreAuthorize("isAuthenticated()")
    public List<Book> getBooks() {
        return bookService.getBooks();
    }
}
```

With this attribute attached, only authenticated users (but *any* authenticated user) will be able to access the
endpoints in this controller.

### Restrict Access to Users with Specific Roles

To restrict access to only users with specific roles, we can use the `@PreAuthorize` annotation with the expression
`hasAuthority`:

```java
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
```

As with `isAuthenticated`, we can add this annotation to a controller or to individual methoods.

This will restrict access to only users with the `ROLE_ADMIN` authority.  If the user does not have this authority, they
will get a 403 Forbidden response.

> [!NOTE]
> Older versions of Spring Boot used `hasRole` instead of `hasAuthority`.  If you are using an older version of Spring
> Boot, you may see this annotation instead.  They are equivalent.

### Restrict Access to Specific Users

To restrict access to only specific users, we can use the `@PreAuthorize` annotation with the expression
`principal.username == 'admin'`:

```java
@PreAuthorize("principal.username == 'admin'")
```

This will restrict access to only the user with the username `admin`.  If the user is not `admin`, they will get a 403
Forbidden response.

### 403 Forbidden vs 401 Unauthorized

When you request an endpoint that is secured with `@PreAuthorize`, and you are not authorized to access that endpoint,
you can get one of two responses:

- 401 Unauthorized - This means that you are not authenticated.  You need to log in and get a token before you can
  access this endpoint.
- 403 Forbidden - This means that you are authenticated, but you are not authorized to access this endpoint.  You need
  to have the correct role or be the correct user to access this endpoint.

It is important to understand the difference between these two responses so that you can troubleshoot and fix any
authorization issues that arise.

If you are getting a 403 Forbidden response, your token is valid and working properly, but you do not have the correct
role or are not the correct user to access the endpoint.  You should check the database to make sure the user has the
correct roles and that the roles are being loaded correctly.

If you are getting a 401 Unauthorized response, your token is not valid or is missing.  You should check the
authentication implementation and ensure that you are using a non-expired valid token and that you properly added the
token (prefixed with `Bearer` and a space) to the `Authorization` header of the request.

### Check For Understanding

1. **Question:** What attribute do you use to restrict access to only authenticated users?
    - **Answer:** `@PreAuthorize("isAuthenticated()")`
2. **Question:**  What attribute do you use to restrict access to only users with the role `ROLE_ADMIN`?
    - **Answer:**  `@PreAuthorize("hasAuthority('ROLE_ADMIN')")`
3. **Question:**  What attribute do you use to restrict access to only the user with the username `admin`?
    - **Answer:**  `@PreAuthorize("principal.username == 'admin'")`
4. **Question:**  What is the difference between a 401 Unauthorized response and a 403 Forbidden response?
    - **Answer:**  A 401 Unauthorized response means that you are not authenticated.  A 403 Forbidden response means
      that you are authenticated, but you are not authorized to access the endpoint.

## Retrieving the Current User in REST endpoints

As we've seen, the token is useful for authorizing requests and securing endpoints.  But there are other times that we
may need to know who the current user is.  For example, consider a REST endpoint that lists all of the books that have
been purchased by the current user.  We need to know who the current user is to retrieve this information.  We wouldn't
want to simply pass the username as a parameter to the endpoint because this could be easily forged so that one user
could see another user's purchases.  Instead, we want to get the current username from the token.

In a Spring Boot controller method, we can do this by adding a parameter of type `Principal` to the method signature.
Spring Boot will automatically inject the current user's `Principal` object into this parameter.  Unlike other
parameters, we do not need to annotate this parameter with `@RequestParam` or `@PathVariable`.  Spring Boot knows how
to map this parameter to the current user info by the type of the parameter.

The main thing that we want from the principal object is the username.  We can get this by calling the `getName` method
on the principal object.  This will return the username of the current user.  Putting it all together, we can write a
controller method like this:

```java
@RestController
@RequestMapping("/books")
public class BookController {
    @GetMapping
    @PreAuthorize("isAuthenticated()")
    public List<Book> getBooks(Principal principal) {
        String username = principal.getName();
        return bookService.getBooksForUser(username);
    }
}
```

When this method is called due to a request to the `/books` endpoint, Spring Boot will inject the current user's
`Principal` object into the `principal` parameter.  We can then call the `getName` method on the `Principal` object to
get the username of the current user.  We can then use this username to retrieve the books for the current user.

We can use this technique to get the current user in any controller method.  We can even mix this parameter with other
parameters that come from the request body, request parameters, or path variables:

```java
@RestController
@RequestMapping("/books")
public class BookController {
    @GetMapping("/{id}")
    @PreAuthorize("isAuthenticated()")
    public Book getBook(Principal principal, @PathVariable Long id) {
        String username = principal.getName();
        return bookService.getBookForUser(username, id);
    }
}
```

In this example, we are getting the current user's username from the `Principal` object and the book id from the path
variable.  We can then use this information to retrieve the book for the current user.

### Check For Understanding

1. **Question:** How do you get the current user's username in a Spring Boot controller method?
    - **Answer:** Add a parameter of type `Principal` to the method signature and call the `getName` method on the
      `Principal` object.
2. **Question:** Why is it important to get the current user's username from the `Principal` object and not from the
    request body, request parameters, or path variables?
    - **Answer:** Because the username in the `Principal` object comes form the secure token and cannot be forged.  The
      username in the request body, request parameters, or path variables could be easily forged.

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

In this lesson, we learned all about password hashing and how to implement user authentication and authorization in
Spring Boot.  Authentication and authorization let us create applications that are secure and personalized to the user
of our application.  Now, instead of writing applications that provide the same data and experience to every user, we
can write applications that provide a unique experience to each user based on their identity and roles.

