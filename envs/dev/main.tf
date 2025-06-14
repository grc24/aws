module "namespace" {
  source = "../../modules/s3"

  bucket_name = var.bucket_name
  Environment = var.Environment
  acl         = var.acl
}


module "namespace_idp_ci" {
  source = "../../modules/idp-ci"

  openid_connect_idp_url    = var.openid_connect_idp_url
  openid_connect_thumbprint = var.openid_connect_thumbprint
  github_repository         = var.github_repository
  github_branch             = var.github_branch
  s3_bucket_name            = module.namespace.s3_bucket_name
  Environment               = var.Environment

}