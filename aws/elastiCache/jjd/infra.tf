
resource "aws_vpc" "jjd" {
  cidr_block = "10.6.0.0/16"

  tags = {
    Name = local.prefix_name
  }
}

resource "aws_subnet" "jjd" {
  vpc_id            = aws_vpc.jjd.id
  cidr_block        = "10.6.6.0/24"

  tags = {
    Name = local.prefix_name
  }
}

resource "aws_kms_key" "jjd" {
  description             = local.prefix_name
  deletion_window_in_days = 7
}