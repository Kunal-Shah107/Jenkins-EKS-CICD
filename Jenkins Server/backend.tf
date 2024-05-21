terraform {
  backend "s3" {
    bucket = "jenkins-eks-cicd"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}