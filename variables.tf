variable "vpc_name" {
  description = "Name to use for the vpc"
  type        = string
  default     = "kubernetes_cluster"
}

variable "cidr_block" {
  description = "The cidr block for the vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "network" {
  description = "The cidr block and azs for each subnet"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    n0 = {
      cidr_block        = "10.0.0.0/24"
      availability_zone = "ap-southeast-1a"
    },
    n1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-southeast-1b"
    },
    n2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-southeast-1c"
    }
  }
}

