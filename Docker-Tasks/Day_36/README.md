# Day 36: Deploy Nginx Container on Application Server

## 📝 Task

The Nautilus DevOps team is conducting application deployment tests on selected application servers.

Deploy an **Nginx container** on **Application Server 3** with the following requirements:

* Use the **nginx image with alpine tag**
* Container name must be: `nginx_3`
* Ensure the container is in a **running state**

---

## ⚙️ Solution

### 1. Connect to Application Server 3

```bash
ssh user@app-server-3
```

### 2. Pull the Required Image

```bash
docker pull nginx:alpine
```

### 3. Run the Container

```bash
docker run -d --name nginx_3 nginx:alpine
```

### 4. Verify the Container Status

```bash
docker ps
```

---

## ✅ Result

* Container `nginx_3` is created successfully
* Image used: `nginx:alpine`
* Container is in **running state**

---

## 💡 Notes

* The `alpine` tag provides a lightweight version of the Nginx image
* If the container is not running, check logs using:

```bash
docker logs nginx_3
```
