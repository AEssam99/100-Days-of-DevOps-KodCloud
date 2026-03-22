# Day 30: Git hard reset

## Task

The Nautilus development team has a test Git repository located at:

```
/usr/src/kodekloudrepos/demo
```

Several test commits were pushed to the repository, but these commits are no longer needed. The team wants to clean the repository history so that only the following two commits remain:

1. `initial commit`
2. `add data.txt file`

Current commit history:

```
a237e99 (HEAD -> master, origin/master) Test Commit10
b6f953c Test Commit9
819e74d Test Commit8
d2aa4c4 Test Commit7
0eb7d7f Test Commit6
90865f6 Test Commit5
c2b9631 Test Commit4
16382a3 Test Commit3
214b678 Test Commit2
5ebaa15 Test Commit1
d9e7b4f add data.txt file
43bf4a2 initial commit
```

The goal is to reset the repository so that the history ends at:

```
d9e7b4f add data.txt file
43bf4a2 initial commit
```

and remove all commits after it.

---

# Solution

### 1. Navigate to the Repository

```bash
cd /usr/src/kodekloudrepos/demo
```

---

### 2. Reset the Branch to the Desired Commit

Reset the branch to the commit **`add data.txt file`**.

```bash
sudo git reset --hard d9e7b4f
```

Explanation:

* `--hard` resets:

  * Commit history
  * Staging area
  * Working directory
* All commits after `d9e7b4f` will be removed locally.

---

### 3. Verify the Commit History

```bash
sudo git log --oneline
```

Expected output:

```
d9e7b4f add data.txt file
43bf4a2 initial commit
```

---

### 4. Push Changes to Remote Repository

Because the history was rewritten, a **force push** is required.

```bash
sudo git push origin master --force
```

This updates the remote repository so that it matches the local reset history.

---

# Final Result

The repository history will now contain only:

```
d9e7b4f add data.txt file
43bf4a2 initial commit
```

All test commits (`Test Commit1` → `Test Commit10`) are removed from both the **local** and **remote** repository.

---

# Key Git Concepts

### `git reset --hard`

* Moves the current branch pointer (`HEAD`) to a specified commit.
* Deletes commits after that point.
* Updates the working directory and staging area.

### Force Push (`--force`)

* Required when rewriting Git history.
* Overwrites the remote branch history with the local one.

---

# Commands Summary

```bash
cd /usr/src/kodekloudrepos/demo

sudo git reset --hard d9e7b4f

sudo git log --oneline

sudo git push origin master --force
```
