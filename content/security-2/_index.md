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

## Securing REST endpoints

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## Retrieving the Current User REST endpoints

### Check For Understanding

1. **Question:** 
    - **Answer:** 
2. **Question:** 
    - **Answer:** 

## Reflection Task

- Prompt:
- Expected Outcomes: 
    - **Green**:
    - **Yellow**:
    - **Red**:

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


