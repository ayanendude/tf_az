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
    stage('init') {
      steps {
        echo 'hello'
        sh "/usr/local/bin/terraform --version"
        sh "/usr/local/bin/terraform init"
      }
    }
    stage('plan') {
      steps {
        echo 'hello'
        terraform plan
      }
    }
  }
}