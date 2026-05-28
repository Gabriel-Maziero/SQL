USE master;
GO

IF DB_ID('petshop') IS NULL
BEGIN
    CREATE DATABASE petshop;
END
GO

USE petshop;
GO

DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS cachorros;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS servicos;
GO

-- TABELA USUARIO
CREATE TABLE usuario(
id              INT IDENTITY(1,1)     NOT NULL PRIMARY KEY,
id_cachorro     INT                   NOT NULL,
nome            NVARCHAR(100)         NOT NULL, 
email           NVARCHAR(50)          NOT NULL,
cadastro        DATETIME2             NOT NULL DEFAULT GETDATE(),
);

-- TABELA CACHORROS
CREATE TABLE cachorros(
id             INT                IDENTITY(1,1)  NOT NULL PRIMARY KEY,
id_usuario     INT                NOT NULL,
nome           NVARCHAR(20)       NOT NULL,
raca           NVARCHAR(30)       NOT NULL,
cadastro       DATETIME2          NOT NULL DEFAULT GETDATE(),

CONSTRAINT FK_cachorros_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES cachorros(id)
);

-- TABELA PRODUTOS
CREATE TABLE produtos(
id                INT              IDENTITY(1,1) NOT NULL PRIMARY KEY,
id_remedio        INT              NULL,
id_alimentos      INT              NULL,
id_utilitarios    INT              NULL,
--num_pedidos       INT              NULL,
--num_entregas      INT              NULL,
id_produto        INT              NOT NULL,
estoque           INT              NOT NULL,
cadastro          DATETIME2        NOT NULL DEFAULT GETDATE(),

CONSTRAINT FK_estoque_remedio
        FOREIGN KEY (id_remedio)
        REFERENCES produtos(id),

CONSTRAINT FK_estoque_alimentos
        FOREIGN KEY (id_alimentos)
        REFERENCES produtos(id),

CONSTRAINT FK_usuario_utilitarios
        FOREIGN KEY (id_utilitarios)
        REFERENCES produtos(id),

 CONSTRAINT CHK_estoque_produto
        CHECK (
           estoque >= 0
        ),
);

-- TABELA SERVICOS
CREATE TABLE servicos(
id              INT              IDENTITY(1,1) NOT NULL PRIMARY KEY,
id_cachorro     NVARCHAR(20)     NOT NULL,
banho           NVARCHAR(20)     NOT NULL,
tosa            NVARCHAR(20)     NOT NULL,
consulta        NVARCHAR(20)     NOT NULL,
);

-- INSERTS USUARIO
INSERT INTO usuario (id_cachorro, nome, email)
VALUES 
('1', 'Carlos Silva', 'carlos@gmail.com'),
('2', 'Mariana Souza', 'mariana@hotmail.com'),
('3', 'Joao Pereira', 'joao@yahoo.com');

-- INSERTS CACHORROS
INSERT INTO cachorros (id_usuario, nome, raca)
VALUES
('1', 'Rex', 'Labrador'),
('2', 'Mel', 'Poodle'),
('3', 'Thor', 'Bulldog');

-- INSERTS PRODUTOS
INSERT INTO produtos 
(id_produto, id_remedio, id_alimentos, id_utilitarios, estoque)
VALUES
(1, 'Vermifugo', 'Racao Premium', 'Coleira', 0, 0, 10),
(2, 'Antipulgas', 'Biscoito Canino', 'Brinquedo', 0, 0, 0),
(3, 'Vitamina', 'Racao Filhote', 'Caminha', 0, 0, 5);

-- INSERTS SERVICOS
INSERT INTO servicos (id_cachorro, banho, tosa, consulta)
VALUES
('1', 'Sim', 'Nao', 'Sim'),
('2', 'Sim', 'Sim', 'Nao'),
('3', 'Nao', 'Sim', 'Sim');

-- Mostrar cachorro baseado no dono
SELECT nome FROM cachorros WHERE id_usuario IN (1, 2, 3);

-- Mostrar raça baseada no nome do cachorro
SELECT raca FROM cachorros WHERE nome IN ('Rex', 'Mel', 'Thor');

-- Mostrar banho e tosa
SELECT banho, tosa FROM servicos WHERE id_cachorro IN (1, 2, 3);

--Produtos
SELECT * FROM produtos;

-- Aumentar pedidos de produtos entregues
--UPDATE produtos
--SET num_pedidos = num_pedidos + 1
--WHERE id_produto = 1;

--UPDATE produtos
--SET num_pedidos = num_pedidos + 1
--WHERE id_produto = 2;

--UPDATE produtos
--SET num_pedidos = num_pedidos + 1
--WHERE id_produto = 3;

--SELECT * FROM produtos;

-- Aumento de entregas
--UPDATE produtos
--SET num_entregas = num_entregas + 1
--WHERE id_produto = 1;

--UPDATE produtos
--SET num_entregas = num_entregas + 1
--WHERE id_produto = 2;

--UPDATE produtos
--SET num_entregas = num_entregas + 1
--WHERE id_produto = 3;

--Vendas
UPDATE produtos
SET estoque = estoque - 1
WHERE id_produto = 1;

UPDATE produtos
SET estoque = estoque - 1
WHERE id_produto = 2;

UPDATE produtos
SET estoque = estoque - 1
WHERE id_produto = 3;

SELECT * FROM produtos;

-- Deletar produtos sem estoque
SELECT estoque FROM produtos;
DELETE FROM produtos
WHERE estoque <= 0 ;
