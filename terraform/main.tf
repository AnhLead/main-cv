terraform {
  require version = " >= 0.12.24"
}

provider "aws" {
    verison = " -> 2.0"
    region = "eu-west-2"
}

resource "aws_s3_bucket" "cv-site" {
    bucket = "cv.anhtran.co.uk"
    acl    = "public-read"

    website {
      index_document = "../website/index.html"

    }

    versioning = {
      enabled = true
    }
}