import groovy.json.JsonOutput

pipeline {
  agent any
  stages {
    stage('SCM checkout') {
      steps {
        echo 'Checkout'
        sh "pwd"
        checkout scm
        script {
          env.ACTION = input(message: 'Please Provide Action', ok: 'Next',
                                        parameters: [
                                        choice(name: 'ACTION', choices: ['apply','destroy'].join('\n'), description: 'Please select the Action')])
          //env.ACTION = INPUT_PARAMS.Action
        }
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
        echo 'Changing Resources'
        script {
          if (env.ACTION == 'destroy') {
            sh "yes | cp -rf terraform.tfstate.backup terraform.tfstate"
          } 
        }
        sh "terraform ${env.ACTION} -auto-approve"
      }
    }
  }
}
