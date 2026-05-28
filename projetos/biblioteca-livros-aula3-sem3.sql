USE master;
GO

IF DB_ID('biblioteca') IS NULL
BEGIN
    CREATE DATABASE biblioteca;
END
GO

USE biblioteca;
GO

DROP TABLE IF EXISTS emprestimos;
DROP TABLE IF EXISTS livros;
DROP TABLE IF EXISTS autores;
DROP TABLE IF EXISTS usuarios;
GO

CREATE TABLE autores (
    id            INT            IDENTITY(1,1) NOT NULL,
    nome          NVARCHAR(100)  NOT NULL,
    nacionalidade NVARCHAR(100)  NOT NULL
);

CREATE TABLE livros (
    id            INT            IDENTITY(1,1) NOT NULL,
    id_autor      INT            NOT NULL,
    nome          NVARCHAR(150)  NOT NULL,
    qtd_paginas   INT            NOT NULL
);

CREATE TABLE usuarios (
    id    INT            IDENTITY(1,1) NOT NULL,
    nome  NVARCHAR(100)  NOT NULL,
    email NVARCHAR(150)  NOT NULL
);

CREATE TABLE emprestimos (
    id            INT       IDENTITY(1,1) NOT NULL,
    id_usuario    INT       NOT NULL,
    id_livro      INT       NOT NULL,
    devolvido     BIT       NOT NULL,
    emprestado_em DATETIME2 NOT NULL,
    devolvido_em  DATETIME2 NULL
);

INSERT INTO autores (nome, nacionalidade) VALUES
    ('Machado de Assis', 'Brasileira'),
    ('Clarice Lispector', 'Brasileira'),
    ('Jorge Amado', 'Brasileira'),
    ('João Guimarães Rosa', 'Brasileira'),
    ('Gabriel García Márquez', 'Colombiana'),
    ('J.K. Rowling', 'Britânica'),
    ('George Orwell', 'Britânica'),
    ('Haruki Murakami', 'Japonesa'),
    ('Chimamanda Ngozi Adichie', 'Nigeriana'),
    ('Conceição Evaristo', 'Brasileira');

INSERT INTO livros (id_autor, nome, qtd_paginas) VALUES
    (1, 'Dom Casmurro', 256),
    (1, 'Memórias Póstumas de Brás Cubas', 240),
    (2, 'A Hora da Estrela', 88),
    (3, 'Gabriela, Cravo e Canela', 320),
    (4, 'Grande Sertão: Veredas', 624),
    (5, 'Cem Anos de Solidão', 448),
    (6, 'Harry Potter e a Pedra Filosofal', 264),
    (7, '1984', 328),
    (8, 'Norwegian Wood', 296),
    (9, 'Americanah', 608),
    (10, 'Ponciá Vicêncio', 128),
    (2, 'Perto do Coração Selvagem', 192);

INSERT INTO usuarios (nome, email) VALUES
    ('Ana Clara Mendes', 'ana.mendes@email.com'),
    ('Bruno Ferreira Lima', 'bruno.lima@email.com'),
    ('Camila Rodrigues Santos', 'camila.santos@email.com'),
    ('Daniel Oliveira Costa', 'daniel.costa@email.com'),
    ('Eduarda Silva Almeida', 'eduarda.almeida@email.com'),
    ('Felipe Martins Souza', 'felipe.souza@email.com'),
    ('Giovana Pereira Nunes', 'giovana.nunes@email.com'),
    ('Henrique Barbosa Reis', 'henrique.reis@email.com'),
    ('Isabela Carvalho Mendes', 'isabela.mendes@email.com'),
    ('João Pedro Almeida', 'joao.almeida@email.com');

INSERT INTO emprestimos (id_usuario, id_livro, devolvido, emprestado_em, devolvido_em) VALUES
    (1, 1, 1, '2025-01-10', '2025-01-25'),
    (1, 3, 1, '2025-02-05', '2025-02-18'),
    (2, 5, 0, '2025-03-01', NULL),
    (3, 2, 1, '2025-01-15', '2025-02-02'),
    (3, 6, 1, '2025-02-20', '2025-03-05'),
    (4, 4, 0, '2025-03-10', NULL),
    (5, 7, 1, '2025-01-08', '2025-01-22'),
    (6, 8, 0, '2025-03-08', NULL),
    (7, 9, 1, '2025-02-12', '2025-02-28'),
    (8, 10, 0, '2025-03-15', NULL),
    (9, 11, 1, '2025-01-20', '2025-02-10'),
    (10, 12, 0, '2025-03-12', NULL);
GO

--Mostrar todos os autores
SELECT * FROM autores

--Mostrar os livros com os alunos
SELECT id_livro FROM emprestimos WHERE devolvido = 0
--SELECT id_livro FROM emprestimos WHERE devolvido_em IS NULL --ver por data

--Mostrar um livro pelo nome
SELECT * FROM livros WHERE nome = 'Dom Casmurro' AND id_autor = '1' --Caso tenha mais de um autor
--SELECT * FROM livros WHERE nome = 'Dom Casmurro' 
--SELECT * FROM livros WHERE nome LIKE '%Dom'

--Listar em ordem alfabetica
SELECT nome FROM livros
ORDER BY nome;

--Retornar qntade de autores cadastrados
SELECT TOP 10 nome
FROM autores
ORDER BY nome DESC;

--Listar qntdade de emprestimos por usuario
SELECT devolvido FROM emprestimos
ORDER BY id_usuario;

--Total de livros por autor
SELECT id_autor, COUNT(*) AS total
FROM livros
GROUP BY id_autor;

--Total de livros por autor, mostrando os nomes
SELECT id_autor, COUNT(*) AS qtd_livros
FROM livros
 INNER JOIN autores
  ON livros.id_autor = autores.id
GROUP BY id_autor;

--Autores com mais de um livro
SELECT id_autor, COUNT(*) AS total
FROM livros
GROUP BY id_autor
HAVING COUNT(*) > 1;
