resource "aws_instance" "aws_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type_id
  count         = var.count_id
}