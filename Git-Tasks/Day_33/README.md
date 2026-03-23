# 📘 Day 33: Resolve Git Merge Conflicts

## 📝 Task Description

Sarah and Max are collaborating on a repository called **story-blog**. Max made changes locally and attempted to push them to the remote repository but encountered issues due to differing commit histories.

### Requirements:

* Sync local repository with the remote repository.
* Ensure `story-index.txt` contains **titles for all 4 stories**.
* Fix the typo:

  * ❌ `The Lion and the Mooose`
  * ✅ `The Lion and the Mouse`
* Successfully push the changes to the remote repository.

---

## ✅ Final Solution (Merge Approach)

Since both local and remote repositories have commits after a common base, the correct approach is to **merge the remote changes into the local branch**, then push.

---

### 🔄 Step 1: Pull remote changes (merge)

```bash
git pull origin master
```

---

### 🛠️ Step 2: Verify and fix files

* Open `story-index.txt`
* Ensure:

  * All **4 story titles** are present
  * Typo is corrected:

    ```
    The Lion and the Mouse
    ```
* Remove any conflict markers if they appear:

  ```
  <<<<<<<
  =======
  >>>>>>>
  ```

---

### ➕ Step 3: Stage changes

```bash
git add .
```

---

### 💾 Step 4: Commit merge (if required)

```bash
git commit -m "Merge remote changes and fix story index + typo"
```

---

### 🚀 Step 5: Push to remote

```bash
git push origin master
```

---

## 🎯 Outcome

* Local and remote repositories are successfully synchronized.
* All required story titles are present.
* Typo is fixed.
* Changes are pushed without errors.

---
