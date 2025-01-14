pipeline {
    agent any
    
    environment {
        // Ajusta según tu región y namespace de OCI
        OCI_REGISTRY  = 'iad.ocir.io'
        OCI_NAMESPACE = ':<zB88.[)r>qF4LrMJHi'           // tu namespace en OCI
        IMAGE_NAME    = 'repositorio_jenkins_emma' // el nombre de tu imagen local
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
                // --build se encarga de construir la imagen local (IMAGE_NAME)
                sh "docker compose up -d --build"
            }
        }

        stage('Push to OCIR') {
            steps {
                // 1) Iniciar sesión en OCIR con credenciales guardadas en Jenkins
                withCredentials([usernamePassword(
                    credentialsId: '15050001',   // El ID exacto que pusiste en Jenkins
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
