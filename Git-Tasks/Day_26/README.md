# Day 26: Git Manage Remotes

## Task

The development team has made updates to the project repository located at:

```
/opt/ecommerce.git
```

This repository is cloned locally at:

```
/usr/src/kodekloudrepos/ecommerce
```

The DevOps team must perform the following tasks:

1. Add a new Git remote named **dev_ecommerce** pointing to `/opt/xfusioncorp_ecommerce.git`.
2. Copy the file `/tmp/index.html` into the repository.
3. Commit the file to the **master** branch.
4. Push the **master** branch to the new remote repository.

---
## Solution
## Step 1: Navigate to the Repository

Move to the local cloned repository.

```bash
cd /usr/src/kodekloudrepos/ecommerce
```

---

## Step 2: Add the New Remote

Add a new remote called **dev_ecommerce** that points to the required repository.

```bash
sudo git remote add dev_ecommerce /opt/xfusioncorp_ecommerce.git
```

Verify the remote configuration:

```bash
git remote -v
```

Expected output:

```
dev_ecommerce   /opt/xfusioncorp_ecommerce.git (fetch)
dev_ecommerce   /opt/xfusioncorp_ecommerce.git (push)
origin          /opt/ecommerce.git (fetch)
origin          /opt/ecommerce.git (push)    
```

---

## Step 3: Copy the File into the Repository

Copy the file from `/tmp` into the current repository directory.

```bash
cp /tmp/index.html .
```

Confirm the file exists in the repository:

```bash
ls
```
Output:

```
index.html info.txt
```
---

## Step 4: Add and Commit the File

Add the new file to Git and commit it to the **master** branch.

```bash
sudo git add index.html
sudo git commit -m "Added index.html from /tmp"
```

Ensure the current branch is **master**:

```bash
git branch
```
Output:
```
* master
```

If not on the master branch, switch to it:

```bash
git checkout master
```

---

## Step 5: Push the Changes to the New Remote

Push the **master** branch to the newly created remote repository.

```bash
sudo git push dev_ecommerce master
```

## Result

After completing these steps:

* A new remote **dev_ecommerce** is configured.
* The file **index.html** is added and committed to the repository.
* The **master** branch is pushed successfully to the new remote repository.
