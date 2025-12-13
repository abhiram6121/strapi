# 🚀 Strapi Project Setup

## 🛠️ Prerequisites

Ensure you have the following tools installed and running:

* **Node.js LTS** (v20 or newer).
* **PostgreSQL Database** (Server installed and a dedicated database/user created).
* **Docker** (Engine and CLI).
* **Git** (For version control).

---

## 💻 Task 1: Project Creation & Initial Setup

Run the application on your host machine to initialize the database and create the initial administrator user.

### 1.1 Run the Creation Command:

Replace `my-project` with your desired name.

```bash
npx create-strapi-app@latest my-project
```

### 1.2 Configure Database:

When prompted, choose **`Custom (manual settings)`** and select the **`postgres`** client. Enter the credentials for your dedicated PostgreSQL database.

### 1.3 Navigate to Project Folder:

```bash
cd my-project
```

### 1.4 Start the Server:

```bash
npm run develop
```

### 1.5 Admin Panel Access:

The server will launch at **`http://localhost:1337`**. The **Admin Panel** will open automatically on the first run.
* **Action:** Create your initial **Administrator Account**.

---

## 🐳 Task 2: Standalone Container

This task demonstrates deploying Strapi as a single container [`Dockerfile`](Dockerfile) that connects to your host-installed PostgreSQL database.

### 2.1 Build and Run Commands

```bash
# ----------------------------------------------
# 1. Build the Docker Image
# ----------------------------------------------
# -t (tag): Names the image 'strapi-app' and gives it the version 'local'.
# . (dot): Specifies the current directory as the build context.
docker build -t strapi-app:local .

# ----------------------------------------------
# 2. Run the Docker Container
# ----------------------------------------------
# -it: Runs the container interactively with a pseudo-TTY (allows logs and Ctrl+C).
# --rm: Automatically removes the container filesystem when it exits (cleanup).
# --name: Assigns a memorable name to the container instance.
# -p 1337:1337: Maps the container's internal port 1337 to the host's port 1337.
# --env-file .env: Injects environment variables (like DB credentials) from your local .env file.
# --network host: Allows the container to connect to a PostgreSQL DB running on the host's localhost.
docker run -it --rm \
    --name strapi-cms-dev \
    -p 1337:1337 \
    --env-file .env \
    --network host \
    strapi-app:local
```

---

## ⚙️ Task 3: Set up a Dockerized Environment with Nginx Reverse Proxy

This task implements the standard production architecture by orchestrating all services (Strapi, PostgreSQL, Nginx) within a user-defined Docker network using **Docker Compose**.

### 3.1 Architecture Overview

This setup requires defining the multi-service architecture in docker-compose.yml, which creates a persistent database volume and configures the Nginx proxy.

| File Name | Purpose |
| :--- | :--- |
| **[`docker-compose.yml`](docker-compose.yml)** | Defines all three services, networking, and a persistent volume for PostgreSQL data. |
| **[`nginx.conf`](nginx.conf)** | Configures the Nginx container to reverse proxy host traffic to the internal Strapi service. |
| **[`Dockerfile`](Dockerfile)** | Used to build the final `strapi` container image. |

### 3.2 Launch Command

Run this command from your project root. It will build the Strapi image, create the `strapi-net` network, and start all three services in detached mode.

```bash
docker compose up -d --build
```

### 3.3 Access & Verification

- Access the Strapi Admin Dashboard via the Nginx reverse proxy. http://localhost/admin

- Confirm that all three services are running and that Nginx is exposing port 80:

```bash
docker compose ps
```

---

## ⚙️ Task 4: [Docker Deep-Dive](docker.md)

Dive into the core concepts, architecture, and advanced features of Docker, covering networking, volumes, and Docker Compose orchestration.

## 🏗️ Task 5: [Implement Strapi stack deployment using Terraform](terraform/README.md)

Provision EC2 instance, RDS PostgreSQL database, networking, and security groups. Configures EC2 with Docker via `user_data.sh` to run the containerized Strapi application.

## 📚 Project Structure

| Folder | Purpose |
| :--- | :--- |
| **`config`** | Global settings, including database connections and server ports. |
| **`api`** | Holds all your custom Content Types. |
| **`.env`** | Stores Environment Variables. |
| **`package.json`** | Defines project Dependencies and available Scripts. |
| **`Dockerfile`** | Instructions for building the Docker image. |
