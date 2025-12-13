output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.strapi_server.public_ip
}

output "strapi_url" {
  description = "Access URL for Strapi on port 1337"
  value       = "http://${aws_instance.strapi_server.public_ip}:1337"
}
