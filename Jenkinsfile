pipeline {
    agent any

    stages {
        stage('Preparar Docker CLI') {
            steps {
                sh '''
                    # Descargar y extraer el cliente de Docker versión 24.0.9 manualmente
                    curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-24.0.9.tgz
                    tar xzvf docker-24.0.9.tgz
                '''
            }
        }

      stage('Construir Imagen Docker') {
            steps {
                sh '''
                    rm -rf node_modules
                    # ¡Agregamos --no-cache aquí!
                    ./docker/docker build --no-cache -t hola-mundo-node:latest .
                    
                    # 2. Construimos la imagen (ahora el peso será de unos pocos KB)
                    ./docker/docker build -t hola-mundo-node:latest .
                '''
            }
        }

        stage('Ejecutar Contenedor Node.js') {
            steps {
                sh '''
                    # Detener y eliminar cualquier contenedor previo
                    ./docker/docker stop hola-mundo-node || true
                    ./docker/docker rm hola-mundo-node || true

                    # Ejecutar el contenedor de la aplicación
                    ./docker/docker run -d --name hola-mundo-node -p 3005:3000 hola-mundo-node:latest
                '''
            }
        }
    }
}