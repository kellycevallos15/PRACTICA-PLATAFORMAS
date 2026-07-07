pipeline {
    agent any

    stages {
        stage('Preparar Docker CLI') {
            steps {
                sh '''
                    curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-24.0.9.tgz
                    tar xzvf docker-24.0.9.tgz
                '''
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                sh '''
                    # Borramos basura local para no saturar la RAM
                    rm -rf node_modules
                    
                    # Construimos la imagen limpia
                    ./docker/docker build --no-cache -t hola-mundo-node:latest .
                '''
            }
        }

        stage('Ejecutar Pruebas (Tests)') {
            steps {
                sh '''
                    # Ejecutamos los tests DENTRO de la imagen recién creada.
                    # El flag --rm destruye este contenedor temporal apenas termine el test.
                    ./docker/docker run --rm hola-mundo-node:latest npm test
                '''
            }
        }

        stage('Desplegar Contenedor Node.js') {
            steps {
                sh '''
                    # Si los tests pasaron exitosamente, llegaremos a este punto y se desplegará la app.
                    ./docker/docker stop hola-mundo-node || true
                    ./docker/docker rm hola-mundo-node || true
                    ./docker/docker run -d --name hola-mundo-node -p 3005:3000 hola-mundo-node:latest
                '''
            }
        }
    }
}