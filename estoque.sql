CREATE DATABASE SistemaDeEstoque;

USE SistemaDeEstoque;

CREATE TABLE usuario(
CodUsuario INT UNSIGNED NOT NULL AUTO_INCREMENT,
NomeUsuario VARCHAR(80),
CPF VARCHAR(14) NOT NULL UNIQUE,
PRIMARY KEY (CodUsuario)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO usuario (CodUsuario, NomeUsuario, CPF)
VALUES
(14780, 'Pascal', '160.230.560-91'),
(102030, 'Jeferson', '132.796.175-02');
 
CREATE TABLE setor(
CodSetor INT UNSIGNED NOT NULL AUTO_INCREMENT,
NomeSetor VARCHAR(80),
PRIMARY KEY(CodSetor)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO setor (CodSetor, NomeSetor)
VALUES
(1, 'TI'),
(2, 'Contabilidade'),
(3, 'Recursos Humanos'),
(4, 'Marketing');

CREATE TABLE produto(
CodProduto INT UNSIGNED NOT NULL AUTO_INCREMENT,
NomeProduto VARCHAR(80),
PRIMARY KEY(CodProduto)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO produto (CodProduto, NomeProduto)
VALUES
(1, 'Cartucho P&B'),
(2, 'Cartucho colorido'),
(3, 'Caneta Azul'),
(4, 'Pendrive'),
(5, 'Borracha'),
(9, 'Caneta Preta'),
(10, 'Corretor'),
(15, 'Lápis Grafite'),
(33, 'Resma de Papel'),
(45, 'Caneta Vermelha');

CREATE TABLE requisicao(
CodRequisicao INT UNSIGNED NOT NULL AUTO_INCREMENT,
DataRequisicao DATE,
FkCodSetor INT UNSIGNED NOT NULL,
FkCodUsuario INT UNSIGNED NOT NULL,
PRIMARY KEY (CodRequisicao)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO requisicao 
(CodRequisicao, DataRequisicao, FkCodSetor, FkCodUsuario)
VALUES
(1200, '1990-03-17', 3, 14780),
(1201, '2020-07-21', 3, 102030),
(1202, '2020-06-01', 1, 14780),
(1203, '2020-03-05', 2, 102030), 
(1204, '2020-02-10', 4, 102030);

CREATE TABLE RequisicaoProduto(
CodRequisicaoProduto INT UNSIGNED NOT NULL AUTO_INCREMENT,
Quantidade INT,
FkCodRequisicao INT UNSIGNED NOT NULL,
FkCodProduto INT UNSIGNED NOT NULL,
PRIMARY KEY(CodRequisicaoProduto)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO RequisicaoProduto 
(CodRequisicaoProduto, Quantidade, FkCodProduto, FkCodRequisicao)
VALUES 
(DEFAULT, 2, 15, 1200),
(DEFAULT, 3, 3, 1200),
(DEFAULT, 2, 9, 1200),
(DEFAULT, 1, 45, 1200),
(DEFAULT, 1, 33, 1200),
(DEFAULT, 1, 10, 1202),
(DEFAULT, 2, 10, 1202),
(DEFAULT, 33, 5, 1204);     

-- RESTRIÇÕES

ALTER TABLE requisicao
ADD CONSTRAINT Fk_requisicao_Setor
FOREIGN KEY (FkCodSetor)
REFERENCES setor (CodSetor);

ALTER TABLE requisicao
ADD CONSTRAINT Fk_requisicao_Usuario
FOREIGN KEY(FkCodUsuario)
REFERENCES usuario (CodUsuario);

ALTER TABLE RequisicaoProduto
ADD CONSTRAINT Fk_RequisicaoProduto_CodRequisicao
FOREIGN KEY (FkCodRequisicao) 
REFERENCES requisicao (CodRequisicao);

ALTER TABLE RequisicaoProduto
ADD CONSTRAINT Fk_RequisicaoProduto_Produto
FOREIGN KEY (FkCodProduto) 
REFERENCES produto (CodProduto);

SHOW TABLES;

-- Consulta à tabela RequisicaoProduto --
SELECT * FROM RequisicaoProduto;

-- Ordenar a tabela produto por CodProduto em ordem decrescente --
SELECT * FROM produto ORDER BY CodProduto DESC;

-- Selecionar os códigos de produto distintos --
SELECT DISTINCT CodProduto FROM produto;

-- Consultar requisições para o setor 3 e o usuário 102030 --
SELECT * FROM requisicao WHERE FkCodSetor = 3 AND FkCodUsuario = 102030;

-- Consultar requisições para o setor 1 ou 4 --
SELECT * FROM requisicao WHERE FkCodSetor = 1 OR FkCodSetor = 4;

-- Consultar requisições que não são para o setor 3 --
SELECT * FROM requisicao WHERE NOT FkCodSetor = 3;

-- Consultar requisições para o setor 3 e o usuário 102030 ou para o setor 1 --
SELECT * FROM requisicao WHERE (FkCodSetor = 3 AND FkCodUsuario = 102030) OR FkCodSetor = 1;

-- Consulta para atualizar a quantidade para NULL em um registro específico --
UPDATE RequisicaoProduto SET Quantidade = NULL WHERE CodRequisicaoProduto = 1;

-- Consulta corrigida para selecionar registros com Quantidade NULL --
SELECT * FROM RequisicaoProduto WHERE Quantidade IS NULL;

-- Consulta para selecionar registros com Quantidade não NULL --
SELECT * FROM RequisicaoProduto WHERE Quantidade IS NOT NULL;

-- Consulta para selecionar requisições para os setores 1 e 4 --
SELECT * FROM Requisicao WHERE FkCodSetor IN (1, 4);

-- Consulta para selecionar setores cujos códigos não estão em 1 ou 3 --
SELECT * FROM Setor WHERE CodSetor NOT IN (1, 3);

-- Adição da coluna QuantidadeEstoque à tabela produto --
ALTER TABLE produto ADD QuantidadeEstoque TINYINT;

-- Consulta à tabela REQUISICAO --
SELECT * FROM REQUISICAO;
