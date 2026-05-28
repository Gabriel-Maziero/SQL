USE master;
GO

IF DB_ID('rpg_game') IS NULL
BEGIN
    CREATE DATABASE rpg_game;
END
GO

USE rpg_game;
GO

DROP TABLE IF EXISTS personagem_items;
DROP TABLE IF EXISTS personagem_magias;
DROP TABLE IF EXISTS personagens;
DROP TABLE IF EXISTS accont;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS guildas;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS magias;
GO

CREATE TABLE accont (
    id            INT            IDENTITY(1,1) NOT NULL,
    login         NVARCHAR(50)   NOT NULL,
    email         NVARCHAR(120)  NOT NULL,
    senha_hash    NVARCHAR(255)  NOT NULL,
    data_criacao  DATETIME2      NOT NULL,
    ativo         BIT            NOT NULL
);

CREATE TABLE classes (
    id          INT            IDENTITY(1,1) NOT NULL,
    nome        NVARCHAR(50)   NOT NULL,
    descricao   NVARCHAR(200)  NULL
);

CREATE TABLE guildas (
    id              INT            IDENTITY(1,1) NOT NULL,
    nome            NVARCHAR(80)   NOT NULL,
    descricao       NVARCHAR(300)  NULL,
    data_fundacao   DATE           NOT NULL,
    lider_id        INT            NULL
);

CREATE TABLE personagens (
    id            INT            IDENTITY(1,1) NOT NULL,
    conta_id      INT            NOT NULL,
    classe_id     INT            NOT NULL,
    guilda_id     INT            NULL,
    nome          NVARCHAR(60)   NOT NULL,
    nivel         SMALLINT       NOT NULL,
    vida_max      INT            NOT NULL,
    mana_max      INT            NOT NULL,
    experiencia   BIGINT         NOT NULL,
    data_criacao  DATETIME2      NOT NULL
);

CREATE TABLE items (
    id        INT            IDENTITY(1,1) NOT NULL,
    nome      NVARCHAR(80)   NOT NULL,
    tipo      NVARCHAR(30)   NOT NULL,
    raridade  NVARCHAR(20)   NOT NULL,
    valor     DECIMAL(10,2)  NOT NULL
);

CREATE TABLE magias (
    id          INT            IDENTITY(1,1) NOT NULL,
    nome        NVARCHAR(80)   NOT NULL,
    custo_mana  SMALLINT       NOT NULL,
    dano        INT            NULL,
    tipo        NVARCHAR(30)   NOT NULL
);

CREATE TABLE personagem_items (
    personagem_id INT NOT NULL,
    item_id       INT NOT NULL,
    quantidade    INT NOT NULL
);

CREATE TABLE personagem_magias (
    personagem_id     INT NOT NULL,
    magia_id          INT NOT NULL,
    data_aprendizado  DATETIME2 NOT NULL
);

INSERT INTO accont (login, email, senha_hash, data_criacao, ativo) VALUES
    ('arthas', 'arthas@rpg.com', 'hash1', GETDATE(), 1),
    ('jaina',  'jaina@rpg.com',  'hash2', GETDATE(), 1),
    ('thrall', 'thrall@rpg.com', 'hash3', GETDATE(), 0);

INSERT INTO classes (nome, descricao) VALUES
    ('Guerreiro',  'Força física, vida alta'),
    ('Mago',       'Mana alta, magias poderosas'),
    ('Arqueiro',   'Ágil, ataque à distância'),
    ('Curandeiro', 'Suporte, magias de cura');

INSERT INTO guildas (nome, descricao, data_fundacao, lider_id) VALUES
    ('Aliança dos Heróis', 'Guilda dos defensores de Azeroth', '2018-05-12', NULL),
    ('Horda Sombria',      'Para os verdadeiros guerreiros da Horda', '2019-02-03', NULL);

INSERT INTO personagens (conta_id, classe_id, guilda_id, nome, nivel, vida_max, mana_max, experiencia, data_criacao) VALUES
    (1, 1, 1, 'Arthas Menethil',   60, 8500,  1200, 2450000, GETDATE()),
    (1, 2, 1, 'Jaina Proudmoore',  55, 4200,  9800, 1890000, GETDATE()),
    (2, 2, 1, 'Kael''thas Sunstrider', 58, 3900, 12500, 2100000, GETDATE()),
    (2, 3, 2, 'Sylvanas Windrunner',   62, 6100,  2400, 2780000, GETDATE()),
    (3, 1, 2, 'Thrall',                65, 9200,  1800, 3120000, GETDATE()),
    (3, 4, NULL, 'Uther Lightbringer', 50, 7800,  6500, 1450000, GETDATE()),
    (1, 1, 1, 'Grom Hellscream',    58, 8100,  1100, 1980000, GETDATE()),
    (1, 3, 2, 'Rexxar',             54, 7200,  2100, 1670000, GETDATE()),
    (2, 1, 1, 'Varok Saurfang',     61, 8700,  1300, 2310000, GETDATE()),
    (2, 2, 1, 'Medivh',             59, 4500, 11200, 2050000, GETDATE()),
    (2, 4, NULL, 'Anduin Wrynn',    48, 5900,  7800, 1320000, GETDATE()),
    (3, 3, 2, 'Vol''jin',           57, 6800,  2900, 1840000, GETDATE()),
    (3, 2, 2, 'Gul''dan',           63, 5100, 13400, 2670000, GETDATE()),
    (1, 4, 1, 'Tyrande Whisperwind', 52, 6100,  8500, 1540000, GETDATE()),
    (2, 1, 2, 'Garrosh Hellscream', 55, 7900,  1400, 1720000, GETDATE());

INSERT INTO items (nome, tipo, raridade, valor) VALUES
    ('Espada Longa de Prata',     'Arma',       'Comum',    120.00),
    ('Cajado Arcano do Aprendiz', 'Arma',       'Raro',     890.50),
    ('Arco Élfico Ancestral',     'Arma',       'Épico',   2450.00),
    ('Poção de Vida Maior',       'Consumível', 'Comum',     45.00),
    ('Anel do Mago Supremo',      'Acessório',  'Épico',   3200.00),
    ('Armadura de Placas Rúnica', 'Armadura',   'Raro',    1450.75),
    ('Pergaminho de Teleporte',   'Consumível', 'Incomum',  180.00),
    ('Adaga Sombria das Sombras', 'Arma',       'Raro',     620.00),
    ('Capa do Vento Noturno',     'Armadura',   'Épico',   1890.00),
    ('Elixir de Mana',            'Consumível', 'Incomum',   95.00),
    ('Machado de Guerra',         'Arma',       'Comum',    210.00),
    ('Botas de Velocidade',       'Armadura',   'Raro',     780.00),
    ('Coroa do Rei',              'Acessório',  'Épico',   4100.00),
    ('Poção de Mana',             'Consumível', 'Comum',     38.00),
    ('Escudo de Aço',             'Armadura',   'Incomum',  540.00),
    ('Varinha de Fogo',           'Arma',       'Raro',     670.00),
    ('Amuleto da Vida',           'Acessório',  'Épico',   2890.00);

INSERT INTO magias (nome, custo_mana, dano, tipo) VALUES
    ('Bola de Fogo',     45, 280,  'Dano'),
    ('Cura Rápida',      30, NULL, 'Cura'),
    ('Raio Arcano',      60, 410,  'Dano'),
    ('Escudo de Gelo',   25, NULL, 'Defesa'),
    ('Mísseis Mágicos',  20, 95,   'Dano'),
    ('Ressurreição',    150, NULL, 'Cura'),
    ('Tempestade de Gelo', 75,  520, 'Dano');

INSERT INTO personagem_items (personagem_id, item_id, quantidade) VALUES
    (1, 1, 1), (1, 4, 5), (1, 6, 1),
    (2, 2, 1), (2, 5, 1), (2, 9, 1),
    (3, 2, 1), (3, 7, 3),
    (4, 3, 1), (4, 8, 1),
    (5, 1, 1), (5, 3, 1), (5, 6, 2);

INSERT INTO personagem_magias (personagem_id, magia_id, data_aprendizado) VALUES
    (2, 1, GETDATE()), (2, 3, GETDATE()), (2, 5, GETDATE()),
    (3, 1, GETDATE()), (3, 2, GETDATE()), (3, 6, GETDATE()),
    (4, 4, GETDATE()), (4, 7, GETDATE()),
    (5, 4, GETDATE()), (5, 5, GETDATE()), (6, 2, GETDATE());

INSERT INTO accont (login, email, senha_hash, data_criacao, ativo)
VALUES ('exemplo_curto', 'curto@rpg.com', 'hash_curto', GETDATE(), 1);

INSERT INTO classes (nome, descricao)
VALUES
  ('Guerreiro', 'Força física'),
  ('Mago', 'Mana e magia'),
  ('Arqueiro', 'Ágil, à distância');

SELECT * FROM accont;

SELECT login, email FROM accont;

SELECT login AS usuario, email AS contato FROM accont;

SELECT nome, nivel FROM personagens WHERE nivel = 10;

SELECT * FROM personagens WHERE nivel >= 50;

SELECT * FROM personagens WHERE classe_id != 2;

SELECT * FROM personagens WHERE nivel >= 50 AND classe_id = 1;

SELECT * FROM personagens WHERE nivel BETWEEN 10 AND 20;

SELECT * FROM items WHERE raridade IN ('Raro', 'Épico');

SELECT * FROM personagens WHERE nome LIKE '%dragon%';

SELECT * FROM accont WHERE data_criacao IS NULL;

--Up de persongens
UPDATE personagens
SET nivel = nivel + 1,
    vida_max = vida_max + 5,
    mana_max = mana_max + 3,
    experiencia = 0
WHERE nome = 'Arthas Menethil';

UPDATE personagens
SET vida_max = vida_max + 10
WHERE classe_id = 1;

UPDATE accont
SET ativo = 0
WHERE login = 'thrall';

SELECT id, nome, nivel FROM personagens WHERE nome = 'Uther Lightbringer';
DELETE FROM personagens WHERE nome = 'Uther Lightbringer';
SELECT id, nome, nivel FROM personagens WHERE nome = 'Uther Lightbringer';

SELECT COUNT(*) AS qtd_itens_personagem1_antes FROM personagem_items WHERE personagem_id = 1;
DELETE FROM personagem_items WHERE personagem_id = 1;
SELECT COUNT(*) AS qtd_itens_personagem1_depois FROM personagem_items WHERE personagem_id = 1;

--mudança na guilda/saida

--ALTER TABLE personagens ADD guilda_id INT NULL;
--ALTER TABLE personagens DROP COLUMN guilda_id;

--exclusao de coluna de personagem sem nome
--ALTER TABLE personagens ALTER COLUMN nome NVARCHAR(100) NOT NULL;

--Add nova conta
INSERT INTO accont (login, email, senha_hash, data_criacao, ativo)
VALUES ('para_scope', 'scope@rpg.com', 'hash_scope', GETDATE(), 1);
SELECT SCOPE_IDENTITY() AS id_gerado;

DROP TABLE IF EXISTS personagem_magias;

SELECT TOP 10 nome, nivel, experiencia
FROM personagens
ORDER BY nivel DESC, experiencia DESC;

SELECT 
  classe_id,
  COUNT(*) AS total_personagens,
  AVG(nivel) AS nivel_medio,
  MAX(nivel) AS nivel_maximo
FROM personagens
GROUP BY classe_id
ORDER BY total_personagens DESC;

SELECT classe_id, COUNT(*) AS total
FROM personagens
WHERE nivel >= 50
GROUP BY classe_id
HAVING COUNT(*) >= 3;

SELECT 
  raridade,
  COUNT(*) AS quantidade,
  SUM(valor) AS valor_total,
  AVG(valor) AS valor_medio,
  MAX(valor) AS valor_maior
FROM items
GROUP BY raridade
ORDER BY valor_total DESC;

SELECT tipo, AVG(valor) AS valor_medio
FROM items
GROUP BY tipo
HAVING AVG(valor) > 400
ORDER BY valor_medio DESC;

SELECT TOP 5 nome, classe_id, nivel
FROM personagens
ORDER BY experiencia DESC;

SELECT classe_id, COUNT(*) AS qtd_personagens, AVG(nivel) AS nivel_medio
FROM personagens
GROUP BY classe_id;

SELECT raridade, COUNT(*) AS quantidade
FROM items
GROUP BY raridade
ORDER BY quantidade DESC;

SELECT classe_id, COUNT(*) AS total
FROM personagens
WHERE nivel >= 50
GROUP BY classe_id
HAVING COUNT(*) > 1;

SELECT TOP 1 nome, custo_mana FROM magias ORDER BY custo_mana DESC;
SELECT TOP 1 nome, custo_mana FROM magias ORDER BY custo_mana ASC;

GO

--Os 5 personagens com maior experiência, mostrando nome, classe e nível
SELECT TOP 5
    p.nome AS personagem,
    c.nome AS classe,
    p.nivel,
    p.experiencia
FROM personagens p
INNER JOIN classes c
    ON p.classe_id = c.id
ORDER BY p.experiencia DESC;


--Para cada classe: quantos personagens existem e o nível médio
SELECT
    c.nome AS classe,
    COUNT(p.id) AS total_personagens,
    AVG(p.nivel * 1.0) AS nivel_medio
FROM classes c
LEFT JOIN personagens p
    ON p.classe_id = c.id
GROUP BY c.nome
ORDER BY total_personagens DESC;


--Quantidade total de itens por raridade,ordenado do mais raro para o mais comum
SELECT
    raridade,
    COUNT(*) AS quantidade_itens
FROM items
GROUP BY raridade
ORDER BY
    CASE raridade
        WHEN 'Épico' THEN 1
        WHEN 'Raro' THEN 2
        WHEN 'Incomum' THEN 3
        WHEN 'Comum' THEN 4
        ELSE 5
    END;

--uso do chat, mas refazer apos ver o conteudo em aula
--Classes com mais de 100 personagens ativos
SELECT
    c.nome AS classe,
    COUNT(p.id) AS total_ativos
FROM personagens p
INNER JOIN classes c
    ON p.classe_id = c.id
INNER JOIN accont a
    ON p.conta_id = a.id
WHERE a.ativo = 1
GROUP BY c.nome
HAVING COUNT(p.id) > 100;


--Magia mais cara e a mais barata,
-- mostrando nome e custo de mana
SELECT TOP 1
    nome,
    custo_mana
FROM magias
ORDER BY custo_mana DESC;

SELECT TOP 1
    nome,
    custo_mana
FROM magias
ORDER BY custo_mana ASC;