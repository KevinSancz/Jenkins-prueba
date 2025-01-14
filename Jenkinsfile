pipeline {
    agent any
    
    environment {
        // Ajusta según tu región y namespace de OCI
        OCI_REGISTRY  = 'iad.ocir.io'
        OCI_NAMESPACE = 'idxyojfomq6q' // tu namespace en OCI
        IMAGE_NAME    = 'repositorio_jenkins_emma'   // nombre de tu imagen local
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
                    credentialsId: '15050001',
                    usernameVariable: 'idxyojfomq6q/kevin.sanchez@ebiw.mx',
                    passwordVariable: 'ig}g0;66xL#}Uz1iGC10'
                )]) {
                    sh """
                      echo "\$ig}g0;66xL#}Uz1iGC10" | docker login \\
                        -u "\$idxyojfomq6q/oracleidentitycloudservice/kevin.sanchez@ebiw.mx" \\
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
