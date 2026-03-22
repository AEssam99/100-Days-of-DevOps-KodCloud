# 📦 Day 31: Git Stash

## 📝 Task Description

The Nautilus application development team was working on a Git repository located at:

```
/usr/src/kodekloudrepos/blog
```

A developer previously saved some in-progress work using Git stash. Now, the requirement is to:

* Locate the stashed changes
* Restore the specific stash identified as `stash@{1}`
* Commit the restored changes
* Push them to the remote repository (`origin`)

---

## 🧠 What is Git Stash?

**Git stash** is a feature that allows you to temporarily save (or “stash”) changes in your working directory without committing them.

It helps you clean your working directory quickly while preserving your work for later use.

### 🔹 Key Idea:

> "Save your work without committing it, and come back to it later."

---

## ❓ Why Use Git Stash?

Git stash is useful in several real-world scenarios:

### ✅ 1. Switching Branches Quickly

You are working on a feature but need to urgently switch to another branch:

```bash
git stash
git checkout other-branch
```

---

### ✅ 2. Work in Progress (WIP)

Your code is incomplete and not ready for commit, but you need a clean workspace.

---

### ✅ 3. Avoid Dirty Commits

Instead of committing unfinished or broken code, stash it temporarily.

---

### ✅ 4. Experiment Safely

You can stash changes, try something new, and later restore your original work.

---

## 🔧 Solution Steps

### 🔹 Step 1: Navigate to the Repository

```bash
cd /usr/src/kodekloudrepos/blog
```

---

### 🔹 Step 2: View Available Stashes

```bash
git stash list
```

Example output:

```
stash@{0}: WIP on master: ...
stash@{1}: WIP on master: ...
```

---

### 🔹 Step 3: Restore the Required Stash

```bash
git stash apply stash@{1}
```

> 🔸 This restores the changes but keeps the stash محفوظ (safe option)

---

### 🔹 Step 4: Add Restored Changes

```bash
git add .
```

---

### 🔹 Step 5: Commit Changes

```bash
git commit -m "Restored stash@{1} changes"
```

---

### 🔹 Step 6: Push to Remote Repository

```bash
git push origin master
```

---

## ⚡ Optional: Remove the Stash

If you no longer need the stash:

```bash
git stash drop stash@{1}
```

---

## 🔄 Useful Git Stash Commands

| Command           | Description              |
| ----------------- | ------------------------ |
| `git stash`       | Save current changes     |
| `git stash list`  | View all stashes         |
| `git stash apply` | Restore stash (keep it)  |
| `git stash pop`   | Restore and delete stash |
| `git stash drop`  | Delete specific stash    |

---

## 📌 Summary

* Git stash helps you temporarily save work without committing
* You restored `stash@{1}` successfully
* Changes were added, committed, and pushed to origin
* Stash can optionally be removed after use

---

## ✅ Final Outcome

✔ Stashed changes restored
✔ Changes committed
✔ Repository updated on remote



