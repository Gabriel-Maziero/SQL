USE rpg_game

INSERT INTO accont (login, email, senha_hash, data_criacao, ativo)
VALUES
 ('Liz', 'liz@mail.com', 'hash1', GETDATE(), 1),
 ('Gbl', 'gbl@mail.com', 'hash2', GETDATE(), 1),
 ('Art', 'art@mail.com', 'hash3', GETDATE(), 0);

 SELECT * FROM accont
 SELECT * FROM accont WHERE ativo = 1
 SELECT * FROM accont WHERE login = 'Gbl' AND senha_hash = 'hash_errado'
   SELECT * FROM accont WHERE login = 'Gbl' AND senha_hash = 'hash2'