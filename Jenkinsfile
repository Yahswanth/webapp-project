pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "637423283722.dkr.ecr.us-east-1.amazonaws.com/webapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Yahswanth/webapp-project.git', branch: 'main'
            }
        }

        stage('Build & Unit Test') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t webapp:${IMAGE_TAG} .'
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh """
                aws ecr get-login-password --region $AWS_REGION \
                | docker login --username AWS --password-stdin $ECR_REPO
                docker tag webapp:${IMAGE_TAG} $ECR_REPO:${IMAGE_TAG}
                docker push $ECR_REPO:${IMAGE_TAG}
                """
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh """
                docker pull $ECR_REPO:${IMAGE_TAG}
                docker stop webapp || true
                docker rm webapp || true
                docker run -d -p 80:8080 --name webapp $ECR_REPO:${IMAGE_TAG}
                """
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
