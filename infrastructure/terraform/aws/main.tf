terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "shopflow-terraform-state-arnab"
    key    = "shopflow/terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "shopflow_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "shopflow-vpc" }
}

resource "aws_internet_gateway" "shopflow_igw" {
  vpc_id = aws_vpc.shopflow_vpc.id
  tags   = { Name = "shopflow-igw" }
}

resource "aws_subnet" "shopflow_public_subnet" {
  vpc_id                  = aws_vpc.shopflow_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags                    = { Name = "shopflow-public-subnet" }
}

resource "aws_route_table" "shopflow_rt" {
  vpc_id = aws_vpc.shopflow_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shopflow_igw.id
  }
  tags = { Name = "shopflow-rt" }
}

resource "aws_route_table_association" "shopflow_rta" {
  subnet_id      = aws_subnet.shopflow_public_subnet.id
  route_table_id = aws_route_table.shopflow_rt.id
}

resource "aws_security_group" "shopflow_sg" {
  name        = "shopflow-sg"
  description = "ShopFlow security group"
  vpc_id      = aws_vpc.shopflow_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "shopflow-sg" }
}

resource "aws_ecr_repository" "order_service" {
  name                 = "shopflow/order-service"
  image_tag_mutability = "MUTABLE"
  tags                 = { Name = "shopflow-order-service" }
}

resource "aws_ecr_repository" "inventory_service" {
  name                 = "shopflow/inventory-service"
  image_tag_mutability = "MUTABLE"
  tags                 = { Name = "shopflow-inventory-service" }
}

resource "aws_ecr_repository" "notification_service" {
  name                 = "shopflow/notification-service"
  image_tag_mutability = "MUTABLE"
  tags                 = { Name = "shopflow-notification-service" }
}
