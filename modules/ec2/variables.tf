variable "instance_type" {
    type = string
    default = "t3.micro"
}

locals {
    instance_ami = "ami-0175d4f2509d1d9e8"
}

output "instance_id" {
    description = "The ID of the EC2 instance"
    value = aws_instance.this.id
}

