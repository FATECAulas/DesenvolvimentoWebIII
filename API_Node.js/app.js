const mysql = require('mysql2');
const express = require('express');

const app = express();
const PORT = 3000;

// Middleware para parsear JSON
app.use(express.json());

// 1. Configurar Conexão
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'loja'
});

connection.connect((err) => {
  if (err) throw err;
  console.log('Conectado ao MySQL!');
});

// 2. Inserir Dados (CREATE) - POST /produtos
app.post('/produtos', (req, res) => {
  const { nome, valor } = req.body;

  // Validação: preço não pode ser negativo
  if (valor < 0) {
    return res.status(400).json({ erro: 'O preço não pode ser negativo' });
  }

  const sqlInsert = 'INSERT INTO produtos (nome, valor) VALUES (?, ?)';
  connection.query(sqlInsert, [nome, valor], (err, result) => {
    if (err) {
      return res.status(500).json({ erro: err.message });
    }
    res.status(201).json({ 
      mensagem: 'Produto inserido com sucesso',
      id: result.insertId,
      nome: nome,
      valor: valor
    });
  });
});

// 3. Consultar Dados (READ) - GET /produtos
app.get('/produtos', (req, res) => {
  const sqlSelect = 'SELECT * FROM produtos';
  connection.query(sqlSelect, (err, results) => {
    if (err) {
      return res.status(500).json({ erro: err.message });
    }
    res.json(results);
  });
});

// 4. Consultar um Produto Específico (READ) - GET /produtos/:id
app.get('/produtos/:id', (req, res) => {
  const { id } = req.params;
  const sqlSelect = 'SELECT * FROM produtos WHERE id = ?';
  connection.query(sqlSelect, [id], (err, results) => {
    if (err) {
      return res.status(500).json({ erro: err.message });
    }
    if (results.length === 0) {
      return res.status(404).json({ erro: 'Produto não encontrado' });
    }
    res.json(results[0]);
  });
});

// 5. Atualizar Dados (UPDATE) - PUT /produtos/:id
app.put('/produtos/:id', (req, res) => {
  const { id } = req.params;
  const { nome, valor } = req.body;

  // Validação: preço não pode ser negativo
  if (valor !== undefined && valor < 0) {
    return res.status(400).json({ erro: 'O preço não pode ser negativo' });
  }

  // Construir query dinamicamente
  let sqlUpdate = 'UPDATE produtos SET ';
  const params = [];

  if (nome !== undefined) {
    sqlUpdate += 'nome = ?';
    params.push(nome);
  }

  if (valor !== undefined) {
    if (params.length > 0) {
      sqlUpdate += ', ';
    }
    sqlUpdate += 'valor = ?';
    params.push(valor);
  }

  sqlUpdate += ' WHERE id = ?';
  params.push(id);

  connection.query(sqlUpdate, params, (err, result) => {
    if (err) {
      return res.status(500).json({ erro: err.message });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ erro: 'Produto não encontrado' });
    }
    res.json({ 
      mensagem: 'Produto atualizado com sucesso',
      id: id
    });
  });
});

// 6. Deletar Dados (DELETE) - DELETE /produtos/:id
app.delete('/produtos/:id', (req, res) => {
  const { id } = req.params;
  const sqlDelete = 'DELETE FROM produtos WHERE id = ?';
  connection.query(sqlDelete, [id], (err, result) => {
    if (err) {
      return res.status(500).json({ erro: err.message });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ erro: 'Produto não encontrado' });
    }
    res.json({ 
      mensagem: 'Produto deletado com sucesso',
      id: id
    });
  });
});

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});

// Fechar conexão ao encerrar
process.on('SIGINT', () => {
  connection.end();
  console.log('Conexão fechada');
  process.exit();
});
