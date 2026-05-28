USE rpg_game;

CREATE TABLE accont (
  id            INT            IDENTITY(1,1) NOT NULL,
  login         NVARCHAR(50)   NOT NULL,
  email         NVARCHAR(120)  NOT NULL,
  senha_hash    NVARCHAR(255)  NOT NULL,
  data_criacao  DATETIME       NOT NULL,
  ativo         BIT            NOT NULL
);

CREATE TABLE player (
  id            INT            IDENTITY(1,1) NOT NULL,
  conta_id      INT            NOT NULL,    -- vai virar FK
  classe_id     INT            NOT NULL,
  nome          NVARCHAR(60)   NOT NULL,
  nivel         SMALLINT       NOT NULL,
  vida_max      INT            NOT NULL,
  mana_max      INT            NOT NULL,
  experiencia   BIGINT         NOT NULL,
  data_criacao  DATETIME       NOT NULL
);

CREATE TABLE items (
  id          INT            IDENTITY(1,1) NOT NULL,
  nome        NVARCHAR(80)   NOT NULL,
  tipo        NVARCHAR(30)   NOT NULL,
  raridade    NVARCHAR(20)   NOT NULL,
  valor       DECIMAL(10,2)  NOT NULL
);

CREATE TABLE magias (
  id          INT            IDENTITY(1,1) NOT NULL,
  nome        NVARCHAR(80)   NOT NULL,
  custo_mana  SMALLINT       NOT NULL,
  dano        INT            NULL,    -- algumas magias não têm dano, como magias para correr mais
  tipo        NVARCHAR(30)   NOT NULL
);

