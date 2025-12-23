## 🚀 Strapi on ECS Fargate: Automated Deployment

This project automates the provisioning of an AWS infrastructure that includes an RDS PostgreSQL database and an ECS Fargate instance running Strapi Docker containers.

### 🏗️ Infrastructure Overview

* **ECS Fargate:** Scalable, serverless container orchestration.
* **RDS PostgreSQL:** Fully managed database backend.
* **S3:** Remote state management with native locking.
* **Application Load Balancer (ALB):** Routes traffic and monitors service health.
* **CloudWatch Logs:** Centralized logging for real-time debugging and monitoring.

### ⚙️ How to Deploy

1. Go to the **Actions** tab in GitHub.
2. Select **CD - Terraform Deploy Strapi to ECS**.
3. Click **Run workflow** and enter your **Docker image tag**.

### 🔎 Post-Deployment

* **Access:** Copy the `alb_dns_name` from the GitHub Action output and open it in your browser with `/admin`.
* **Monitor:** Open the **CloudWatch Dashboard** in the AWS Console to view live app health.
* **Debug:** View **CloudWatch Logs** in the AWS Console to troubleshoot any application errors.