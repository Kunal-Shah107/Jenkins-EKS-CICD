#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('2-terraform-eks-deployment') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws sts get-caller-identity"
                        sh "aws eks update-kubeconfig --name my-eks-cluster"
                        //sh "kubectl create -f eks-cluster-permissions.yaml"
                        //sh "kubectl apply -f nginx-deployment.yaml"
                        //sh "kubectl apply -f nginx-service.yaml"
                    }
                }
            }
        }
    }
}