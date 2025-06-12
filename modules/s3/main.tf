resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.Environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  # Versioning can be enabled or suspended
  versioning_configuration {
    status = "Enabled"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id
  # Server-side encryption can be configured to use AES256 or aws:kms
  # This example uses AES256 for simplicity, but KMS can be used for more advanced encryption needs
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# resource "aws_s3_bucket_acl" "main" {
#   depends_on = [ aws_s3_bucket_ownership_controls.main ]
#   bucket = aws_s3_bucket.main.id
#   # The ACL can be set to private, public-read, public-read-write, authenticated-read, log-delivery-write, or bucket-owner-full-control
#   acl = var.acl
# }

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# resource "aws_s3_bucket_lifecycle_configuration" "main" {
#   bucket = aws_s3_bucket.main.id
#   # Lifecycle rules can be used to manage the lifecycle of objects in the bucket

#   rule {
#     id     = "log"
#     status = "Enabled"

#     filter {
#       prefix = "logs/"
#     }

#     expiration {
#       days = 30
#     }
#   }
# }
# resource "aws_s3_bucket_logging" "example" {
#   bucket        = aws_s3_bucket.example.id
#   target_bucket = aws_s3_bucket.example.id
#   target_prefix = "log/"
# }

# resource "aws_s3_bucket_notification" "example" {
#   bucket = aws_s3_bucket.example.id

#   topic {
#     events    = ["s3:ObjectCreated:*"]
#     topic_arn = "arn:aws:sns:us-east-1:123456789012:MyTopic"
#   }
# }
# resource "aws_s3_bucket_policy" "example" {
#   bucket = aws_s3_bucket.example.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = "s3:GetObject"
#         Resource  = "${aws_s3_bucket.example.arn}/*"
#       }
#     ]
#   })
# }


# Access control is managed using bucket policies and public access block configurations
