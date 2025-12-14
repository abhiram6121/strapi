#!/bin/bash
set -e -x 

# 1. Update and Install Docker
yum update -y
yum install -y docker

# 2. Start and Enable Docker Service
service docker start
systemctl enable docker

# 3. Add 'ec2-user' to docker group
usermod -a -G docker ec2-user

export AWS_ACCESS_KEY_ID=${aws_access_key_id}
export AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}
export AWS_DEFAULT_REGION=${aws_region}

# 4. Log in to ECR
aws ecr get-login-password --region ${aws_region} | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com

# 5. Pull the latest container image
if [ "$(docker ps -a -q -f name=strapi)" ]; then
    docker stop strapi
    docker rm strapi
fi

docker pull ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com/${ecr_repo_name}:${docker_image_tag}

# 6. Run Strapi container
docker run -d \
  --name strapi \
  -p 1337:1337 \
  --restart unless-stopped \
  -e DATABASE_CLIENT=postgres \
  -e DATABASE_HOST=${db_host} \
  -e DATABASE_PORT=${db_port} \
  -e DATABASE_NAME=${db_name} \
  -e DATABASE_USERNAME=${db_user} \
  -e DATABASE_PASSWORD=${db_password} \
  -e DATABASE_SSL=true \
  -e DATABASE_SSL_REJECT_UNAUTHORIZED=false \
  -e JWT_SECRET=${jwt_secret} \
  -e ADMIN_JWT_SECRET=${admin_jwt_secret} \
  -e APP_KEYS=${app_keys} \
  -e API_TOKEN_SALT=${api_token_salt} \
  -e NODE_ENV=development \
  ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com/${ecr_repo_name}:${docker_image_tag}
