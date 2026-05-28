CREATE DATABASE metodos;

USE metodos;

INSERT

INSERT INTO contas (login, email, senha_hash, data_criacao, ativo)
VALUES 
 ('gabriel', 'gabruel@gmail.com', 'hash_aqui', GETDATE(), 1) 

--SELECT 
SELECT * FROM contas;

SELECT login, emai FROM contas;

SELECT login AS usuario, email AS contato FROM conta;

--WHERE
SELECT * FROM peronagens WHERE nivel = 10;
SELECT * FROM personagens WHERE classe_id != 2

SELECT * FROM personagens WHERE class_id(1,2)
SELECT * FROM livros WHERE nome LIKE ´Harry Potter%`
SELECT * FROM tabela WHERE coluna IS NULL coluna ""

--UPDATE
UPDATE personagens
SET nivel = nivel + 1,
    experiencia = 0 
WHERE id = 42;

UPDATE personagens 
SET vida_max = vida_max + 10
WHERE class_id = 1;

--DELETE
DELETE FROM personagens
WHERE id = 42;

DELETE FROM personagens
WHERE ativo = 0;