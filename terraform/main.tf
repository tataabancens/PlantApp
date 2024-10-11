provider "aws" {
  region                   = var.region
  profile                  = "default"
  shared_credentials_files = ["${path.root}/aws_credentials"]
}

module "vpc" {
  source              = "./vpc"
  vpc_region          = var.region
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  lambda_subnet_count = var.vpc_lambda_subnet_count
  rds_subnet_count    = var.vpc_rds_subnet_count
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source            = "./rds"
  subnet_group_name = module.vpc.rds_subnet_group_name
  security_group_id = module.security_groups.rds_sg_id
  db_name           = var.rds_db_name
  db_username       = var.rds_db_username
  db_password       = var.rds_db_password
}

module "s3" {
  source      = "./s3"
  bucket_name = var.s3_bucket_name
}

module "rds_proxy" {
  source               = "./rds_proxy"
  planty_db_identifier = module.rds.id
  security_group_id    = module.security_groups.rds_proxy_sg_id
  vpc_subnet_ids       = module.vpc.rds_subnet_ids
  db_secret_arn        = module.secrets.rds_secret_arn
  labrole_arn          = var.iam_role_arn
}

module "secrets" {
  source      = "./secrets"
  secret_name = var.rds_secret_name
  db_username = var.rds_db_username
  db_password = var.rds_db_password
}

module "lambda" {
  source            = "./lambda"
  proxy_host        = module.rds_proxy.address
  db_username       = var.rds_db_username
  db_password       = var.rds_db_password
  db_port           = module.rds.port
  labrole_arn       = var.iam_role_arn
  lambda_subnet_ids = module.vpc.lambda_subnet_ids
  security_group_id = module.security_groups.lambdas_sg_id
}

module "api_gw" {
  source                = "./api_gw"
  get_plants            = module.lambda.plants.get
  create_plant          = module.lambda.plants.create
  get_plant_by_id       = module.lambda.plantsById.get
  delete_plant_by_id    = module.lambda.plantsById.delete
  get_plant_waterings   = module.lambda.plantsByIdWaterings.get
  create_plant_watering = module.lambda.plantsByIdWaterings.create
}

module "lambda_sql" {
  source                   = "./lambda_sql"
  proxy_host               = module.rds_proxy.address
  db_username              = var.rds_db_username
  db_password              = var.rds_db_password
  db_port                  = module.rds.port
  labrole_arn              = var.iam_role_arn
  subnet_ids               = module.vpc.lambda_subnet_ids
  lambda_security_group_id = module.security_groups.lambdas_sg_id
}

module "dynamo" {
  source = "./dynamo"
}
