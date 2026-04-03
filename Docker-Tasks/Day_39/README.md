# 🐳 Day 39: Create a Docker Image From Container

## 📌 Task Overview

One of the Nautilus developers was testing changes inside a running container and needed to **preserve those changes** by creating a new Docker image.

As part of the DevOps team, the task is to:

> ✅ Create a new image `official:xfusion` from the running container `ubuntu_latest`.

---

## 🖥️ Environment Details

| Parameter      | Value                |
| -------------- | -------------------- |
| Server         | Application Server 1 |
| Container Name | `ubuntu_latest`      |
| Base Image     | `ubuntu`             |
| Target Image   | `official:xfusion`   |

---

## 🔍 Step 1: Verify Container Status

Check if the container exists and is running:

```bash
docker ps -a
```

### ✔ Expected Output

```
CONTAINER ID   IMAGE     COMMAND       STATUS              NAMES
56b4ad6f64bc   ubuntu    "/bin/bash"   Up About a minute   ubuntu_latest
```

---

## ⚙️ Step 2: Create Image from Container

Use the `docker commit` command:

```bash
docker commit ubuntu_latest official:xfusion
```

### ✔ Output

```
sha256:e9f643aae09213e79414c47ca40b431b9e1b5f0a47b98a2f2072c0be32324c2b
```

---

## 🔎 Step 3: Verify the New Image

```bash
docker images
```

### ✔ Expected Output

```
REPOSITORY   TAG       IMAGE ID       SIZE
official     xfusion   e9f643aae092   139MB
ubuntu       latest    f794f40ddfff   78.1MB
```

---

## 🧠 Explanation

* The `docker commit` command:

  * Takes a snapshot of the container filesystem
  * Includes all changes made inside the container
  * Creates a new reusable image

---

## 📦 Final Result

| Component | Value                  |
| --------- | ---------------------- |
| Source    | `ubuntu_latest`        |
| New Image | `official:xfusion`     |
| Status    | ✅ Successfully created |

---

## ⚠️ Important Notes

* This method is useful for:

  * Quick backups
  * Testing environments
  * Debugging

* However, it is **not recommended for production** because:

  * ❌ Not reproducible
  * ❌ No version control
  * ❌ Hard to track changes

---

## 🏆 Best Practice (Recommended Approach)

Instead of using `docker commit`, use a **Dockerfile**:

```dockerfile
FROM ubuntu:latest
# Add your changes here
```

Then build the image:

```bash
docker build -t official:xfusion .
```

---

## 💡 Pro Tip

Add metadata while committing:

```bash
docker commit -m "Backup of container changes" -a "DevOps Team" ubuntu_latest official:xfusion
```

---

## 🚀 Conclusion

You have successfully:

* Captured container changes
* Created a new Docker image
* Verified its availability

This is a **key foundational skill in Docker and DevOps workflows**.
