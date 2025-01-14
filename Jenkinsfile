pipeline {
    agent any
    
    environment {
        OCI_REGISTRY  = 'iad.ocir.io'
        OCI_NAMESPACE = 'idxyojfomq6q'          // <-- tu namespace real
        IMAGE_NAME    = 'jenkins_prueba'
    }

    stages {
        stage('Build') {
            steps {
                echo "Etapa BUILD no disponible"
            }
        }

        stage('Tests') {
            steps {
                echo "Etapa TEST no disponible"
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
                // 1) Iniciar sesión en OCIR con credenciales guardadas en Jenkins
                withCredentials([usernamePassword(
                    credentialsId: '15050001',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                      echo "\$DOCKER_PASS" | docker login \\
                        -u "\$DOCKER_USER" \\
                        --password-stdin \\
                        \${OCI_REGISTRY}
                    """
                }

                // 2) Etiquetar la imagen local con la ruta de OCIR
                sh """
                  docker tag \${IMAGE_NAME} \${OCI_REGISTRY}/\${OCI_NAMESPACE}/\${IMAGE_NAME}:latest
                """

                // 3) Hacer push de la imagen a tu repo en OCIR
                sh """
                  docker push \${OCI_REGISTRY}/\${OCI_NAMESPACE}/\${IMAGE_NAME}:latest
                """
            }
        }
    }
}
