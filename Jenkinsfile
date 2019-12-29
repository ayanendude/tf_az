import groovy.json.JsonOutput

pipeline {
  agent any
  stages {
    stage('checkout') {
      steps {
        echo 'hello'
        sh "pwd"
        checkout scm
      }
    }
    stage('parallel tasks') {
      steps {
        parallel(
          a :  {
            echo 'hello'
            sh "/usr/local/bin/terraform --version"
          },
          b : {
            echo 'hello1'
            sh "/usr/local/bin/terraform init"
          }
        )
      }
    }
    stage('plan') {
      steps {
        echo 'hello'
        sh "/usr/local/bin/terraform plan"
      }
    }
    stage('approval') {
      timeout(time: 10, unit: 'MINUTES') {
      input message: "Does Pre-Production look good?"
      }
    }
  }
}