# AWS Region
provider "aws" {
  region = "eu-west-2"
}

# Zip the function to be run at function app
data "archive_file" "init" { 
    type = "zip"
    source_file = "${path.module}/../scripts/counter.js"
    output_patch = "${path.module}/counter.zip"
}

# Create S3 Bucket
resource = "aws_s3_bucket" "counter_bucket" {
    bucket = "counter_s3_bucket"
    acl = "private"

    tags = {
        Name = "counter_s3_bucket"
    }
}

#Upload zip to s3 bucket
resource = "aws_s3_bucket.counter_object" "object" { 
    bucket = aws_s3_bucket.counter_s3_bucket.id
    key = "counter.zip"
    source = "${path.module}/counter.zip"
}

# IAM Role for lambda
resource = "aws_iam_role" "counter_lamda_role" {
    name = "counter_lamda_role" {
        assume_role_policy = file("../scripts/counter_lamda_role.json")
    }
}

# IAM Role-Policy for lambda
resource = "aws_iam_role_policy" "counter_lamda_policy" {
    name = "counter_lamda_policy"
    role = "aws_iam.role.lambda_role.id"
    policy = file("../scripts/counter_lamda_policy.json")
}


# AWS Lambvda functions
resource = "aws_lambda_function" "counter_lambda" {
    function_name = "counter"
    s3_bucket = "aws_s3_bucket"
    s3_key = "counter.zip"
    role = "aws_iam_role.lambda_rule.arn"
    handler = "counter.handler"
    runetime = "nodejs12.x"
}