resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = var.repository_name
        BranchName     = var.branch_name
      }
    }
  }

#   stage {
#     name = "Build"

#      action {
#        name             = "Build"
#        category         = "Build"
#        owner            = "AWS"
#        provider         = "CodeBuild"
#        input_artifacts  = ["source_output"]
#        output_artifacts = ["build_output"]
#        version          = "1"

#        configuration = {
#          ProjectName = var.build_project_name
#        }
#      }
#    }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        ApplicationName = var.application_name
        EnvironmentName = var.environment_name
      }
    }
  }
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "codepipeline-webserver-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  acl    = "private"
}

