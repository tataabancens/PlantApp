resource "aws_db_instance" "rds_db" {
    username          = var.db_username
    password          = var.db_password 

    identifier        = var.db_name
    engine            = "postgres"
    engine_version    = "16.3"
    port              = 5432
    instance_class    = "db.t3.medium"
    allocated_storage = 20
    multi_az          = true
    apply_immediately = true

    # Storage settings
    storage_type      = "gp3"
    max_allocated_storage = 20

    # Unnecesary characteristics
    performance_insights_enabled  = false
    monitoring_interval           = 0 
    skip_final_snapshot           = true

    # Security group
    vpc_security_group_ids = [var.security_group_id]

    # Subnets
    db_subnet_group_name = var.subnet_group_name

    tags = {
        Name = var.db_name
        Environment = "dev/test"
    }
}