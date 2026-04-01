# 📦 Day 37: Copy File to Docker Container

## 📝 Task Description

The Nautilus DevOps team has confidential data stored on **App Server 2** in the Stratos Datacenter.

A running container named **`ubuntu_latest`** exists on the same server.

### 🎯 Objective:

Copy the encrypted file:

```
/tmp/nautilus.txt.gpg
```

From the **Docker host** → into the container at:

```
/opt/
```

### ⚠️ Important Requirement:

* The file must remain **unchanged (no modification/decryption)** during the transfer.

---

## 🛠️ Solution

### Step 1: Copy file from host to container

```bash
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/opt/
```

---

### Step 2: Verify file inside container

```bash
docker exec ubuntu_latest ls /opt/
```

### ✅ Expected Output:

```
nautilus.txt.gpg
```

---

## 🔍 Optional Verification (Integrity Check)

To ensure the file was not modified during transfer, compare checksums.

### On Host:

```bash
md5sum /tmp/nautilus.txt.gpg
```

### Inside Container:

```bash
docker exec ubuntu_latest md5sum /opt/nautilus.txt.gpg
```

### ✅ Result:

* Both hashes should be **identical**

---

## 🧠 Key Concepts

### 🔹 docker cp

* Used to copy files between **host ↔ container**
* Works without requiring volumes
* Preserves file content exactly (binary-safe)

### 🔹 Why this works for encrypted files

* `.gpg` files are treated as **binary data**
* No interpretation or modification happens during copy

---

## ⚡ Notes

* Container must be **running**
* Destination directory (`/opt/`) must exist inside container
* No need to access container shell for copying

---

## ✅ Final Status

✔ File successfully copied
✔ File verified inside container
✔ File integrity preserved

---

## 🚀 Summary

This task demonstrates how to securely transfer files into a running container using `docker cp` while maintaining data integrity — a common DevOps operation for quick file injection and troubleshooting.
