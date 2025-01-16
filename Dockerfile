FROM python:3.10-slim

# Crea un archivo HTML básico
RUN echo '<h1>¡Hola desde mi contenedor nuevesito!</h1>' > /usr/share/index.html

# Expone el puerto 80
EXPOSE 80

# Comando para ejecutar un servidor HTTP
CMD ["python", "-m", "http.server", "80", "--directory", "/usr/share"]
