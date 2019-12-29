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
        terraform init
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