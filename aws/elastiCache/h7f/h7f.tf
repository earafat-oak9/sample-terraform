# This is a cache cluster that uses a replication group
# For a single-node cache instance see jjd

locals {
  prefix_name = "h7f-elasti-cache"
  prefixName = "h7fElastiCache"

  tags = {
    Name = "h7f-elasti-cache"
  }
}

# resource "aws_elasticache_cluster" "h7f" {
#   cluster_id                 = "oak9-cptesting"
#   engine                     = "redis"
#   node_type                  = "cache.t2.micro"
#   num_cache_nodes            = 1
#   parameter_group_name       = "default.redis6.x"
#   engine_version             = "6.2"
#   port                       = 6379

#   tags = local.tags
# }

resource "aws_elasticache_replication_group" "h7f" {
  replication_group_id       = "${local.prefixName}Group"
  description                = "h7f elasticache replication group resource"
  node_type                  = "cache.t2.micro"
  num_cache_clusters         = 1
  parameter_group_name       = "default.redis6.x"
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  kms_key_id                 = aws_kms_key.h7f.arn
  subnet_group_name          = aws_elasticache_subnet_group.h7f.name
}

resource "aws_elasticache_subnet_group" "h7f" {
  name       = local.prefix_name
  subnet_ids = [aws_subnet.h7f.id]
}

# resource "aws_elasticache_user" "noPasswordUser" {
#   user_id       = "noPasswordUserId"
#   user_name     = "noPasswordUserName"
#   access_string = "on ~app::* -@all +@read +@hash +@bitmap +@geo -setbit -bitfield -hset -hsetnx -hmset -hincrby -hincrbyfloat -hdel -bitop -geoadd -georadius -georadiusbymember"
#   engine        = "REDIS"
#   no_password_required = true

#   tags = local.tags
# }

# resource "aws_elasticache_user" "yesPasswordUser" {
#   user_id       = "yesPasswordUserId"
#   user_name     = "yesPasswordUserName"
#   access_string = "on ~app::* -@all +@read +@hash +@bitmap +@geo -setbit -bitfield -hset -hsetnx -hmset -hincrby -hincrbyfloat -hdel -bitop -geoadd -georadius -georadiusbymember"
#   engine        = "REDIS"
#   passwords     = ["password123456789"]

#   tags = local.tags
# }

# resource "aws_elasticache_user_group" "h7f" {
#   engine        = "REDIS"
#   user_group_id = "yesNoUsersGroup"
#   user_ids      = [aws_elasticache_user.yesPasswordUser.user_id, aws_elasticache_user.noPasswordUser.user_id]
# }

