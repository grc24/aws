module "namespace" {
  source = "../../modules/s3"

  bucket_name = var.bucket_name
  Environment = var.Environment
  acl         = var.acl
}