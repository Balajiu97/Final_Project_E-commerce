pipeline {
  agent any

  environment {
    DOCKERHUB = credentials('dockerhub-creds')
    DOCKERHUB_USERNAME = "${DOCKERHUB_USR}"
    DOCKERHUB_TOKEN    = "${DOCKERHUB_PSW}"

    DEV_REPO  = "docker.io/${DOCKERHUB_USERNAME}/app-dev"
    PROD_REPO = "docker.io/${DOCKERHUB_USERNAME}/app-prod"
  }

  options {
    timestamps()
  }

  triggers {
    // For Multibranch, GitHub webhook triggers per-branch automatically
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Build & Push') {
      steps {
        sh '''
          chmod +x ./build.sh
          ./build.sh "${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD)}"
        '''
      }
    }

    stage('Deploy (optional)') {
      when { anyOf { branch 'dev'; branch 'master' } }
      steps {
        script {
          // Two options:
          // 1) Local (Jenkins node) deploy (if Jenkins IS the server):
          // sh 'chmod +x ./deploy.sh && ./deploy.sh "${BRANCH_NAME}"'

          // 2) Remote deploy over SSH (recommended):
          // Requires "SSH Agent" plugin and an SSH credential id 'deploy-ssh'
        }
      }
    }
  }

  post {
    success { echo "Build succeeded on ${env.BRANCH_NAME}" }
    failure { echo "Build failed on ${env.BRANCH_NAME}" }
  }
}
