# Day 25: Git Merge Branches
## Task
The Nautilus application development team has been working on a project repository /opt/blog.git. 
This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. 
They recently shared the following requirements with DevOps team:

* Create a new branch devops in /usr/src/kodekloudrepos/blog repo from master and copy the /tmp/index.html file (present on storage server itself) into the repo. 
* Further, add/commit this file in the new branch and merge back that branch into master branch. 
* Finally, push the changes to the origin for both of the branches.
## Solution
### Navigate to the repository
```sh
cd /usr/src/kodekloudrepos/blog
```
### Ensure you are on the master branch and up-to-date
```sh
sudo git checkout master
sudo git pull origin master
```
### Create a new branch devops
```sh
sudo git checkout -b devops
```
### Copy the file from /tmp/index.html into the repo
```sh
cp /tmp/index.html .
```
### Add and commit the new file
```sh
sudo git add index.html
sudo git commit -m "Add index.html from /tmp to devops branch"
```
### Push the devops branch to origin
```sh
sudo git push -u origin devops
```
### Merge devops branch back into master
Switch to master:
```sh
sudo git checkout master
```
Merge:
```sh
sudo git merge devops
```
### Push the updated master branch
```sh
sudo git push origin master
```
