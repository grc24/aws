variable "openid_connect_idp_url" {
  description = "The URL of the OpenID Connect Identity Provider (IdP) for GitHub Actions."
  type        = string
}

variable "openid_connect_client_id" {
  description = "The client ID for the OpenID Connect Identity Provider (IdP) for GitHub Actions."
  type        = string
  default     = "sts.amazonaws.com"
}

variable "openid_connect_thumbprint" {
  description = "The thumbprint for the OpenID Connect Identity Provider (IdP) for GitHub Actions."
  type        = string
}

variable "github_repository" {
  description = "The GitHub repository in the format 'owner/repo' for which the IAM role is created."
  type        = string
}

variable "github_branch" {
  description = "The GitHub branch for which the IAM role is created."
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to create for GitHub Actions."
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role for GitHub Actions."
  type        = string
  default     = "GitHubActionsRole"
}
variable "epolicy_nam" {
  description = "The name of the IAM policy for GitHub Actions to access S3 backend."
  type        = string
  default     = "GitHubActionsS3Policy"
}

variable "Environment" {
  description = "The environment for the IAM role and policy (e.g., Dev, Prod)."
  type        = string
}