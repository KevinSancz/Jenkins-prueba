FROM alpine:3.17

# Comando para imprimir el mensaje
CMD ["sh", "-c", "echo '¡Hola desde mi contenedor nuevesito!' && tail -f /dev/null"]
