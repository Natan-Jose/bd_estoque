create database bd_estoque;

use bd_estoque;

create table usuario(
cod_usuario int not null auto_increment,
nome_usuario varchar(80),
CPF varchar(14) not null unique,
primary key (cod_usuario)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into usuario (cod_usuario, nome_usuario, CPF)
values
(14780, 'Pascal', '160.230.560-91'),
(102030, 'Jeferson', '132.796.175-02');

select * from usuario;
 
create table setor(
cod_setor int not null auto_increment,
nome_setor varchar(80),
primary key(cod_setor)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into setor (cod_setor, nome_setor)
values 
(1, 'TI'),
(2, 'Contabilidade'),
(3, 'Recursos Humanos'),
(4, 'Marketing');

create table produto(
cod_produto int not null auto_increment,
nome_produto varchar(80),
primary key(cod_produto)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into produto (cod_produto, nome_produto)
values 
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

create table requisicao(
cod_requisicao int not null auto_increment,
data_requisicao date,
primary key (cod_requisicao)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table requisicao
add column fk_cod_setor int;

alter table requisicao
add foreign key (fk_cod_setor)
references setor (cod_setor);

alter table requisicao
add column fk_cod_usuario int;

alter table requisicao
add foreign key (fk_cod_usuario)
references usuario (cod_usuario);

insert into requisicao 
(cod_requisicao, data_requisicao, fk_cod_setor, fk_cod_usuario)
values 
(1200, '1990-03-17', 3, 14780),
(1201, '2020-07-21', 3, 102030),
(1202, '2020-06-01', 1, 14780),
(1203, '2020-03-05', 2, 102030), 
(1204, '2020-02-10', 4, 102030);

create table requisicao_produto(
cod_requisicao_produto int not null auto_increment,
quantidade int,
primary key(cod_requisicao_produto)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table requisicao_produto
add column fk_cod_requisicao int;

alter table requisicao_produto
add foreign key (fk_cod_requisicao) 
references requisicao (cod_requisicao);

alter table requisicao_produto
add column fk_cod_produto int;

alter table requisicao_produto
add foreign key (fk_cod_produto) 
references produto (cod_produto);

insert into requisicao_produto 
(cod_requisicao_produto, quantidade, fk_cod_produto, fk_cod_requisicao)
values 
(default, 2, 15, 1200),
(default, 3, 3, 1200),
(default, 2, 9, 1200),
(default, 1, 45, 1200),
(default, 1, 33, 1200),
(default, 1, 10, 1202),
(default, 2, 10, 1202),
(default, 33, 5, 1204);
       
select * from requisicao_produto;

select * from produto
ORDER BY 1 DESC;

SELECT DISTINCT cod_produto FROM produto;

SELECT * FROM requisicao
WHERE fk_cod_setor = 3 AND fk_cod_usuario = 102030; 

SELECT * FROM requisicao
WHERE fk_cod_setor = 1
OR Fk_cod_setor = 4;

SELECT * FROM requisicao
WHERE NOT fk_cod_setor = 3;

SELECT * FROM requisicao
WHERE fk_cod_setor = 3
AND fk_Cod_Usuario = 102030
OR Fk_Cod_Setor = 1;

SELECT * FROM requisicao_produto;

UPDATE requisicao_produto
SET quantidade = NULL
WHERE Cod_Requisicao_Produto = 1;

-- Forma Errada
SELECT * FROM requisicao_Produto
WHERE quantidade = NULL;

SELECT * FROM requisicao_Produto
WHERE quantidade IS NULL;

SELECT * FROM requisicao_Produto
WHERE quantidade IS NOT NULL;

