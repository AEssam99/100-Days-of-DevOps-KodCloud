# 📦 Day 38: Pull Docker Image

## 🧾 Task Overview

The Nautilus DevOps team is preparing a containerized environment to test new application features. As part of this process, a lightweight Docker image is required and must be properly tagged for internal usage.

This task demonstrates how to pull an existing Docker image and create a new custom tag for it.

---

## 🎯 Objective

* Pull the `busybox:musl` image on **App Server 2**
* Retag the image as `busybox:blog`
* Verify that both tags reference the same image

---

## 🛠️ Environment Details

| Component        | Value        |
| ---------------- | ------------ |
| Server           | App Server 2 |
| User             | steve        |
| Container Engine | Docker       |
| Image Used       | busybox:musl |

---

## ⚙️ Prerequisites

* Docker installed on the server
* Docker service running
* User with sufficient privileges (sudo/root if required)

---

## 🚀 Implementation Steps

### 1️⃣ Pull the Required Image

```bash
docker pull busybox:musl
```

This command downloads the BusyBox image with the `musl` tag from Docker Hub.

---

### 2️⃣ Verify Image Download

```bash
docker images
```

Expected output:

```
busybox   musl   <IMAGE_ID>   <CREATED>   <SIZE>
```

---

### 3️⃣ Retag the Image

```bash
docker tag busybox:musl busybox:blog
```

This creates a new tag (`blog`) for the same image without duplicating it.

---

### 4️⃣ Validate the Retagging

```bash
docker images
```

Actual output:

```
REPOSITORY   TAG    IMAGE ID       CREATED         SIZE
busybox      blog   0188a8de47ca   18 months ago   1.51MB
busybox      musl   0188a8de47ca   18 months ago   1.51MB
```

---

## 🔍 Result Analysis

* Both `musl` and `blog` tags exist
* Both share the same **IMAGE ID**
* Confirms successful retagging
* No duplicate images were created

---

## 🧠 Key Concepts

### 🔹 Docker Tagging

Docker tagging allows you to assign multiple names (tags) to a single image. This is useful for versioning, environment separation, and better organization.

### 🔹 Image ID

Each Docker image has a unique ID. Multiple tags can point to the same image ID, meaning they reference the same underlying image.

### 🔹 Storage Efficiency

Retagging does not create a new image or consume additional disk space—it simply creates another reference to the same image.

---

## ✅ Final Outcome

* Successfully pulled `busybox:musl`
* Successfully created a new tag `busybox:blog`
* Verified both tags reference the same image
* Task completed as per requirements

---

## 📌 Summary

This task highlights a fundamental Docker operation: image tagging. It is widely used in DevOps workflows to manage image versions and prepare images for different environments such as development, testing, and production.

---
