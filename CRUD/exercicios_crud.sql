-- 1. Crie uma base chamada estacionamento.
CREATE DATABASE IF NOT EXISTS estacionamento;
USE estacionamento;

-- 2. Crie uma tabela chamada Carros com os seguintes campos:
-- codigo_modelo (int, PK), nome_modelo (char), codigo_marca (char), endereco_cliente (char) e valor_aluguel (float).
CREATE TABLE Carros (
    codigo_modelo INT PRIMARY KEY,
    nome_modelo CHAR(100),
    codigo_marca CHAR(100),
    endereco_cliente CHAR(255),
    valor_aluguel FLOAT
);

-- 3. Renomeie a tabela Carros para veículo.
RENAME TABLE Carros TO veículo;

-- 4. Alterar o campo codigo_marca para o tipo inteiro.
ALTER TABLE veículo MODIFY COLUMN codigo_marca INT;

-- 5. Adicionar o campo nome_marca do tipo char.
ALTER TABLE veículo ADD COLUMN nome_marca CHAR(100);

-- 6. Remover o campo endereço_cliente.
ALTER TABLE veículo DROP COLUMN endereco_cliente;

Insert into veículo (codigo_modelo, nome_modelo, cod_marca, valor_aluguel,nome_marca)
values (1, 'Peugeot 206', 29, 40.50, 'Peugeot'),
(2, 'Fusca', 22, 20.75, 'Fabricante X'),
(3, 'Ferrari', 18, 350.0, 'Ferrari'),
(4, 'Camaro', 13, 330.0, 'Camaro'),
(5, 'Gol', 16, 75.50, 'Volkswagen'),
(6, 'Celta', 15, 39.90, 'Fiat'),
(7, 'Uno', 14, 49.90, 'Fiat'),
(8, 'Palio', 13, 85.50, 'Fiat'),
(9, 'Nissan March', 12, 90.30, 'Nissan'),
(10, 'Jipe', 10, 69.99, 'Fabricante Z');

-- 7. Atualize o valor do aluguel para R$99,99 para todos os carros da marca Fiat.
-- (Assumindo que o campo nome_marca contém 'Fiat')
UPDATE veículo SET valor_aluguel = 99.99 WHERE nome_marca = 'Fiat';

-- 8. Atualize o nome do modelo para Molina, o codigo_marca para 20 e o valor_aluguel para R$179,90 no carro que apresenta o código do modelo 6.
UPDATE veículo 
SET nome_modelo = 'Molina', 
    codigo_marca = 20, 
    valor_aluguel = 179.90 
WHERE codigo_modelo = 6;

-- 9. Exclua da tabela todos os veículos que apresentarem o campo codigo_marca maior igual a 22.
DELETE FROM veículo WHERE codigo_marca >= 22;

-- 10. Exclua da tabela o veículo que possui o código do modelo = 10.
DELETE FROM veículo WHERE codigo_modelo = 10;

-- 11. Exclua da tabela todos os veículos que apresentam o valor de aluguel entre R$90,30 e 99,99.
DELETE FROM veículo WHERE valor_aluguel BETWEEN 90.30 AND 99.99;
