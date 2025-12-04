# 🚀 Strapi Project Setup

## 🛠️ Prerequisites

Ensure you have the following tools installed and running:

* **Node.js LTS** (v20 or newer).
* **PostgreSQL Database** (Server installed and a dedicated database/user created).
* **Docker** (Engine and CLI).
* **Git** (For version control).

---

## 💻 1. Project Creation & Initial Setup

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

---

## 🚀 2. Launching Strapi

### 2.1 Start the Server:

```bash
npm run develop
```

### 2.2 Admin Panel Access:

The server will launch at **`http://localhost:1337`**. The **Admin Panel** will open automatically on the first run.
* **Action:** Create your initial **Administrator Account**.

---

## 🐳 3. Dockerization

Build and run the application using the optimized [`Dockerfile`](Dockerfile).

### 3.1 Build and Run Commands

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

## 📚 Project Structure

| Folder | Purpose |
| :--- | :--- |
| **`config`** | Global settings, including database connections and server ports. |
| **`api`** | Holds all your custom Content Types. |
| **`.env`** | Stores Environment Variables. |
| **`package.json`** | Defines project Dependencies and available Scripts. |
| **`Dockerfile`** | Instructions for building the Docker image. |
