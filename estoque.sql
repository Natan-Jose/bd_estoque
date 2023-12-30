create database bd_estoque;

use bd_estoque;

create table usuario(
cod_usuario int not null auto_increment,
nome_usuario varchar(80),
CPF bigint not null,
primary key (cod_usuario)
);

create table setor(
cod_setor int not null auto_increment,
nome_setor varchar(80),
primary key(cod_setor)
);

create table produto(
cod_produto int not null auto_increment,
nome_produto varchar(80),
primary key(cod_produto)
);

create table requisicao(
cod_requisicao int not null auto_increment,
data_requisicao date,
primary key (cod_requisicao)
); 

alter table requisicao
add column fk_cod_usuario int;

alter table requisicao
add foreign key (fk_cod_usuario)
references usuario (cod_usuario);

alter table requisicao
add column fk_cod_setor int;

alter table requisicao
add foreign key (fk_cod_setor)
references setor (cod_setor);

create table requisicao_produto(
cod_requisicao_produto int not null auto_increment,
quantidade int,
primary key(cod_requisicao_produto)
);

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
