FROM node:16

# Crear directorio de la aplicación
WORKDIR /usr/src/app

# Copiar dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el código de la aplicación
COPY . .

# Exponer el puerto (debe coincidir con el puerto de tu app)
EXPOSE 80

# Comando para iniciar la aplicación
CMD ["node", "index.js"]
