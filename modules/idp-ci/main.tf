# Create an IAM OIDC identity provider for token.actions.githubusercontent.com
resource "aws_iam_openid_connect_provider" "main" {
  url = var.openid_connect_idp_url

  lifecycle {
    prevent_destroy = true
  }

  client_id_list = [
    var.openid_connect_client_id,
  ]

  thumbprint_list = [
    var.openid_connect_thumbprint,
  ]

  tags = {
    Name        = "GitHub Actions OIDC Provider"
    Environment = var.Environment
  }
}

# Create an IAM role for GitHub Actions to assume
resource "aws_iam_role" "main" {
  name = var.role_name

  depends_on = [aws_iam_openid_connect_provider.main]

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "${aws_iam_openid_connect_provider.main.arn}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:aud" = "${var.openid_connect_client_id}",
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_repository}:ref:refs/heads/${var.github_branch}"
          }
        }
      }
    ]
  })

  tags = {
    Name        = "GitHub Actions Role"
    Environment = var.Environment
  }
}

#  IAM Policy for your S3 backend
resource "aws_iam_policy" "main" {
  name        = var.epolicy_nam
  description = "Policy for GitHub Actions to access S3 backend"


  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [

      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetBucketPolicy"
        ],
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}/terraform.tfstate",
          "arn:aws:s3:::${var.s3_bucket_name}/terraform.tfstate.tflock"
        ]
      }
    ]
  })
  tags = {
    Name        = "GitHub Actions S3 Policy"
    Environment = var.Environment
  }
}



# Attach the S3 policy to the GitHub Actions role
resource "aws_iam_role_policy_attachment" "github_actions_s3_policy_attachment" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}


#AllowOIDCProviderAccess
resource "aws_iam_policy" "allow_oidc_provider_access" {
  name        = "AllowOIDCProviderAccess"
  description = "Policy for GitHub Actions to access the OIDC provider"
  tags = {
    Name        = "Allow OIDC Provider Access"
    Environment = var.Environment
  }

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "iam:GetOpenIDConnectProvider"
        ],
        Resource = "${aws_iam_openid_connect_provider.main.arn}"
      },
    ]
  })
}

# Attach the role to the OIDC provider
resource "aws_iam_role_policy_attachment" "github_actions_oidc_provider_attachment" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.allow_oidc_provider_access.arn
}