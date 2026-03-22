# 📘 Day 32: Git Rebase

## 🧩 Task Description

The Nautilus application development team is working on a Git repository located at:

```
/opt/blog.git
```

This repository is cloned on the storage server at:

```
/usr/src/kodekloudrepos
```

### 🔧 Scenario

* A developer is working on a **feature branch** with ongoing (in-progress) changes.
* Meanwhile, new commits have been pushed to the **master branch**.
* The developer wants to:

  * Update the feature branch with the latest changes from `master`
  * **Avoid creating a merge commit**
  * **Preserve all feature branch work (no data loss)**

---

## 🎯 Objective

Rebase the `feature` branch onto the latest `master` branch and push the updated branch.

---

# 🛠️ Solution Steps

## 1️⃣ Navigate to the Repository

```bash
cd /usr/src/kodekloudrepos
```

---

## 2️⃣ Fetch Latest Changes

```bash
git fetch origin
```

🔹 Ensures your local repo has the latest updates from the remote repository.

---

## 3️⃣ Switch to Feature Branch

```bash
git checkout feature
```

---

## 4️⃣ Rebase Feature onto Master

```bash
git rebase origin/master
```

🔹 This reapplies your feature commits on top of the updated master branch.

---

## ⚠️ Handling Conflicts (if any)

If conflicts occur:

```bash
# Fix conflicts manually in files
git add .

git rebase --continue
```

Repeat until the rebase completes.

---

## 5️⃣ Push Changes

```bash
git push origin feature --force
```

⚠️ Required because rebase rewrites commit history.

---

# 📊 Before vs After Rebase

### Before:

```
A → B → C (master)
     \
      D → E (feature)
```

### After:

```
A → B → C → D' → E' (feature)
```

🔹 `D'` and `E'` are new commits (rewritten history)

---

# 🧠 Understanding Git History

## What is Git History?

Git history is a chain (graph) of commits where:

* Each commit has a unique ID (hash)
* Each commit points to its parent
* History represents the timeline of changes

---

## Two Types of History Operations

### ✅ 1. Preserve History (Safe)

* Does NOT modify existing commits
* Adds new commits

Used by:

* `git merge`
* `git revert`

---

### ⚠️ 2. Rewrite History (Dangerous)

* Changes commit structure
* Creates new commit hashes

Used by:

* `git rebase`
* `git reset`
* `git cherry-pick`

---

# 🔍 Git Commands Comparison

## 🔹 git merge

### ✔️ Behavior:

* Combines branches
* Creates a **merge commit**
* Preserves full history

### 📊 Example:

```
A → B → C --------→ M
     \            /
      D → E -----
```

### ✅ Pros:

* Safe
* No history rewrite

### ❌ Cons:

* Messy commit graph

---

## 🔹 git rebase

### ✔️ Behavior:

* Moves feature branch onto another base
* Rewrites commit history

### 📊 Example:

```
A → B → C → D' → E'
```

### ✅ Pros:

* Clean, linear history
* No merge commits

### ❌ Cons:

* Rewrites history
* Requires force push

---

## 🔹 git reset

### ✔️ Behavior:

* Moves HEAD pointer backward
* Can delete commits

### Types:

* `--soft` → keep staged changes
* `--mixed` → keep working changes
* `--hard` → delete everything

### 📊 Example:

```
A → B → C  → reset to B → A → B
```

### ⚠️ Use Case:

* Undo local commits

---

## 🔹 git revert

### ✔️ Behavior:

* Creates a new commit that undoes previous changes

### 📊 Example:

```
A → B → C → R (revert of C)
```

### ✅ Safe for shared repos

---

## 🔹 git cherry-pick

### ✔️ Behavior:

* Copies a commit from one branch to another

### 📊 Example:

```
A → B → C → D' (copied from another branch)
```

### ⚠️ Creates duplicate commits (new hash)

---

# 📋 Summary Table

| Command     | Rewrites History | Creates Commit | Safe for Shared |
| ----------- | ---------------- | -------------- | --------------- |
| merge       | ❌ No             | ✅ Yes          | ✅ Yes           |
| rebase      | ✅ Yes            | ❌ (rewrites)   | ❌ No            |
| reset       | ✅ Yes            | ❌              | ❌ No            |
| revert      | ❌ No             | ✅ Yes          | ✅ Yes           |
| cherry-pick | ✅ Yes            | ✅ Yes          | ⚠️ Depends      |

---

# 🚨 Important Notes

* Never use `rebase` or `reset` on **shared/public branches**
* Always use `--force` push after rebase
* Rebase is best for **clean history before merging**

---

# 💡 Key Takeaways

* `merge` → combine branches safely
* `rebase` → rewrite history for clean linear flow
* `reset` → remove commits locally
* `revert` → undo changes safely
* `cherry-pick` → copy specific commits

---

# ✅ Final Commands Used

```bash
cd /usr/src/kodekloudrepos
git fetch origin
git checkout feature
git rebase origin/master
git push origin feature --force
```

---

## 🎉 Result

* Feature branch updated with latest master changes
* No merge commit created
* Clean and linear Git history maintained

---
