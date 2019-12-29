import groovy.json.JsonOutput

pipeline {
  agent any
  stages {
    stage('SCM checkout') {
      steps {
        echo 'Checkout'
        sh "pwd"
        checkout scm
      }
    }
    stage('Initial parallel tasks') {
      steps {
        parallel(
          Version :  {
            echo 'Version check'
            sh "/usr/local/bin/terraform --version"
          },
          Init : {
            echo 'Init TF'
            sh "/usr/local/bin/terraform init"
          }
        )
      }
    }
    stage('Plan') {
      steps {
        echo 'Executing Plan'
        sh "/usr/local/bin/terraform plan"
      }
    }
    stage('Approval') {
      steps{
        timeout(time: 10, unit: 'MINUTES') {
        input message: "Does Plan look good?"
        }
      }
    }
    stage('Create Resource') {
      steps {
        echo 'Creating Resources'
        sh "terraform destroy -auto-approve"
      }
    }
  }
}