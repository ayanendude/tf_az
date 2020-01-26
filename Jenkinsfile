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
            sh "terraform --version"
          },
          Init : {
            echo 'Init TF'
            sh "terraform init"
          }
        )
      }
    }
    stage('Plan') {

      steps {
              script {
              def INPUT_PARAMS = input(message: 'Please Provide Parameters', ok: 'Next',
                                        parameters: [
                                        choice(name: 'ENVIRONMENT', choices: ['dev','qa'].join('\n'), description: 'Please select the Environment'),
                                        choice(name: 'ENVIRONMENT1', choices: ['dev','qa'].join('\n'), description: 'Please select the Environment')])
                        env.ENVIRONMENT = INPUT_PARAMS.ENVIRONMENT
                        env.IMAGE_TAG = INPUT_PARAMS.ENVIRONMENT1
      }
        echo 'Executing Plan'
        sh "terraform plan"
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
        sh "terraform apply -auto-approve"
      }
    }
  }
}
