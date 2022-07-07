
resource "aws_vpc" "h7f" {
  cidr_block = "10.7.0.0/16"

  tags = {
    Name = local.prefix_name
  }
}

resource "aws_subnet" "h7f" {
  vpc_id            = aws_vpc.h7f.id
  cidr_block        = "10.7.7.0/24"

  tags = {
    Name = local.prefix_name
  }
}

resource "aws_kms_key" "h7f" {
  description             = local.prefix_name
  deletion_window_in_days = 7
}