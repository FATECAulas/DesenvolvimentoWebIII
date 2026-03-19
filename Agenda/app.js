const express = require('express');
const app = express();
const db = require('./db/connection');
const Contato = require('./models/Contato');

const PORT = 3000;

// Rota inicial
app.get('/', (req, res) => {
    res.send('Está rodando');
});

// Rota para adicionar contato
app.get('/add', async (req, res) => {
    try {
        await Contato.create({
            nome: "Maria Oliveira",
            idade: 22,
            empresa: "Tech Solutions",
            email: "maria.oliveira@email.com",
            createdAt: new Date(),
            updatedAt: new Date()
        });

        res.send("Contato criado com sucesso!");
    } catch (err) {
        console.log(err);
        res.send("Erro ao criar contato");
    }
});

// Conexão com o banco + subir servidor
db.authenticate()
    .then(() => {
        console.log('Conexão com o banco de dados estabelecida com sucesso!');

        app.listen(PORT, () => {
            console.log(`Servidor rodando na porta ${PORT}`);
        });
    })
    .catch(err => {
        console.log('Não foi possível conectar ao banco de dados:', err);
    });