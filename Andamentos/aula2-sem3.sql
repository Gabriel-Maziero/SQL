CREATE DATABASE biblioteca;

USE biblioteca;

CREATE TABLE autores (
id               INT               IDENTITY(1,1) NOT NULL,
nome             NVARCHAR(100)     NOT NULL,
nacionalidade    NVARCHAR(100)     NOT NULL
);

CREATE TABLE livros (
id               INT               IDENTITY(1,1) NOT NULL, 
id_autor         INT               NOT NULL,
nome             NVARCHAR(100)     NOT NULL,
paginas          INT               NOT NULL
);

CREATE TABLE usuarios (
id          INT              IDENTITY(1,1) NOT NULL,
nome        NVARCHAR(100)    NOT NULL,
email       NVARCHAR(50)     NOT NULL
);

CREATE TABLE emprestimos( -->usuario_livro
id             INT             IDENTITY(1,1) NOT NULL,
id_livro       INT             NOT NULL,
id_usuario     INT             NOT NULL,
devolvido      NVARCHAR(50)    NOT NULL,
emprestado_em  NVARCHAR(50)    NOT NULL,
vencimento_em  NVARCHAR(50)    NOT NULL
);