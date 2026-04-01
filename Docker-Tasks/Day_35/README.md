# Day 35: Install Docker Packages and Start Docker Service

## 📌 Task

The Nautilus DevOps team aims to containerize applications. As part of the initial setup, perform the following on **App Server 2**:

* Install **docker-ce**
* Install **docker compose**
* Start the **Docker service**

---

## 🛠️ Solution Steps

### 1. Install Required Utilities

```bash
sudo yum install -y yum-utils
```

---

### 2. Add Docker Repository

```bash
sudo yum-config-manager \
  --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

---

### 3. Install Docker Packages

```bash
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

---

### 4. (Optional) Install Standalone Docker Compose

```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
```

---

### 5. Start and Enable Docker Service

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

---

### 6. Verify Installation

```bash
docker --version
docker compose version
systemctl status docker
```

---

## ✅ Outcome

* Docker installed successfully
* Docker Compose available
* Docker service is running and enabled
# Docker Installation on App Server 2

## 📌 Task

The Nautilus DevOps team aims to containerize applications. As part of the initial setup, perform the following on **App Server 2**:

* Install **docker-ce**
* Install **docker compose**
* Start the **Docker service**

---

## 🛠️ Solution Steps

### 1. Install Required Utilities

```bash
sudo yum install -y yum-utils
```

---

### 2. Add Docker Repository

```bash
sudo yum-config-manager \
  --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

---

### 3. Install Docker Packages

```bash
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

---

### 4. (Optional) Install Standalone Docker Compose

```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
```

---

### 5. Start and Enable Docker Service

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

---

### 6. Verify Installation

```bash
docker --version
docker compose version
systemctl status docker
```

---

## ✅ Outcome

* Docker installed successfully
* Docker Compose available
* Docker service is running and enabled
