terraform {
  required_version = ">= 0.15.1"
}

# AWS Region
provider "aws" {
  region = "eu-west-2"
}

# Zip the function to be run at function app
data "archive_file" "init" { 
    type = "zip"
    source_file = "${path.module}/../scripts/counter.py"
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
resource = "aws_iam_role" "counter_lambda_role" {
    name = "counter_lambda_role"
    assume_role_policy = file("../scripts/lambda_assume_role.json")
}

# IAM Role-Policy for lambda
resource = "aws_iam_role_policy" "counter_lambda_policy" {
    name = "counter_lambda_policy"
    role = "aws_iam.role.lambda_role.id"
    policy = file("../scripts/counter_lambda_policy.json")
}


# AWS Lambda functions
resource = "aws_lambda_function" "counter_lambda" {
    function_name = "counter"
    s3_bucket = "counter_s3_bucket"
    s3_key = "counter.zip"
    role = "aws_iam_role.counter_lambda_role.arn"
    handler = "counter.handler"
    runtime = "python3.8"
}