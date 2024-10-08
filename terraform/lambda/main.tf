resource "aws_lambda_function" "plants" {
  function_name = "plants"
  role          = var.labrole_arn
  handler       = "plants.handler"
  runtime       = "nodejs18.x"

  environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

  filename = "${path.root}/../backend/lambdas.zip"

  
  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}

resource "aws_lambda_function" "plantsById" {
  function_name = "plantsById"
  role          = var.labrole_arn
  handler       = "plantsById.handler"
  runtime       = "nodejs18.x"

  environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

  filename = "${path.root}/../backend/lambdas.zip"

  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}

resource "aws_lambda_function" "plantsByIdWaterings" {
  function_name = "plantsByIdWaterings"
  role          = var.labrole_arn
  handler       = "plantsByIdWaterings.handler"
  runtime       = "nodejs18.x"

  environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

  filename = "${path.root}/../backend/lambdas.zip"

  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}
