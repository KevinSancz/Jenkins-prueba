pipeline {
    agent any
    
    environment {
        OCI_REGISTRY  = 'iad.ocir.io'
        OCI_NAMESPACE = 'idxyojfomq6q'
        IMAGE_NAME    = 'prueba-jenkins-mi-app'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("${OCI_REGISTRY}/${OCI_NAMESPACE}/${IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Deploy') {
            steps {
                sh "docker compose down -v"
                sh "docker compose up -d --build"
            }
        }

        stage('Push to OCIR') {
            steps {
                script {
                    docker.withRegistry("https://${OCI_REGISTRY}", '15050001') {
                        dockerImage.push("${BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Pull from OCIR') {
            steps {
                script {
                    docker.withRegistry("https://${OCI_REGISTRY}", '15050001') {
                        sh "docker pull ${OCI_REGISTRY}/${OCI_NAMESPACE}/${IMAGE_NAME}:${BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh "docker rmi ${OCI_REGISTRY}/${OCI_NAMESPACE}/${IMAGE_NAME}:${BUILD_NUMBER}"
            }
        }
    }
}
