resource "aws_instance" "this" {
  ami                     = "ami-0175d4f2509d1d9e8"
  instance_type           = "t3.micro"
}

resource "aws_instance" "import" {
  ami                     = "ami-0175d4f2509d1d9e8"
  instance_type           = "t3.micro"
  tags = {
    Name = "terraform_import"
  }
  user_data_replace_on_change = false
}