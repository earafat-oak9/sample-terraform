
resource "aws_vpc" "x99" {
  cidr_block = "10.9.0.0/16"

  tags = {
    Name = local.prefix_name
  }
}

resource "aws_subnet" "x99" {
  vpc_id            = aws_vpc.x99.id
  cidr_block        = "10.9.9.0/24"

  tags = {
    Name = local.prefix_name
  }
}

resource "aws_kms_key" "x99" {
  description             = local.prefix_name
  deletion_window_in_days = 7
}