# Main Bucket
resource "aws_s3_bucket" "site_bucket" {
  bucket = "www.${var.bucket_name}"
  acl    = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.bucket_name}" })

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    index_document = "index.html"
  }

  tags = var.common_tags
}


# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "root_site_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"

  policy = templatefile("templates/s3-policy.json", { bucket = var.bucket_name })

# The CORS settings are required so that the content length of our files are sent to Cloudfront.
# Without this will result in lower scores on Google PageSpeed and GTMetrix.
  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }

  website {
    redirect_all_requests_to = "https://www.${var.domain_name}"
  }

  tags = var.common_tags
}


# SSL Certificate
resource "aws_acm_certificate" "ssl_certificate" {
  provider                  = aws.acm_provider
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "EMAIL"
  #validation_method         = "DNS"

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  provider        = aws.acm_provider
  certificate_arn = aws_acm_certificate.ssl_certificate.arn
}