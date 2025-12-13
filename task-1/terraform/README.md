## 🚀 Strapi on EC2: Automated Deployment with Terraform

The project automates the provisioning of an AWS infrastructure that includes an RDS PostgreSQL database and an EC2 instance running Strapi Docker containers.

### 🛠️ Prerequisites

* **AWS Account:** With necessary permissions
* **Terraform CLI:** (v5.0 or newer recommended).
* **AWS CLI:** Configured locally with access credentials.
* **Docker Image:** Build the Docker image locally and push it to AWS ECR

### ⚙️ Step-by-Step Deployment

#### 1. Prepare and Format Terraform Files
Start by formatting your Terraform configuration files to ensure proper syntax:

```bash
 terraform fmt
 ```

#### 2. Initialize Terraform
Initialize your working directory to install required providers:

```bash 
terraform init
```

#### 3. Validate the Configuration
Validate configuration syntax:

```bash 
terraform validate
```

#### 4. Plan the Deployment
Review the planned actions before deploying:

```bash
 terraform plan
 ```

Check the output to verify resources will be created as intended.

#### 5. Apply the Infrastructure
Deploy resources to AWS:

```bash
 terraform apply
 ```

Type `yes` when prompted to proceed.

#### 6. Post-Deployment
Once deployment completes, your infrastructure includes:
- An RDS PostgreSQL 17 instance.
- An EC2 instance that runs a `user_data.sh` script to pull the Docker image from ECR and launch the Strapi container.
- Security groups and networking set up for secure access.

#### 7. Managing Resources
- To update or reconfigure, modify `.tf` files, run `terraform plan`, then `terraform apply`.
- To tear down resources: `terraform destroy`

---

## Tips & Best Practices
- Keep sensitive variables (like passwords) in a secure `.tfvars` file or environment variables.
- Use `terraform fmt` regularly for code consistency.
- Check resource statuses on AWS Console if needed.

---
