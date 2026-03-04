# Day 21: Set Up Git Repository on Storage Server
## Task
The Nautilus development team has provided requirements to the DevOps team for a new application development project, 
specifically requesting the establishment of a Git repository. 
Follow the instructions below to create the Git repository on the Storage server in the Stratos DC:

1- Utilize yum to install the git package on the Storage Server.

2- Create a bare repository named /opt/media.git (ensure exact name usage).
## Solution
### What is the bare repo?
A bare repository:

- Does NOT contain a working directory

- Is typically used as a central remote repository

- Is what you push to from other machines

It’s commonly used for:

- Shared team repositories

- Git servers

- Deployment targets
### Install git
```sh
sudo dnf update -y
sudo dnf install git -y
```
### Create the bare repository
```sh
sudo git init --bare /opt/media.git
```
`Output`
```sh
Initialized empty Git repository in /opt/media.git/
```
Check:
```sh
ls /opt/media.git
```
The output must be like
```sh
HEAD  branches  config  description  hooks  info  objects  refs
```
