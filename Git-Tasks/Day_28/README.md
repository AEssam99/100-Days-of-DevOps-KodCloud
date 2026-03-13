# Day 28: Git Cherry Pick

## Task Description

The Nautilus application development team has been working on a project repository located at:

```
/opt/games.git
```

This repository is cloned on the **Storage Server** at:

```
/usr/src/kodekloudrepos/games
```

The repository contains two branches:

* `master`
* `feature`

A developer is currently working on the **feature branch**, and their work is still in progress. However, they need to merge **only one specific commit** from the `feature` branch into the `master` branch.

The commit that needs to be merged has the message:

```
Update info.txt
```

The task is to:

1. Identify the commit with the message **Update info.txt**.
2. Merge **only that commit** into the `master` branch without merging the entire `feature` branch.
3. Push the changes to the remote repository.

---

## Repository Commit History

Running the following command:

```
sudo git log --oneline
```

Produces the following output:

```
2d0a05b (HEAD -> feature, origin/feature) Update welcome.txt
cd6a848 Update info.txt
30188dc (origin/master, master) Add welcome.txt
62abea3 initial commit
```

From the output we can see:

* The required commit is:

```
cd6a848 Update info.txt
```

---

# Solution

### 1. Navigate to the repository

```
cd /usr/src/kodekloudrepos/games
```

---

### 2. Verify the commit in the feature branch

```
sudo git log feature --oneline
```

Locate the commit with the message:

```
cd6a848 Update info.txt
```

---

### 3. Switch to the master branch

```
sudo git checkout master
```

or

```
sudo git switch master
```

---

### 4. Merge the specific commit using Cherry-pick

```
sudo git cherry-pick cd6a848
```

This applies the changes from that specific commit onto the `master` branch.

---

### 5. Push the changes to the remote repository

```
sudo git push origin master
```

---

## Final Command Summary

```
cd /usr/src/kodekloudrepos/games
sudo git log feature --oneline
sudo git checkout master
sudo git cherry-pick cd6a848
sudo git push origin master
```

---

# Difference Between Normal Merge and Cherry-Pick

## 1. Normal Merge

A **normal merge** combines **all commits from one branch into another branch**.

Example:

```
git checkout master
git merge feature
```

Result:

```
master
A --- B --- C ----------- M
             \           /
feature       D --- E ---
```

* All commits from `feature` (`D` and `E`) are merged into `master`.
* A merge commit may be created.
* The full history of the branch is preserved.

### When to use normal merge

* When the entire branch is ready.
* When all commits should be integrated into the target branch.

---

## 2. Cherry-Pick

**Cherry-pick** applies **a specific commit from another branch** to the current branch.

Example:

```
git checkout master
git cherry-pick cd6a848
```

Result:

```
master
A --- B --- C --- D'

feature
             D --- E
```

* Only commit `D` is applied.
* A **new commit (`D'`)** is created with the same changes.
* Other commits from the branch are ignored.

### When to use Cherry-pick

* When only **one specific fix or feature** is needed.
* When a **hotfix** must be applied to production.
* When a branch contains unfinished work but a single commit is required.

---

# Key Comparison

| Feature  | Merge                    | Cherry-pick                  |
| -------- | ------------------------ | ---------------------------- |
| Scope    | Entire branch            | Single commit                |
| History  | Preserves branch history | Creates a new commit         |
| Use Case | Full feature integration | Selective commit integration |
| Command  | `git merge branch`       | `git cherry-pick <commit>`   |

---

# Conclusion

In this task, the correct approach was to use **`git cherry-pick`** because:

* The `feature` branch contains ongoing work.
* Only the commit **"Update info.txt"** needed to be merged.
* Cherry-pick allows selective integration without merging the entire branch.
