## 🛠️ Prerequisites

Ensure you have the following tools installed and ready:

* **Node.js LTS:** The latest stable version of Node.js.
* **PostgreSQL Database:** Database server installed and running.

---

## 💻 1. Project Creation & Setup

1.  **Run the Creation Command:**
    Replace `my-project` with your desired name.

    ```bash
    npx create-strapi-app@latest my-project
    ```

2.  **Configure Database:**
    When prompted, choose the `postgres` client for the Default database client option. Enter the credentials for the dedicated database and user you created.

3.  **Navigate to Project Folder:**
    ```bash
    cd my-project
    ```

---

## 🚀 2. Launching Strapi

1.  **Start the Server:**
    ```bash
    npm run develop
    ```

2.  **Admin Panel Access:**
    The server will launch at **`http://localhost:1337`**. The **Admin Panel** will open automatically on the first run.
    * **Action:** Create your initial **Administrator Account**.

---

## 📚 3. Project Structure

| Folder | Purpose |
| :--- | :--- |
| **`config`** | Global settings, including database connections and server ports. |
| **`api`** | Holds all your custom Content Types. |
| **`.env`** | Stores Environment Variables. |
| **`package.json`** | Defines project Dependencies and available Scripts. |

---
