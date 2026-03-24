# Day 34: Git Hook

---

## 📌 Task

The Nautilus application development team is working on a Git repository located at:

* Bare repository: `/opt/apps.git`
* Cloned repository: `/usr/src/kodekloudrepos/apps`

### Requirements:

1. Merge the `feature` branch into the `master` branch.
2. Before pushing changes, configure a **Git hook**.
3. The hook should:

   * Trigger whenever changes are pushed to the `master` branch.
   * Automatically create a release tag in the format:

     ```
     release-YYYY-MM-DD
     ```

     (Example: `release-2026-03-24`)
4. Test the hook to ensure it works.
5. Push changes and verify the tag.

> ⚠️ Note:
>
> * Perform all actions using the `natasha` user.
> * Do NOT modify repository permissions.

---

## ⚙️ Solution

### 1. Switch to required user

```bash
ssh natasha@ststor01
```

---

### 2. Navigate to cloned repository

```bash
cd /usr/src/kodekloudrepos/apps
```

---

### 3. Merge feature branch into master

```bash
git checkout master
git merge feature
```

---

### 4. Configure Git Hook on Bare Repository

Navigate to the bare repository hooks directory:

```bash
cd /opt/apps.git/hooks
```

Create the hook file:

```bash
vi post-update
```

---

### 5. Add the following script

```bash
#!/bin/bash

DATE=$(date +%F)
TAG="release-$DATE"

git tag $TAG
git push origin $TAG
```

---

### 6. Make the hook executable

```bash
chmod +x post-update
```

---

### 7. Push changes to trigger the hook

```bash
cd /usr/src/kodekloudrepos/apps
git push origin master
```

---

### 8. Fetch tags from remote

```bash
git fetch --tags
```

---

### 9. Verify the tag

```bash
git tag
```

Expected output:

```
release-2026-03-24
```

---

## 🧠 About Git Hooks

### What are Git Hooks?

Git hooks are **scripts that run automatically when specific Git events occur** (such as commit, push, or merge).

They help automate tasks and enforce rules in the development workflow.

---

### Types of Git Hooks

#### 1. Client-side hooks

Run on the developer's local machine.

Examples:

* `pre-commit` → before committing code
* `pre-push` → before pushing changes

---

#### 2. Server-side hooks

Run on the central (bare) repository.

Examples:

* `post-update` → after a push is completed
* `post-receive` → after receiving pushed data

---

### Why use Git Hooks?

* Automate repetitive tasks
* Enforce code quality (linting, tests)
* Prevent bad commits (secrets, wrong formats)
* Trigger CI/CD pipelines
* Auto-create release tags (like in this task)

---

## 🚀 Key Takeaways

* Server-side hooks must be placed in the **bare repository**
* Tags created by hooks are stored on the remote
* You must run:

  ```bash
  git fetch --tags
  ```

  to see them locally
* `post-update` is useful for actions after a push

---

## ✅ Final Workflow

```
Feature Branch → Merge → Push → Hook Triggered → Tag Created → Fetch Tags → Verified
```

---
