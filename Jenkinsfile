pipeline {
    agent any

    environment {
        OCI_REGISTRY  = 'iad.ocir.io'               // Ajusta según tu región
        OCI_NAMESPACE = 'idxyojfomq6q'             // Namespace en OCI
        IMAGE_NAME    = 'jenkins_pruebas'          // Repositorio en OCI
    }

    stages {
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("${OCI_REGISTRY}/${OCI_NAMESPACE}/${IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Deploy Locally') {
            steps {
                sh "docker compose down -v || true"
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

        stage('Validate Image') {
            steps {
                sh "docker run --rm ${OCI_REGISTRY}/${OCI_NAMESPACE}/${IMAGE_NAME}:${BUILD_NUMBER} echo 'Image is working!'"
            }
        }

        stage('Deploy to OKE') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: '15050001', // Cambia a tu ID de credenciales en Jenkins
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        # Crea un secreto de Docker en el clúster OKE para autenticación con el Container Registry
                        kubectl create secret docker-registry oci-registry-secret \
                            --docker-server=${OCI_REGISTRY} \
                            --docker-username=\$DOCKER_USER \
                            --docker-password=\$DOCKER_PASS \
                            --docker-email=kevin.sanchez@ebiw.mx || true

                        # Aplica los archivos de despliegue de Kubernetes
                        kubectl apply -f deployment.yaml
                        kubectl apply -f service.yaml
                    """
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh """
                   docker rmi ${OCI_REGISTRY}/${OCI_NAMESPACE}/${IMAGE_NAME}:${BUILD_NUMBER} || true
                   docker rmi ${OCI_REGISTRY}/${OCI_NAMESPACE}/${IMAGE_NAME}:latest || true
                """
            }
        }
    }
}
