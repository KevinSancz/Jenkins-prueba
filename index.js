const express = require('express');
const personaRoute = require('./src/persona');

const app = express();
const port = process.env.PORT || 80;

//Definicion de Middleware
app.use(express.json());

//Rutas
app.use('/persona', personaRoute);

app.get('/', (req, res) => {
  res.send("Hola a todos!");
});

app.listen(port, () => {
  console.log(`Server corriendo en: http://localhost:${port}`);
});
