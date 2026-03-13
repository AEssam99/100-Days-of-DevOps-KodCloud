# Day 27: Git Revert Some Changes

## Task Description

The Nautilus application development team reported an issue with the latest commit pushed to the repository located at:

```
/usr/src/kodekloudrepos/official
```

The DevOps team was asked to **revert the repository HEAD to the previous commit**.

### Requirements

* Revert the **latest commit (HEAD)**.
* Restore the repository state to the **previous commit**.
* The new revert commit must use the message:

```
revert official
```

---

# Solution

### 1. Navigate to the Repository

```bash
cd /usr/src/kodekloudrepos/official
```

---

### 2. Verify the Commit History (Optional but Recommended)

```bash
sudo git log --oneline
```

Example output:

```
a1b2c3d Latest commit
f6e7g8h initial commit
```

---

### 3. Revert the Latest Commit

```bash
sudo git revert HEAD
```

This creates a new commit that **undoes the changes introduced in the latest commit**.

---

### 4. Update the Commit Message

```bash
sudo git commit --amend -m "revert official"
```

---

### 5. Verify the Result

```bash
sudo git log --oneline
```

Expected output:

```
z9y8x7w revert official
a1b2c3d Latest commit
f6e7g8h initial commit
```

The repository now contains a **new commit that reverses the changes from the previous commit**.

---

# Understanding `git revert`

`git revert` is used to **undo a commit by creating a new commit that reverses its changes**.

### Characteristics

* Does **not remove commit history**
* Creates a **new commit**
* Safe for **shared repositories**

### Example

Before revert:

```
A --- B --- C (HEAD)
```

Command:

```bash
git revert HEAD
```

After revert:

```
A --- B --- C --- D
              ↑
        D reverts C
```

---

# Understanding `git reset`

`git reset` moves the branch pointer to a previous commit, effectively **removing commits from the branch history**.

### Characteristics

* **Rewrites Git history**
* Removes commits from the branch
* Should **not be used after pushing to a shared repository**

### Example

Before reset:

```
A --- B --- C (HEAD)
```

Command:

```bash
git reset --hard HEAD~1
```

After reset:

```
A --- B (HEAD)
```

Commit **C is removed from the branch history**.

---

# Types of Git Reset

### Soft Reset

```bash
git reset --soft HEAD~1
```

Result:

* Commit removed
* Changes remain **staged**

---

### Mixed Reset (Default)

```bash
git reset HEAD~1
```

Result:

* Commit removed
* Changes remain **unstaged**

---

### Hard Reset

```bash
git reset --hard HEAD~1
```

Result:

* Commit removed
* Changes **deleted completely**

---

# Difference Between `git revert` and `git reset`

| Feature                      | git revert          | git reset         |
| ---------------------------- | ------------------- | ----------------- |
| Creates new commit           | Yes                 | No                |
| Removes commit history       | No                  | Yes               |
| Safe for shared repositories | Yes                 | No                |
| Rewrites Git history         | No                  | Yes               |
| Typical use case             | Undo pushed commits | Fix local commits |

---

# Key Takeaway

* **git revert** safely undoes a commit by creating a new commit.
* **git reset** rewrites history by moving the branch pointer to an earlier commit.

For **shared repositories and team environments**, `git revert` is the **recommended and safer approach**.
