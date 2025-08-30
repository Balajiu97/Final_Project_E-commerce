pipeline {
    agent any

    environment {
        DEV_REPO  = "balajiyuva/dev"
        PROD_REPO = "balajiyuva/prod"
        DOCKER_CREDS = credentials('dockerhub-creds')
    }

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Build & Push') {
            steps {
                sh """
                  chmod +x ./build.sh
                  ./build.sh "${BRANCH_NAME}" "${BUILD_NUMBER}" "${DOCKER_CREDS_USR}" "${DOCKER_CREDS_PSW}" "${DEV_REPO}" "${PROD_REPO}"
                """
            }
        }

        stage('Deploy') {
            when { anyOf { branch 'dev'; branch 'master' } }
            steps {
                sh """
                  chmod +x ./deploy.sh
                  ./deploy.sh "${BRANCH_NAME}" "${BUILD_NUMBER}" "${DEV_REPO}" "${PROD_REPO}"
                """
            }
        }
    }

    post {
        success { echo "✅ Build & push successful for ${env.BRANCH_NAME}" }
        failure { echo "❌ Build failed for ${env.BRANCH_NAME}" }
    }
}
