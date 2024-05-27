terraform {
  backend "s3" {
    bucket = "jenkins-eks-cicd-tf-pipeline"
    key    = "jenkins/terraform.tfstate"
    region = "me-central-1"
  }
}