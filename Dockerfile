# Usamos 'alpine' que es una versión súper ligera de Linux (ocupa menos RAM)
FROM node:20-slim

# Crear directorio de la aplicación
WORKDIR /usr/src/app

# Copiar SOLO los archivos de dependencias primero
COPY package.json ./

# Instalar SÓLO lo necesario para producción (ignora eslint y cosas pesadas)
RUN npm install 

# Copiar el resto de tus archivos (index.js, users.json, etc.)
COPY . .

# Exponer el puerto de la aplicación
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["node", "index.js"]