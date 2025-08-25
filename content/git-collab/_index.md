+++
title = "Git Collaboration"
type = "chapter"
weight = 6
+++

## Competency and Learning Objectives

### Competency:

Git Collaboration

### Learning Objectives:

- I can explain best practices in Git workflow, including engaging in a consistent workflow practice,
preventing merge conflicts, and performing code reviews.
- I can add collaborators to a single GitHub repository.
- I can open a pull request into main on GitHub and merge that feature branch, closing the PR.
- I can assign, review, respond, and approve reviews on a collaborator’s PR at specific lines of code.

## Introduction

At this point in the course, you have learned the basics of using `git` to get starter code from 
remote repositories, and to commit and push changes to your own copies of those repositories on
GitHub.  You have also learned to understand git branching and the branching graph nature of a Git
repository.

Git is useful as an individual, but it's real power comes when you use it to collaborate with
others.  Git allows multiple people to work on the same codebase at the same time and offers
powerful tools to manage changes, resolve conflicts, and review code.  GitHub, as a hosting
platform for Git repositories, enhances this collaboration by providing a user-friendly interface,
issue tracking, and pull requests for code reviews.

In this chapter, we will explore how to use the `git` tools that we have learned and the GitHub
repository hosting platform to build collaborative software projects.

## Assigning Collaborators to a Repository

To collaborate on a project using Git and GitHub, you first need to add collaborators to your
repository on GitHub. This allows others to contribute to your project by pushing changes
directly to the repository or by creating pull requests.

To add collaborators to your GitHub repository, follow these steps:

1. Navigate to your repository on GitHub.
2. Click on the "Settings" tab.
3. In the left sidebar, click on "Collaborators".
4. Click the "Add people" button at the bottom of the page.
5. Select the user from the dropdown list and click "Add collaborator".
6. The user will receive an email invitation to collaborate on the repository. They need to accept
   the invitation to gain access.
7. Once added, collaborators can clone the repository, create branches, make changes, and push
    their changes.

![add-collaborators](add-collaborators.png)

Remember to communicate with your collaborators about the workflow and guidelines for contributing
to the project to ensure a smooth collaboration process.

## Feature Branch Workflow

A common workflow for collaborating on a Git project is the feature branch workflow. In this
workflow, each collaborator creates a separate branch for each feature or bug fix they are
working on. This allows multiple people to work on different features simultaneously without
interfering with each other's work.

Here are the steps for using the feature branch workflow, presuming a collaborator named
Alice has been assigned to work on a feature for Bob's repository and wants to contribute
her changes to the main repository to have Bob review and merge them:

1. **Clone the Repository**: Alice clones the main repository to her local machine if she hasn't
   already done so using the tools in her editor/IDE or the command line:
   ```bash
   git clone https://github.com/bobs-software-inc/our-cool-project.git
   ```

2. **Create a New Branch**: Alice creates a new branch for her feature using the tools in her
   editor/IDE or the command line:
   ```bash
   git checkout -b user-management-feature
   ```

3. **Make Changes**: Alice makes changes to the codebase on her new branch. She can add new files,
   modify existing files, and delete files as needed. 

4. **Stage and Commit Changes**:
   When alice is ready to save her changes, she stages and commits them using the tools in her
   editor/IDE or the command line:
    ```bash
    git add -A 
    git commit -m "Add user management feature"
    ```

5. **Push the Branch to GitHub**: Alice pushes her feature branch to the remote repository on
    GitHub using the tools in her editor/IDE or the command line:
    ```bash
    git push origin user-management-feature
    ```




