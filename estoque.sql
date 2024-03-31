CREATE DATABASE SistemaDeEstoque;

USE SistemaDeEstoque;

CREATE TABLE usuario(
CodUsuario int UNSIGNED NOT NULL AUTO_INCREMENT,
NomeUsuario varchar(80),
CPF varchar(14) NOT NULL UNIQUE,
PRIMARY KEY (CodUsuario)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO usuario (CodUsuario, NomeUsuario, CPF)
VALUES
(14780, 'Pascal', '160.230.560-91'),
(102030, 'Jeferson', '132.796.175-02');
 
CREATE TABLE setor(
CodSetor int UNSIGNED NOT NULL AUTO_INCREMENT,
NomeSetor varchar(80),
PRIMARY KEY(CodSetor)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO setor (CodSetor, NomeSetor)
VALUES
(1, 'TI'),
(2, 'Contabilidade'),
(3, 'Recursos Humanos'),
(4, 'Marketing');

CREATE TABLE produto(
CodProduto int UNSIGNED NOT NULL AUTO_INCREMENT,
NomeProduto varchar(80),
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
CodRequisicao int UNSIGNED NOT NULL AUTO_INCREMENT,
DataRequisicao date,
FkCodSetor int UNSIGNED,
FkCodUsuario int UNSIGNED,
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
CodRequisicaoProduto int UNSIGNED NOT NULL AUTO_INCREMENT,
Quantidade int,
FkCodRequisicao int UNSIGNED,
FkCodProduto int UNSIGNED,
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
       
-- FK TABLE REQUISIÇÃO --

ALTER TABLE requisicao
ADD FOREIGN KEY (FkCodSetor)
REFERENCES setor (CodSetor);

ALTER TABLE requisicao
ADD FOREIGN KEY(FkCodUsuario)
REFERENCES usuario (CodUsuario);

-- FK TABLE REQUISIÇÃO DO PRODUTO --

ALTER TABLE RequisicaoProduto
ADD FOREIGN KEY (FkCodRequisicao) 
REFERENCES requisicao (codRequisicao);

ALTER TABLE RequisicaoProduto
ADD FOREIGN KEY (FkCodProduto) 
REFERENCES produto (CodProduto);

-- CONSULTAS --
SELECT * FROM RequisicaoProduto;

SELECT * FROM  produto
ORDER BY 1 DESC;

SELECT DISTINCT CodProduto FROM produto;

SELECT * FROM requisicao
WHERE FkCodSetor = 3 
AND FkCodUsuario = 102030; 

SELECT * FROM requisicao
WHERE FkCodSetor = 1
OR FkCodSetor = 4;

SELECT * FROM requisicao
WHERE NOT FkCodSetor = 3;

SELECT * FROM requisicao
WHERE FkCodSetor = 3
AND FkCodUsuario = 102030
OR FkCodSetor = 1;

SELECT * FROM RequisicaoProduto;

UPDATE RequisicaoProduto
SET Quantidade = NULL
WHERE CodRequisicaoProduto = 1;

-- FORMA ERRADA --
SELECT * FROM RequisicaoProduto
WHERE Quantidade = NULL;

-- -----------------------------

SELECT * FROM RequisicaoProduto
WHERE Quantidade IS NULL;

SELECT * FROM RequisicaoProduto
WHERE Quantidade IS NOT NULL;

SELECT * FROM Requisicao
WHERE FkCodSetor IN (1, 4);

SELECT * FROM Setor
WHERE CodSetor NOT IN (1, 3);

ALTER TABLE produto 
ADD QuantidadeEstoque TINYINT;
