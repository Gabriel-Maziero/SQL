CREATE DATABASE petshop;

USE petshop;

DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS cachorros;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS servicos;
GO

CREATE TABLE usuario(
id     INT IDENTITY(1,1)     NOT NULL,
nome   NVARCHAR(100)         NOT NULL, 
email  NVARCHAR(50)          NOT NULL
);

CREATE TABLE cachorros(
id             INT                IDENTITY(1,1)  NOT NULL,
id_usuario     NVARCHAR(50)       NOT NULL,
nome           NVARCHAR(20)       NOT NULL,
raca           NVARCHAR(30)       NOT NULL
);

CREATE TABLE produtos(
id                INT           IDENTITY(1,1) NOT NULL,
id_remedio        NVARCHAR      NOT NULL,
id_alimentos      NVARCHAR      NOT NULL,
id_utilitarios    NVARCHAR      NOT NULL
);

CREATE TABLE servicos(
id              INT              IDENTITY(1,1) NOT NULL,
id_cachorro     NVARCHAR(20)     NOT NULL,
banho           NVARCHAR(20)     NOT NULL,
tosa            NVARCHAR(20)     NOT NULL,
cosulta         NVARCHAR(20)     NOT NULL
);