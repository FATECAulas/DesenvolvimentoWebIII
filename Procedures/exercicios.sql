-- 1.
DELIMITER //

CREATE PROCEDURE AplicarDescontoUltimoPedido(
    IN p_id_cliente INT,
    IN p_percentual_desconto DECIMAL(5, 2)
)
BEGIN
    DECLARE v_id_ultimo_pedido INT;
    DECLARE v_valor_total_pedido DECIMAL(10, 2);
    DECLARE v_valor_desconto DECIMAL(10, 2);

    -- Encontrar o ID do último pedido do cliente
    SELECT id_pedido, valor_total
    INTO v_id_ultimo_pedido, v_valor_total_pedido
    FROM Pedidos
    WHERE id_cliente = p_id_cliente
    ORDER BY data_pedido DESC
    LIMIT 1;

    -- Calcular o valor do desconto
    SET v_valor_desconto = v_valor_total_pedido * (p_percentual_desconto / 100);

    -- Atualizar o pedido com o desconto
    UPDATE Pedidos
    SET valor_desconto = v_valor_desconto,
        valor_total = v_valor_total_pedido - v_valor_desconto
    WHERE id_pedido = v_id_ultimo_pedido;

END //

DELIMITER ;

-- 2.
DELIMITER //

CREATE PROCEDURE AplicarDescontoCondicionalUltimoPedido(
    IN p_id_cliente INT,
    IN p_percentual_desconto DECIMAL(5, 2)
)
BEGIN
    DECLARE v_id_ultimo_pedido INT;
    DECLARE v_valor_total_pedido DECIMAL(10, 2);
    DECLARE v_renda_total_cliente DECIMAL(10, 2);
    DECLARE v_valor_desconto DECIMAL(10, 2);

    -- Obter informações do cliente e do último pedido
    SELECT p.id_pedido, p.valor_total, (c.salario + COALESCE(c.salario_conjuge, 0))
    INTO v_id_ultimo_pedido, v_valor_total_pedido, v_renda_total_cliente
    FROM Pedidos p
    JOIN Clientes c ON p.id_cliente = c.id_cliente
    WHERE p.id_cliente = p_id_cliente
    ORDER BY p.data_pedido DESC
    LIMIT 1;

    -- Verificar a condição do desconto (valor do pedido < 10% da renda total)
    IF v_valor_total_pedido < (v_renda_total_cliente * 0.10) THEN
        -- Calcular o valor do desconto
        SET v_valor_desconto = v_valor_total_pedido * (p_percentual_desconto / 100);

        -- Atualizar o pedido com o desconto
        UPDATE Pedidos
        SET valor_desconto = v_valor_desconto,
            valor_total = v_valor_total_pedido - v_valor_desconto
        WHERE id_pedido = v_id_ultimo_pedido;
    END IF;

END //

DELIMITER ;

-- 3.
DELIMITER //

CREATE PROCEDURE CalcularEGravarValorTotalPedido(
    IN p_id_pedido INT
)
BEGIN
    DECLARE v_novo_valor_total DECIMAL(10, 2);

    -- Calcular o novo valor total do pedido somando os itens
    SELECT SUM(quantidade * preco_unitario)
    INTO v_novo_valor_total
    FROM ItensPedido
    WHERE id_pedido = p_id_pedido;

    -- Atualizar o valor_total na tabela Pedidos
    UPDATE Pedidos
    SET valor_total = v_novo_valor_total
    WHERE id_pedido = p_id_pedido;

END //

DELIMITER ;

-- 4.
DELIMITER //

CREATE PROCEDURE AplicarAumentoSalarialDependentes(
    IN p_valor_aumento DECIMAL(10, 2)
)
BEGIN
    -- Atualizar o salário dos funcionários com menos de 2 dependentes
    UPDATE Funcionarios
    SET salario = salario + p_valor_aumento
    WHERE numero_dependentes < 2;

END //

DELIMITER ;

-- 5.
DELIMITER //

CREATE PROCEDURE AplicarDescontoPedidosNaoPagosSP(
    IN p_percentual_desconto DECIMAL(5, 2)
)
BEGIN
    -- Cursor para iterar sobre os clientes de SP com pedidos não pagos
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id_cliente INT;
    DECLARE v_id_ultimo_pedido INT;
    DECLARE v_valor_total_pedido DECIMAL(10, 2);
    DECLARE v_valor_desconto DECIMAL(10, 2);

    DECLARE cur_clientes CURSOR FOR
        SELECT c.id_cliente
        FROM Clientes c
        WHERE c.estado = 'SP';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_clientes;

    read_loop: LOOP
        FETCH cur_clientes INTO v_id_cliente;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Encontrar o último pedido não pago do cliente
        SELECT id_pedido, valor_total
        INTO v_id_ultimo_pedido, v_valor_total_pedido
        FROM Pedidos
        WHERE id_cliente = v_id_cliente
          AND status_pagamento = 'Nao Pago'
        ORDER BY data_pedido DESC
        LIMIT 1;

        -- Se encontrou um pedido não pago, aplicar o desconto
        IF v_id_ultimo_pedido IS NOT NULL THEN
            SET v_valor_desconto = v_valor_total_pedido * (p_percentual_desconto / 100);

            UPDATE Pedidos
            SET valor_desconto = v_valor_desconto,
                valor_total = v_valor_total_pedido - v_valor_desconto
            WHERE id_pedido = v_id_ultimo_pedido;
        END IF;

        SET v_id_ultimo_pedido = NULL; -- Reset para a próxima iteração

    END LOOP;

    CLOSE cur_clientes;

END //

DELIMITER ;

-- 6.
DELIMITER //

CREATE PROCEDURE AplicarAumentoSalarialPorPontuacao(
    IN p_percentual_aumento DECIMAL(5, 2)
)
BEGIN
    -- Atualizar o salário dos funcionários com pontuação > 8.0 no mês corrente
    UPDATE Funcionarios f
    JOIN Avaliacoes a ON f.id_funcionario = a.id_funcionario
    SET f.salario = f.salario * (1 + (p_percentual_aumento / 100))
    WHERE a.pontuacao > 8.0
      AND a.mes_referencia = DATE_FORMAT(CURDATE(), '%Y-%m-01'); -- Mês corrente

END //

DELIMITER ;

-- 7.
DELIMITER //

CREATE PROCEDURE GerarParcelasPedido(
    IN p_id_pedido INT,
    IN p_quantidade_parcelas INT
)
BEGIN
    DECLARE v_valor_total_pedido DECIMAL(10, 2);
    DECLARE v_valor_parcela DECIMAL(10, 2);
    DECLARE i INT DEFAULT 1;

    -- Obter o valor total do pedido
    SELECT valor_total INTO v_valor_total_pedido
    FROM Pedidos
    WHERE id_pedido = p_id_pedido;

    -- Validações iniciais
    IF p_quantidade_parcelas = 1 THEN
        SELECT 'Pedido à vista' AS Mensagem; -- Retorna mensagem
    ELSEIF p_quantidade_parcelas > 10 THEN
        SELECT 'Quantidade de parcelas inválida' AS Mensagem; -- Retorna mensagem
    ELSE
        -- Se a quantidade de parcelas ultrapassar 3, acrescentar 10% ao valor total
        IF p_quantidade_parcelas > 3 THEN
            SET v_valor_total_pedido = v_valor_total_pedido * 1.10;
        END IF;

        -- Calcular o valor de cada parcela
        SET v_valor_parcela = v_valor_total_pedido / p_quantidade_parcelas;

        -- Inserir as parcelas na tabela Parcelas
        WHILE i <= p_quantidade_parcelas DO
            INSERT INTO Parcelas (id_pedido, numero_parcela, valor_parcela, data_vencimento, status_pagamento)
            VALUES (p_id_pedido, i, v_valor_parcela, DATE_ADD(CURDATE(), INTERVAL i MONTH), 'Pendente');
            SET i = i + 1;
        END WHILE;

        SELECT 'Parcelas geradas com sucesso' AS Mensagem;
    END IF;

END //

DELIMITER ;