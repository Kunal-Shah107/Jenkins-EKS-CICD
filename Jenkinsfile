pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
  parameters {
        choice choices: ['apply', 'destroy'], description: "Create or Destory", name: "action"
        choice choices: ['nginx', 'pac-man'], description: "Choose which application you want to deploy", name: "application"
    }
    stages {
        stage('Checkout SCM'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Kunal-Shah107/Jenkins-EKS-CICD.git']])
                }
            }
        }
        stage('Initializing Terraform'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform init'
                    }
                }
            }
        }
        //stage('Formatting Terraform Code'){
        //    steps{
        //        script{
        //            dir('EKS'){
        //                sh 'terraform fmt'
        //            }
        //        }
        //    }
       // }
        //stage('Validating Terraform'){
        //    steps{
        //        script{
        //            dir('EKS'){
        //                sh 'terraform validate'
        //            }
        //        }
        //    }
       // }
       // stage('Previewing the Infra using Terraform'){
          //  steps{
            //    script{
               //     dir('EKS'){
              //          sh 'terraform plan'
                //    }
                //    input(message: "Are you sure to proceed?", ok: "Proceed")
            //    }
          //  }
       // }
        stage('Creating/Destroying an EKS Cluster'){
            steps{
                script{
                    dir('EKS') {
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        stage('Deploying Nginx Application') {
            when {
                environment ignoreCase: true, name: "application", value: "nginx"
            }
            steps{
                script{
                    dir('EKS/ConfigurationFiles') {
                        sh 'aws eks update-kubeconfig --name my-eks-cluster'
                        sh 'aws sts get-caller-identity'
                        sh 'kubectl cluster-info'
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                    }
                }
            }
        }
        stage('Deploying Pac-Mac Game Application') {
            when {
                environment ignoreCase: true, name: "application", value: "pac-man"
            }
            steps{
                script{
                    dir('pac-man') {
                        sh 'aws eks update-kubeconfig --name my-eks-cluster'
                        sh 'aws sts get-caller-identity'
                        sh 'kubectl cluster-info'
                        sh 'terraform init'
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
    }
}
