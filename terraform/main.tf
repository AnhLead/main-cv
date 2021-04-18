provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "cv-site" {
  bucket = "cv.anhtran.co.uk"
  acl    = "public-read"

  website {
    index_document = "index.html"

  }

}