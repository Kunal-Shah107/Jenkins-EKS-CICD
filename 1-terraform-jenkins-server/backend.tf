terraform {
  backend "s3" {
    bucket = "jenkins-eks-cicd"
    region = "us-east-1"
    key = "jenkins-server/terraform.tfstate"
  }
}