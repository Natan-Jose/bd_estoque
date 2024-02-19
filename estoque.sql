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
(14780, 'Pascal', '160.230.560-91');

select * from usuario;
 
create table setor(
cod_setor int not null auto_increment,
nome_setor varchar(80),
primary key(cod_setor)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into setor (cod_setor, nome_setor)
values (3, 'Recursos Humanos');


create table produto(
cod_produto int not null auto_increment,
nome_produto varchar(80),
primary key(cod_produto)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into produto (cod_produto, nome_produto)
values 
(15, 'Lápis Grafite'),
(3, 'Caneta Azul'),
(9, 'Caneta Preta'),
(45, 'Caneta Vermelha'),
(33, 'Resma de Papel');

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

insert into requisicao (cod_requisicao, data_requisicao, fk_cod_setor, fk_cod_usuario)
values (1200, '1990-03-17', 3, 14780);


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
(default, 1, 33, 1200);

select * from requisicao_produto;

