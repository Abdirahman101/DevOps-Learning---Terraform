resource "aws_instance" "this" {
  ami                     = local.instance_ami
  instance_type           = var.instance_type
}

resource "aws_instance" "import" {
  ami                     = local.instance_ami
  instance_type           = var.instance_type
  tags = {
    Name = "terraform_import"
  }
  user_data_replace_on_change = false
}