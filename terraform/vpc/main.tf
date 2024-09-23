##### VPC and AZs

resource "aws_vpc" "plantapp_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id       = aws_vpc.plantapp_vpc.id
  service_name = "com.amazonaws.${var.vpc_region}.s3"
  route_table_ids = [aws_vpc.plantapp_vpc.default_route_table_id]

  tags = {
    Name = "${var.vpc_name}-s3-gateway"
  }
}

# Data source to retrieve the available availability zones in the region
data "aws_availability_zones" "available" {}

###### Lambda Subnets

resource "aws_route_table" "lambda_private" {
  vpc_id = aws_vpc.plantapp_vpc.id
  tags = {
    Name = "lambda-private-route-table"
  }
}

resource "aws_subnet" "lambda_subnet" {
  count             = var.lambda_subnet_count
  vpc_id            = aws_vpc.plantapp_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = false
}

resource "aws_route_table_association" "lambda_subnet_assoc" {
  count          = var.lambda_subnet_count
  subnet_id      = aws_subnet.lambda_subnet[count.index].id
  route_table_id = aws_route_table.lambda_private.id
}

###### RDS Subnets

resource "aws_route_table" "rds_private" {
  vpc_id = aws_vpc.plantapp_vpc.id
  tags = {
    Name = "data-private-route-table"
  }
}

resource "aws_subnet" "rds_subnet" {
  count             = var.rds_subnet_count
  vpc_id            = aws_vpc.plantapp_vpc.id
  cidr_block        = "10.0.10${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = false
}

resource "aws_route_table_association" "rds_subnet_assoc" {
  count          = var.rds_subnet_count
  subnet_id      = aws_subnet.rds_subnet[count.index].id
  route_table_id = aws_route_table.rds_private.id
}