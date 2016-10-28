variable "ami" {
    default = {
        eu-west-1 = "ami-ee6b189d"
    }
}

variable "master_ami" {
    default = {
        eu-west-1 = "ami-ee6b189d"
    }
}

variable "key_name" {
    default = "model-office-aws"
    description = "SSH key name in your AWS account for AWS instances."
}

variable "key_path" {
    default = "/keys/model-office-aws.pem"
    description = "Path to the private key specified by key_name."
}

variable "region" {
    default = "eu-west-1"
    description = "The region of AWS, for AMI lookups."
}

variable "servers" {
    default = "3"
    description = "The number of k8s workers to launch."
}

variable "instance_type" {
    default = "m1.small"
    description = "The instance type to launch."
}

variable "master_instance_type" {
    default = "m1.small"
    description = "The instance type to launch."
}
