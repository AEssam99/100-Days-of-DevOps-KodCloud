# Day 29: Manage Git Pull Requests

## Task Overview

In this task, **Max** wants to push new changes to a Git repository. However, pushing directly to the **`master`** branch is not allowed because it represents the **final, reviewed version of the code**.

To maintain proper development workflow and ensure code quality, all changes must go through a **Pull Request (PR)** process where another user reviews the changes before merging them into `master`.

In this scenario:

* **Max** creates a feature branch and pushes his story.
* A **Pull Request** is created to merge the branch into `master`.
* **Tom** reviews and approves the changes.
* The PR is then merged into the `master` branch.

This workflow ensures that no code reaches `master` without proper review and approval.

---

# Environment Details

### SSH Credentials

| User | Password    |
| ---- | ----------- |
| max  | Max_pass123 |
| tom  | Tom_pass123 |

### Pull Request Details

| Setting            | Value                      |
| ------------------ | -------------------------- |
| PR Title           | Added fox-and-grapes story |
| Source Branch      | story/fox-and-grapes       |
| Destination Branch | master                     |
| Reviewer           | tom                        |

---

# Solution

## 1. SSH into the Storage Server

Login to the storage server as **max**.

```bash
ssh max@storage
```

Enter the password:

```
Max_pass123
```

---

# 2. Navigate to Max's Cloned Repository

Max already has a cloned repository in his home directory.

Check available directories:

```bash
ls
```

Move into the repository:

```bash
cd <repository-name>
```

Example:

```bash
cd story-blog
```

---

# 3. Verify Repository Contents

Check the files inside the repository to confirm Sarah's story exists.

```bash
ls
```

You should see files related to the stories.

---

# 4. Verify Commit History

Run the following command to check commit history and author information.

```bash
git log
```

Validate the following:

* Commit authors
* Commit messages
* Commit history

Example output:

```
commit 8ab32df
Author: Max
Message: Added fox-and-grapes story

commit 3d12abc
Author: Sarah
Message: Added Sarah's story
```

---

# 5. Verify Max's Feature Branch

Max already pushed his story to the branch:

```
story/fox-and-grapes
```

Check available branches:

```bash
git branch -a
```

Expected output should include:

```
remotes/origin/story/fox-and-grapes
```

---

# 6. Open the Gitea Web Interface

Click the **Gitea UI** button available in the lab environment.

Login with Max's credentials:

```
Username: max
Password: Max_pass123
```

---

# 7. Create a Pull Request

Inside the repository UI:

1. Navigate to **Pull Requests**
2. Click **New Pull Request**

Configure the Pull Request:

| Field              | Value                      |
| ------------------ | -------------------------- |
| Title              | Added fox-and-grapes story |
| Source Branch      | story/fox-and-grapes       |
| Destination Branch | master                     |

Click **Create Pull Request**.

---

# 8. Assign Tom as Reviewer

Inside the newly created Pull Request:

1. Locate the **Reviewers** section on the right side.
2. Click **Reviewers**.
3. Add **tom** as a reviewer.

Now Tom is assigned to review the PR.

---

# 9. Logout From Max

Logout from the Gitea UI.

---

# 10. Login as Tom

Login again using Tom's credentials.

```
Username: tom
Password: Tom_pass123
```

---

# 11. Review the Pull Request

1. Navigate to **Pull Requests**.
2. Open the PR titled:

```
Added fox-and-grapes story
```

Review the changes made by Max.

---

# 12. Approve the Pull Request

Click **Review Changes**.

Select:

```
Approve
```

Submit the review.

---

# 13. Merge the Pull Request

Once approved:

1. Click **Merge Pull Request**
2. Confirm the merge

The branch **story/fox-and-grapes** will now be merged into **master**.

---

# 14. Verify the Merge (Optional)

SSH back into the server and update the local repository.

```bash
git checkout master
git pull
```

You should now see Max's story included in the master branch.

---

# Why Pull Requests Are Important

Pull Requests are an essential part of modern Git workflows because they:

* Prevent direct changes to the main branch
* Enable **code reviews**
* Improve **collaboration**
* Maintain **code quality**
* Provide **audit history**

Typical workflow used by development teams:

```
Feature Branch → Pull Request → Code Review → Approval → Merge to Master
```

---

# Final Workflow Summary

```
Max creates story branch
        │
        ▼
Push story/fox-and-grapes
        │
        ▼
Create Pull Request
        │
        ▼
Tom reviews and approves
        │
        ▼
Merge into master
```

---

# Result

Max's story **"The Fox and Grapes"** has successfully been:

* Pushed to a feature branch
* Reviewed by Tom
* Merged into the `master` branch using a Pull Request workflow.
