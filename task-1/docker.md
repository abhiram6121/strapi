# 🐳 Docker: Concepts, Architecture, and Usage

## What is Docker?

Docker is an open-source platform for developing, shipping, and running applications.

It provides the ability to package and run an application in a loosely isolated environment called a **container**. Containers are lightweight, containing everything needed to run the application, which ensures consistency across different infrastructures and eliminates the "it works on my machine" problem.

---

## 💡 Docker vs. Virtual Machines

Containers and Virtual Machines (VMs) both offer resource isolation, but they function differently:

* **Containers** virtualize the **Operating System (OS)** kernel. They are lighter, faster, and more portable.
* **VMs** virtualize the **hardware**, requiring a full guest OS for every VM.

---

## ⚙️ Docker Architecture

Docker uses a **client-server architecture**. 

* **Docker Daemon (`dockerd`):** The server that listens for API requests and manages Docker objects (images, containers, networks, volumes).
* **Docker Client (`docker` command):** The primary way users interact with Docker by sending commands to the daemon.
* **Docker Registries (e.g., Docker Hub):** Stores Docker **images**.

---

## 📦 Containerization Process

The containerization workflow consists of three main steps: **Dockerfile**, **Build Image**, and **Run Container**.

### 1. Dockerfile (The Recipe)

A **Dockerfile** is a text file that contains instructions for building a Docker **image**.

| Instruction | Purpose |
| :--- | :--- |
| `FROM` | Specifies the base image to start from (e.g., `FROM node:18`). |
| `RUN` | Executes commands **during the image build** process (e.g., installing dependencies). |
| `COPY` | Copies files and directories from the host machine into the image. |
| `WORKDIR` | Sets the working directory for subsequent instructions. |
| `EXPOSE` | Documents which **ports** the container listens on at runtime. |
| `CMD` | Specifies the **default command** to run when a container starts. |
| `ENV` | Sets environment variables within the container. |

### 2. Build Image

The `docker build` command reads the Dockerfile instructions sequentially, creating a new image layer for each instruction.

### 3. Run Container

The `docker run` command creates a container instance from the built image and starts the application using the configuration defined in the Dockerfile.

---

## 🛠️ Key Docker Commands (Image and Container Management)

| Command | Category | Purpose |
| :--- | :--- | :--- |
| `docker build` | Image | Builds an image from a Dockerfile. |
| `docker images` | Image | Lists all locally stored images. |
| `docker rmi` | Image | Removes one or more local images. |
| `docker run` | Container | **Creates and starts** a new container from an image. |
| `docker ps` | Container | Lists **running** containers (use `-a` for all). |
| `docker stop / start / restart` | Container | Controls the container's lifecycle. |
| `docker rm` | Container | Removes one or more stopped containers. |
| `docker logs` | Container | Fetches and displays the output logs of a container. |

---

## 🗄️ Storage and Data Persistence

Data inside a container is lost when the container is removed. Docker provides persistent solutions:

| Solution | Persistence | Managed By | Primary Use Case |
| :--- | :--- | :--- | :--- |
| **Volumes** | **Persistent** | Docker | Databases, reliable storage, and shared data. **(Recommended)** |
| **Bind Mounts** | **Persistent** | Host OS | Local code development (instant reflection on host/container). |
| **tmpfs Mounts** | **Temporary** | Container Memory | Cache, logs, or transient, non-critical data. |

---

## 🌐 Networking

A Docker network allows containers to communicate. The choice of **network driver** dictates isolation and scope.

| Driver | Description & Scope | Primary Use Case |
| :--- | :--- | :--- |
| **Bridge** | **Default.** Internal network for containers on a **single host**. | Single-host deployments, general use. |
| **Overlay** | Distributed network that spans **multiple Docker hosts**. | **Docker Swarm** (multi-host clustering). |
| **Host** | **No isolation.** Containers share the host's network stack directly. | Performance-critical applications. |
| **Macvlan / IPvlan** | Assigns containers their own **MAC or IP address** on the host's physical network. | Integrating with existing complex physical networks. |

---

## 🚀 Docker Compose (Multi-Container Orchestration)

**Docker Compose** simplifies running **multi-container** applications by defining the entire stack (services, networks, volumes) in a single **`compose.yaml`** file.

### Key Benefits

* **Simplicity:** Spin up an entire development or testing environment with one command.
* **Consistency:** Configuration is the same everywhere the YAML file is used.

### Essential Compose Commands

| Command | Purpose |
| :--- | :--- |
| `docker compose up` | **Builds** (if needed) and **starts** all services. |
| `docker compose down` | **Stops** and **removes** all resources created by `up`. |
| `docker compose ps` | **Lists** the running containers for this application. |
| `docker compose exec [service]` | Executes a command in a running service container. |

## 📚 References & Further Reading

- https://docs.docker.com/get-started/
- https://pagertree.com/learn/docker