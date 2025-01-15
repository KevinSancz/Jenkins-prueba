pipeline {
    agent any
    
    environment {
        // Reemplaza estos valores con tu configuración de OCI
        OCI_REGISTRY  = 'iad.ocir.io'
        OCI_NAMESPACE = 'idxyojfomq6q'
        IMAGE_NAME    = 'prueba-jenkins-mi-app'
        // Usaremos BUILD_NUMBER para etiquetas únicas
    }

    stages {

        // 1) Construcción con docker.build
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("${OCI_REGISTRY}/${OCI_NAMESPACE}/${IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        // 2) Despliegue con docker compose
        stage('Deploy') {
            steps {
                // Si necesitas que se despliegue usando docker-compose
                sh "docker compose down -v"
                sh "docker compose up -d --build"
            }
        }

        // 3) Empuja la imagen a OCI Registry
        stage('Push to OCIR') {
            steps {
                // Docker Pipeline maneja el login automático con docker.withRegistry
                script {
                    docker.withRegistry("https://${OCI_REGISTRY}", '15050001') {
                        dockerImage.push("${BUILD_NUMBER}")  // Etiqueta única
                        dockerImage.push("latest")           // Opcional: etiqueta "latest"
                    }
                }
            }
        }

        // 4) Limpieza local (opcional)
        stage('Cleanup') {
            steps {
                // Opcional: elimina la imagen local para liberar espacio
                sh "docker rmi ${OCI_REGISTRY}/${OCI_NAMESPACE}/${IMAGE_NAME}:${BUILD_NUMBER}"
            }
        }
    }
}
