# Multi-Cloud Landing Zone — Core Infrastructure Foundation
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
  }
}

variable "environment" {
  type    = string
  default = "production"
}

variable "primary_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.100.0.0/16"
}

resource "aws_vpc" "landing_zone_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-landing-zone-vpc"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Compliance  = "SOC2-Type-II"
  }
}

output "vpc_id" {
  description = "Provisioned Landing Zone VPC ID"
  value       = aws_vpc.landing_zone_vpc.id
}
