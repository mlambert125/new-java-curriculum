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

Adding a complete JWT-based authentication system to a Spring Boot application can be complex. Fortunately, there are
libraries that can help simplify the process. One such library is `security-jwt`.  You can read more about it
[here](https://github.com/bratkartoffel/security-jwt).

With this library added, we will be able to add token-based authentication to our Spring Boot application, and the
library will provide us with a `/login` endpoint that we can use to authenticate users.

To add this library to a Spring Boot application, you need to add the following dependency to your `pom.xml` file:

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

To use this library, we simply need to implement the `UserDetailsService` interface and tell the library how we want to
authenticate users.

We can name this class `CustomUserDetailsService` and add this class to our application right in the application root
package.  Here's a simple implementation that only allows a single user to login with hard-coded credentials (username:
`admin`, password: `admin`):

```java
package com.example.demo;

import eu.fraho.spring.securityJwt.base.dto.JwtUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import java.util.Collections;

@Component
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        if (username.equals("admin")) {
            return new JwtUser(
                "admin",
                passwordEncoder.encode("admin"),
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_ADMIN"))
            );
        } else {
            throw new UsernameNotFoundException("User not found");
        }
    }
}
```

As you can see, the method that we need to implement is `loadUserByUsername`. This method takes a username as an 
argument and returns a `UserDetails` object or throws a `UsernameNotFoundException` if the user is not found.  In this
example, we check if the username is `admin` and if so, we return a `JwtUser` object with the username `admin`, the
password `admin` (encoded), and a single authority `ROLE_ADMIN`.

An authority is a role that the user has.  In this case, the user has the authority/role `ROLE_ADMIN`.  This role
doesn't mean anything yet, but we can store roles called whatever we want and use them to control access to different
parts of our application.

With this implemented, we can now run our application and test the login endpoint.  The login endpoint is `/login` by
default.  We can test it using postman to visit `http://localhost:8080/login` and send a POST request with the
following JSON body:

```json
{
    "username": "admin",
    "password": "admin"
}
```

If the credentials are correct, we will get a response with a token.  If the credentials are incorrect, we will get a
401 Unauthorized response.  Try this with different credentials to see the different responses.

## JPA and User Authentication

In a real application, we would probably be querying a database to find the user and their roles.  We can use JPA to
do this.  We will need to add a few JPA classes to our application to do this:

- `User` - A class that represents a user in the database.
- `UserRepository` - A repository interface that extends `JpaRepository` and allows us to query the database for users.

Here's an example of what these classes might look like:

### User (`models/User.java`):

```java
package com.example.demo.model;
import javax.persistence.*;

@Entity
public class User {
    @Id
    private String username;
    private String password;

    @ElementCollection
    private Set<String> roles = new HashSet<>();
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public Set<Role> getRoles() { return roles; }
    public void setRoles(Set<Role> roles) { this.roles = roles; }
}
```

> [!NOTE]
> The `@ElementCollection` annotation is used to map a collection of simple types (like `String`) to a separate table
> automatically without needing to create a separate entity class.

### UserRepository (`repositories/UserRepository.java`):

```java
package com.example.demo.repository;
import com.example.demo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findByUsername(String username);
}
```

### CustomUserDetailsService (`CustomUserDetailsService.java`):

Now we can update our `CustomUserDetailsService` to use the repository to find the user:

```java
package com.example.demo;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import eu.fraho.spring.securityJwt.base.dto.JwtUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import java.util.stream.Collectors;

@Component
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException("User not found"));
        
        List<GrantedAuthority> roles = new ArrayList<>();

        for (String role : user.getRoles()) {
            roles.add(new SimpleGrantedAuthority(role));
        }
        return new JwtUser(
            user.getUsername(),
            user.getPassword(),
            roles
        );
    }
}
```




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


