pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
        }
    
    agent any
    tools{
        maven 'maven-3.9.6'
    }

    environment{
        aws_access_key_id = credentials('terraCred')
        aws_secret_access_key = credentials('terraCred')
    }
    stages {
            stage('Terraform Version') {
                steps {
                    echo 'Installed Terraform version is-'
                    sh 'terraform --version'
                }
            }
            stage('Terraform format') {
                steps {
                    echo 'All Terraform code is about to format now!'
                    sh 'terraform fmt'
                }
            }		
            stage('Terraform init') {
                steps {
                    echo 'Terraform Initialization is In Progress!'
                    sh 'terraform init'
                }
            }
            stage('Terraform Plan') {
                steps {
                    echo 'Your Terraform plan is-'
                    sh 'terraform plan -var-file=terraform.tfvars -out=tfplan.txt'

                }
            }
            stage('Approval') {
                when {
                    not {
                        equals expected: true, actual: params.autoApprove
                    }
                }

                steps {
                    script {
                        def plan = readFile 'tfplan.txt'
                        input message: "Do you want to apply the plan?",
                            parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                    }
                }
            }       
            stage('Terraform Apply') {
                steps {
                    echo 'Terraform Apply'
                    sh 'terraform destroy --auto-approve'
                }
            }
        }


}