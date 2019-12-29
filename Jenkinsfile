import groovy.json.JsonOutput

pipeline {
  agent any
  stages {
    stage('checkout') {
      steps {
        echo 'hello'
        checkout scm
      }
    }
    stage('parallel tasks') {
      steps {
        parallel(
          a :  {
            echo 'hello'
            sh "/usr/local/bin/terraform --version"
            sh "/usr/local/bin/terraform init"
          },
          b : {
            echo 'hello1'
            sh "/usr/local/bin/terraform --version"
            sh "/usr/local/bin/terraform init"
          }
        )
      }
    }
    stage('plan') {
      steps {
        echo 'hello'
        sh "sudo /usr/local/bin/terraform plan"
      }
    }
  }
}