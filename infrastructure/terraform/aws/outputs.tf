output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.shopflow_vpc.id
}

output "subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.shopflow_public_subnet.id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.shopflow_sg.id
}

output "order_service_ecr_url" {
  description = "ECR URL for order-service"
  value       = aws_ecr_repository.order_service.repository_url
}

output "inventory_service_ecr_url" {
  description = "ECR URL for inventory-service"
  value       = aws_ecr_repository.inventory_service.repository_url
}

output "notification_service_ecr_url" {
  description = "ECR URL for notification-service"
  value       = aws_ecr_repository.notification_service.repository_url
}
