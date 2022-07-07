locals {
  prefix_name = "jjd-elasti-cache"
  prefixName = "jjdElastiCache"

  tags = {
    Name = "jjd-elasti-cache"
  }
}

resource "aws_elasticache_subnet_group" "jjd" {
  name       = local.prefix_name
  subnet_ids = [aws_subnet.jjd.id]
}

resource "aws_elasticache_replication_group" "jjd" {
  replication_group_id       = "${local.prefixName}Group"
  description                = "jjd elasticache replication group resource"
  node_type                  = "cache.t2.micro"
  num_cache_clusters         = 2
  parameter_group_name       = "default.redis6.x"
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  subnet_group_name          = aws_elasticache_subnet_group.jjd.name
}