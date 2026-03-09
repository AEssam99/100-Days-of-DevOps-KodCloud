# Day 24: Git Create Branches
## Task
Nautilus developers are actively working on one of the project repositories, /usr/src/kodekloudrepos/news. 
Recently, they decided to implement some new features in the application, and they want to maintain those new changes in a separate branch. 
Below are the requirements that have been shared with the DevOps team:

1. On Storage server in Stratos DC create a new branch xfusioncorp_news from master branch in /usr/src/kodekloudrepos/news git repo.

2. Please do not try to make any changes in the code.
## Solution
### Go to the local repo
```sh
cd /usr/src/kodekloudrepos/news
```
### Check the available branches
```sh
sudo git branch
```
`Output`
```sh
* kodekloud_news
  master
```
### Create new branch from master branch
```sh
sudo git checkout master
sudo git branch -m xfusioncorp_news
```
Check
```sh
sudo git branch
```
```sh
  kodekloud_beta
* xfusioncorp_beta
```
