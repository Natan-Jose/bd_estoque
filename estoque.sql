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
(102030, 'Jeferson', '132.796.175-02'),
(19092, 'Gil', '148.928.257-13');

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
(45, 'Caneta Vermelha'),
(90, 'Coleção de Cor');

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
       
-- FK TABLE REQUISIÇÃO --

ALTER TABLE requisicao
ADD CONSTRAINT Fk_requisicao_Setor
FOREIGN KEY (FkCodSetor)
REFERENCES setor (CodSetor)
ON DELETE CASCADE;

ALTER TABLE requisicao
ADD CONSTRAINT Fk_requisicao_Usuario
FOREIGN KEY(FkCodUsuario)
REFERENCES usuario (CodUsuario)
ON DELETE CASCADE;

-- FK TABLE REQUISIÇÃO DO PRODUTO --

ALTER TABLE RequisicaoProduto
ADD CONSTRAINT Fk_RequisicaoProduto_CodRequisicao
FOREIGN KEY (FkCodRequisicao) 
REFERENCES requisicao (CodRequisicao)
ON DELETE CASCADE;

ALTER TABLE RequisicaoProduto
ADD CONSTRAINT Fk_RequisicaoProduto_Produto
FOREIGN KEY (FkCodProduto) 
REFERENCES produto (CodProduto)
ON DELETE CASCADE;

ALTER TABLE produto 
ADD QuantidadeEstoque TINYINT;

ALTER TABLE produto
MODIFY QuantidadeEstoque TINYINT UNSIGNED; 

-- VALORES ALEATORIOS

SELECT RAND(); 

SELECT ROUND((0 + (250 - 0)) * RAND());
---------------------------------------

UPDATE produto
SET QuantidadeEstoque = (ROUND((0 + (250 - 0)) * RAND()))
WHERE CodProduto <= 45;
-- AND QuantidadeEstoque IS NULL

