terraform {
  backend "s3" {
    bucket = "jenkins-eks-cicd"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}