+++
title = "ORMs"
type = "chapter"
weight = 165
+++

## Competency and Learning Objectives

### Competency:

ORMs

### Learning Objectives:

- I can explain the role of Hibernate in facilitating ORM between Java/Spring and MySQL.
- I can implement a code-first approach for database table creation with entities and repositories.
- I can implement a code-first approach for setting relationships between database tables (one-to-many, many-to-many, one-to-one).

## Introduction

In the last chapter, we learned how to use JPA to connect to a MySQL database and perform CRUD operations.
Specifically, we used a library called "Hibernate" with JPA to connect our Spring application to a MySQL database
by mapping Java objects to database tables.

This idea of mapping Java objects to database tables is called Object-Relational Mapping (ORM).
JPA is a specification for ORM in Java, and Hibernate is one of the most popular implementations of JPA.

So far, we have only used hibernate to perform basic CRUD operations on a single table at a time.
This only scratches the surface of what Hibernate and ORM can do.

In this chapter, we will dive deeper into the Hibernate JPA library and ORM concepts.

