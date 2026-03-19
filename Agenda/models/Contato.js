const Sequelize = require('sequelize');
const db = require('../db/connection');

const Contato = db.define('contato', {

    nome: {
        type: Sequelize.STRING,
        allowNull: false
    },
    idade: {
        type: Sequelize.INTEGER
    },
    empresa: {
        type: Sequelize.STRING
    },
    email: {
        type: Sequelize.STRING
    }

}, {
    timestamps: true // cria automaticamente createdAt e updatedAt
});

module.exports = Contato;