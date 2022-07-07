locals {
  prefix_name = "x99-elasti-cache"
  prefixName = "x99ElastiCache"

  tags = {
    Name = "x99-elasti-cache"
  }
}

resource "aws_elasticache_subnet_group" "x99" {
  name       = local.prefix_name
  subnet_ids = [aws_subnet.x99.id]
}

resource "aws_elasticache_replication_group" "x99" {
  replication_group_id       = "${local.prefixName}Group"
  description                = "x99 elasticache replication group resource"
  node_type                  = "cache.t2.micro"

  # setting replicas requires failover and a parameter group with "cluster.on"
  num_node_groups            = 2
  replicas_per_node_group    = 1
  parameter_group_name       = "default.redis6.x.cluster.on"
  automatic_failover_enabled = true

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  subnet_group_name          = aws_elasticache_subnet_group.x99.name
}