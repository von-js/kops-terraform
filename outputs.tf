output "vpc_id" { 
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = data.aws_subnet_ids.subnet_ids.ids.*
}

output "networks" {
  value = var.network
}