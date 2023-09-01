++ INSERTS

-- inserção de dados
use oficinadb;
show tables;

-- Inserção de dados na tabela PESSOA
INSERT INTO PESSOA (NOME, SOBRENOME, E-MAIL, TIPO, FORNECEDOR, CLIENTE, VENDEDOR_TERCEIRO, COLABORADOR, TRANSPORTADORA)
VALUES
  ('João', 'Silva', 'joao@example.com', 'F', 0, 1, 0, 0, 0),
  ('Maria', 'Santos', 'maria@example.com', 'F', 1, 1, 1, 1, 0),
  ('Carlos', 'Ferreira', 'carlos@example.com', 'J', 1, 0, 0, 0, 1);

-- Inserção de dados na tabela PESSOA_FISICA
INSERT INTO PESSOA_FISICA (ID_PESSOA, CPF, DATA_NASCIMENTO)
VALUES
  (1, '12345678901', '1990-05-15'),
  (2, '98765432101', '1985-10-20');

-- Inserção de dados na tabela PESSOA_JURIDICA
INSERT INTO PESSOA_JURIDICA (ID_PESSOA, NOME_FANTASIA, RAZAO_SOCIAL, CNPJ, DATA_CONSTITUICAO, DATA_CADASTRO)
VALUES
  (3, 'Transportes Rápidos', 'Transportes Rápidos Ltda.', '12345678901234', '2000-01-10', '2023-02-15');

-- Inserção de dados na tabela PESSOA_ENDERECO
INSERT INTO PESSOA_ENDERECO (ID_PESSOA, LOGRADOURO, NUMERO, COMPLEMENTO, BAIRRO, CEP, CIDADE, UF, PAIS, ENTREGA)
VALUES
  (1, 'Rua A', '123', 'Apto 45', 'Centro', '12345-678', 'Cidade A', 'SP', 'Brasil', 'S'),
  (2, 'Av. B', '456', NULL, 'Vila Nova', '54321-876', 'Cidade B', 'RJ', 'Brasil', 'N');

-- Inserção de dados na tabela PESSOA_TELEFONE
INSERT INTO PESSOA_TELEFONE (ID_PESSOA, TIPO, DDD_NUMERO)
VALUES
  (1, 'C', '11 1234-5678'),
  (2, 'R', '21 9876-5432');

-- Inserção de dados na tabela FORNECEDOR
INSERT INTO FORNECEDOR (ID_PESSOA, DATA_CADASTRO, OBSERVACAO)
VALUES
  (1, '2023-01-10', 'Bom fornecedor de peças'),
  (3, '2023-02-15', 'Fornece serviços de transporte');

-- Inserção de dados na tabela COLABORADOR
INSERT INTO COLABORADOR (ID_PESSOA, ID_DEPARTAMENTO, ID_CARGO, DATA_ADMISSAO, CTPS, OBSERVACAO)
VALUES
  (2, 1, 1, '2022-05-20', '123456', 'Ótimo vendedor'),
  (3, 2, 2, '2023-03-01', '789012', 'Mecânico experiente');

-- Inserção de dados na tabela VENDEDOR
INSERT INTO VENDEDOR (ID_COLABORADOR, OBSERVACAO)
VALUES
  (1, 'Especialista em vendas de peças');

-- Inserção de dados na tabela CLIENTE
INSERT INTO CLIENTE (ID_PESSOA, DATA_CADASTRO, OBSERVACAO)
VALUES
  (2, '2021-08-05', 'Cliente fiel da loja'),
  (3, '2022-10-12', 'Cliente em busca de serviços de manutenção');

-- Inserção de dados na tabela MECANICO
INSERT INTO MECANICO (ID_COLABORADOR, OBSERVACAO)
VALUES
  (2, 'Realiza diversos tipos de reparos');

-- Inserção de dados na tabela ST_PAGAMENTO
INSERT INTO ST_PAGAMENTO (SITUACAO)
VALUES
  ('Pendente'),
  ('Concluído');

-- Inserção de dados na tabela PAGAMENTO
INSERT INTO PAGAMENTO (ID_PEDIDO, ST_PAGAMENTO_ID)
VALUES
  (1, 1),
  (1, 2),
  (2, 1);

-- Inserção de dados na tabela TIPO_PAGAMENTO
INSERT INTO TIPO_PAGAMENTO (ID_PAGAMENTO, BOLETO, PIX, DEBITO, CREDITO, DINHEIRO)
VALUES
  (1, 1, 0, 1, 1, 0),
  (2, 0, 1, 0, 1, 0);

-- Inserção de dados na tabela CARTAO
INSERT INTO CARTAO (TIPO, TIPO_PAG_ID)
VALUES
  ('C', 1),
  ('D', 2);

-- Inserção de dados na tabela DEBITO
INSERT INTO DEBITO (CARTAO_ID)
VALUES
  (1),
  (2);

-- Inserção de dados na tabela CREDITO
INSERT INTO CREDITO (ID_CREDITO, VALOR, NUMERO)
VALUES
  (1, '200.00', '1234-5678-9012'),
  (2, '500.00', '9876-5432-1098');

-- Inserção de dados na tabela BOLETO
INSERT INTO BOLETO (TIPO_PAG_ID, VALOR, DATA_EMISSAO, DATA_VENCIMENTO, NUMERO)
VALUES
  (1, '150.00', '2023-08-01', '2023-08-15', '123456789'),
  (2, '300.00', '2023-08-05', '2023-08-20', '987654321');

-- Inserção de dados na tabela PIX
INSERT INTO PIX (TIPO_PAG_ID, CHAVE, VALOR)
VALUES
  (2, 'chave.pix@example.com', '120.00');

-- Inserção de dados na tabela DINHEIRO
INSERT INTO DINHEIRO (ID_ST_PAGAMENTO, VALOR)
VALUES
  (2, '100.00'),
  (1, '50.00');

-- Inserção de dados na tabela ESTOQUE
INSERT INTO ESTOQUE (ID, LOCAL)
VALUES
  (1, 'Depósito A'),
  (2, 'Depósito B');

-- Inserção de dados na tabela ST_ORÇAMENTO
INSERT INTO ST_ORÇAMENTO (NOME)
VALUES
  ('Em andamento'),
  ('Aprovado'),
  ('Recusado');

-- Inserção de dados na tabela CARGO
INSERT INTO CARGO (ID, NOME)
VALUES
  (1, 'Gerente'),
  (2, 'Vendedor'),
  (3, 'Mecânico');

-- Inserção de dados na tabela DEPARTAMENTO
INSERT INTO DEPARTAMENTO (ID, NOME)
VALUES
  (1, 'Vendas'),
  (2, 'Oficina');

-- Inserção de dados na tabela VEICULO
INSERT INTO VEICULO (ID_CLIENTE, PLACA, MARCA, MODELO, COR, KM, VEICULOcol)
VALUES
  (1, 'XYZ-1234', 'Toyota', 'Corolla', 'Prata', 50000, 'Carro Sedan'),
  (2, 'ABC-5678', 'BMW', 'X5', 'Preto', 20000, 'SUV');

-- Inserção de dados na tabela ORÇAMENTO
INSERT INTO ORÇAMENTO (VENDEDOR_ID, VEICULO_ID, ST_ORÇAMENTO_ID, ID_MECANICO, OBSERVACAO, TOTAL)
VALUES
  (1, 1, 1, 2, 'Troca de óleo e filtros', 250.00),
  (2, 2, 2, 3, 'Reparo na suspensão', 800.00);

-- Inserção de dados na tabela PEÇAS_POR_VENDEDOR
INSERT INTO PEÇAS_POR_VENDEDOR (ID_VENDEDOR, ID_PRODUTO, PRODUTO_VENDEDOR, QUANTIDADE)
VALUES
  (1, 1, 'Óleo do Motor', 10),
  (2, 2, 'Amortecedor Dianteiro', 5);

-- Inserção de dados na tabela PEÇA_POR_ESTOQUE
INSERT INTO PEÇA_POR_ESTOQUE (ID_ESTOQUE, ID_PRODUTO)
VALUES
  (1, 1),
  (2, 2);

-- Inserção de dados na tabela PEÇA_POR_FORNECEDOR
INSERT INTO PEÇA_POR_FORNECEDOR (ID_PEÇA, ID_FORNECEDOR, QUANTIDADE)
VALUES
  (1, 1, 100),
  (2, 2, 50);

-- Inserção de dados na tabela PEÇA_POR_ORÇAMENTO
INSERT INTO PEÇA_POR_ORÇAMENTO (ID_PEÇA, ID_ORÇAMENTO, QUANTIDADE)
VALUES
  (1, 1, 2),
  (2, 1, 1);


++ QUERIES

-- Recuperações simples com SELECT Statement
SELECT * FROM PRODUTO;
SELECT * FROM PESSOA;
SELECT * FROM ORÇAMENTO;

-- Recuperações Filtros com WHERE Statement
SELECT * FROM PRODUTO WHERE PRECO > 100;
SELECT * FROM PESSOA WHERE TIPO = 'F';
SELECT * FROM ORÇAMENTO WHERE TOTAL > 500;

-- Recuperações para gerar atributos derivados
SELECT c.ID, p.NOME AS CLIENTE, CASE WHEN pg.ID IS NOT NULL THEN 'Pago' ELSE 'Não Pago' END AS STATUS_PAGAMENTO
FROM CLIENTE c
JOIN PESSOA p ON c.ID_PESSOA = p.ID
LEFT JOIN PAGAMENTO pg ON c.ID = pg.ID_CLIENTE;

-- Recuperações dos dados com ORDER BY
SELECT * FROM PEÇA ORDER BY PRECO DESC;
SELECT * FROM PESSOA ORDER BY NOME;

-- Recuperações dos dados com HAVING Statement
SELECT d.NOME AS DEPARTAMENTO, COUNT(c.ID) AS NUM_COLABORADORES
FROM DEPARTAMENTO d
JOIN COLABORADOR c ON d.ID = c.ID_DEPARTAMENTO
GROUP BY d.ID
HAVING NUM_COLABORADORES > 3;

-- Recuperações dos dados com junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
SELECT p.ID, c.NOME AS CLIENTE, o.DATA, o.TOTAL
FROM PEDIDO p
JOIN CLIENTE c ON p.ID_CLIENTE = c.ID
JOIN PAGAMENTO pg ON p.ID = pg.ID_PEDIDO
JOIN TIPO_PAGAMENTO tp ON pg.ID_TIPO_PAGAMENTO = tp.ID
WHERE tp.DINHEIRO = 1;

-- Recuperar todos os clientes
SELECT c.ID, p.NOME AS CLIENTE
FROM CLIENTE c
JOIN PESSOA p ON c.ID_PESSOA = p.ID;

-- Recuperar todas as peças disponíveis
SELECT ID, DESCRICAO, PRECO
FROM PEÇA;

-- Recuperar todos os vendedores e seus colaboradores associados
SELECT v.ID AS VENDEDOR_ID, p.NOME AS VENDEDOR, c.NOME AS COLABORADOR
FROM VENDEDOR v
JOIN COLABORADOR c ON v.ID_COLABORADOR = c.ID
JOIN PESSOA p ON c.ID_PESSOA = p.ID;

-- Recuperar os departamentos e seus colaboradores
SELECT d.NOME AS DEPARTAMENTO, c.NOME AS COLABORADOR
FROM DEPARTAMENTO d
JOIN COLABORADOR c ON d.ID = c.ID_DEPARTAMENTO;

-- Recuperar todos os fornecedores e suas peças fornecidas
SELECT f.ID AS FORNECEDOR_ID, p.NOME AS FORNECEDOR, ppf.QUANTIDADE, pe.DESCRICAO AS PEÇA
FROM FORNECEDOR f
JOIN PESSOA p ON f.ID_PESSOA = p.ID
JOIN PEÇA_POR_FORNECEDOR ppf ON f.ID = ppf.ID_FORNECEDOR
JOIN PEÇA pe ON ppf.ID_PEÇA = pe.ID;

-- Recuperar as informações de endereço de uma pessoa
SELECT p.NOME, pe.LOGRADOURO, pe.NUMERO, pe.COMPLEMENTO, pe.BAIRRO, pe.CIDADE, pe.UF, pe.PAIS
FROM PESSOA p
JOIN PESSOA_ENDERECO pe ON p.ID = pe.ID_PESSOA;

-- Recuperar os números de telefone de uma pessoa
SELECT p.NOME, pt.TIPO, pt.DDD_NUMERO
FROM PESSOA p
JOIN PESSOA_TELEFONE pt ON p.ID = pt.ID_PESSOA;

-- Recuperar todos os produtos de um fornecedor específico
SELECT F.NOME AS FORNECEDOR, P.DESCRICAO AS PRODUTO
FROM FORNECEDOR F
JOIN PEÇA_POR_FORNECEDOR PPF ON F.ID = PPF.ID_FORNECEDOR
JOIN PEÇA P ON PPF.ID_PEÇA = P.ID
WHERE F.ID = 1;

-- Recuperar todos os clientes que fizeram orçamentos
SELECT C.NOME, C.SOBRENOME
FROM CLIENTE C
JOIN VEICULO V ON C.ID = V.ID_CLIENTE
JOIN ORÇAMENTO O ON V.ID = O.VEICULO_ID;

-- Recuperar todas as peças de um orçamento específico
SELECT O.ID AS ORÇAMENTO, P.DESCRICAO AS PEÇA, PPO.QUANTIDADE
FROM ORÇAMENTO O
JOIN PEÇA_POR_ORÇAMENTO PPO ON O.ID = PPO.ID_ORÇAMENTO
JOIN PEÇA P ON PPO.ID_PEÇA = P.ID
WHERE O.ID = 1;

-- Recuperar as formas de pagamento de um pedido específico
SELECT O.ID AS ORÇAMENTO, TP.BOLETO, TP.PIX, TP.DEBITO, TP.CREDITO, TP.DINHEIRO
FROM ORÇAMENTO O
JOIN PAGAMENTO P ON O.ID = P.ID_PEDIDO
JOIN TIPO_PAGAMENTO TP ON P.ST_PAGAMENTO_ID = TP.ID_PAGAMENTO
WHERE O.ID = 3;

-- Recuperar todas as pessoas jurídicas com seus respectivos contatos
SELECT PJ.NOME_FANTASIA, PJ.CNPJ, PE.TIPO, PE.DDD_NUMERO AS TELEFONE
FROM PESSOA_JURIDICA PJ
JOIN PESSOA P ON PJ.ID_PESSOA = P.ID
JOIN PESSOA_TELEFONE PE ON P.ID = PE.ID_PESSOA;

-- Recuperar o total pago em um orçamento através das formas de pagamento
SELECT O.ID AS ORÇAMENTO, SUM(C.VALOR) AS TOTAL_PAGO
FROM ORÇAMENTO O
JOIN PAGAMENTO P ON O.ID = P.ID_PEDIDO
JOIN TIPO_PAGAMENTO TP ON P.ST_PAGAMENTO_ID = TP.ID_PAGAMENTO
LEFT JOIN CARTAO C ON TP.ID_PAGAMENTO = C.TIPO_PAG_ID
LEFT JOIN DEBITO D ON C.ID = D.CARTAO_ID
LEFT JOIN CREDITO CR ON C.ID = CR.ID_CREDITO
LEFT JOIN BOLETO B ON TP.ID_PAGAMENTO = B.TIPO_PAG_ID
LEFT JOIN PIX PIX ON TP.ID_PAGAMENTO = PIX.TIPO_PAG_ID
LEFT JOIN DINHEIRO DN ON TP.ID_PAGAMENTO = DN.ID_ST_PAGAMENTO
WHERE O.ID = 3;
