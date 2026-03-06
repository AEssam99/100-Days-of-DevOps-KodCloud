# Day 22: Clone Git Repository on Storage Server
## Task 
The DevOps team established a new Git repository last week, which remains unused at present. However, the Nautilus application development team now requires a copy of this repository on the Storage Server in the Stratos DC. Follow the provided details to clone the repository:

1. The repository to be cloned is located at /opt/news.git

2. Clone this Git repository to the /usr/src/kodekloudrepos directory. Perform this task using the natasha user, and ensure that no modifications are made to the repository or existing directories, such as changing permissions or making unauthorized alterations.
## Solution
### Clone the repository
```sh
git clone /opt/news.git /usr/src/kodekloudrepos
```
This will:
- Use /opt/news.git as the source repository
- Create a normal working repository in /usr/src/kodekloudrepos
### Verify
```sh
ls /usr/src/kodekloudrepos
```
And check the remote:
```sh
cd /usr/src/kodekloudrepos
git remote -v
```
Expected output should show:
```sh
origin  /opt/news.git (fetch)
origin  /opt/news.git (push)
```
### 💡 Conceptually what happened
```sh
/opt/news.git      ← bare repository (server storage)
        │
        │ git clone
        ▼
/usr/src/kodekloudrepos   ← normal working repository
```
So now the development team can work in /usr/src/kodekloudrepos while the original repo remains unchanged.