SELECT * FROM produto ORDER BY CodProduto DESC;

SELECT DISTINCT CodProduto FROM produto;

SELECT * FROM requisicao WHERE FkCodSetor = 3 AND FkCodUsuario = 102030;

SELECT * FROM requisicao WHERE FkCodSetor = 1 OR FkCodSetor = 4;

SELECT * FROM requisicao WHERE NOT FkCodSetor = 3;

SELECT * FROM requisicao WHERE (FkCodSetor = 3 AND FkCodUsuario = 102030) OR FkCodSetor = 1;

UPDATE RequisicaoProduto SET Quantidade = NULL WHERE CodRequisicaoProduto = 1;

SELECT * FROM RequisicaoProduto WHERE Quantidade IS NULL;

SELECT * FROM RequisicaoProduto WHERE Quantidade IS NOT NULL;

SELECT * FROM Requisicao WHERE FkCodSetor IN (1, 4);

SELECT * FROM Setor WHERE CodSetor NOT IN (1, 3);

-- VALORES ALEATORIOS

SELECT RAND(); 

SELECT ROUND((0 + (250 - 0)) * RAND());
---------------------------------------

UPDATE produto
SET QuantidadeEstoque = (ROUND((0 + (250 - 0)) * RAND()))
WHERE CodProduto <= 45;
-- AND QuantidadeEstoque IS NULL

SELECT * FROM produto;

SELECT * FROM produto
WHERE CodProduto BETWEEN 9 AND 20;

SELECT * FROM produto
WHERE CodProduto NOT BETWEEN 9 AND 20;

SELECT * FROM produto LIMIT 3;

SELECT NomeProduto, QuantidadeEstoque
FROM produto
ORDER BY QuantidadeEstoque DESC
LIMIT 3;

SELECT NomeProduto, QuantidadeEstoque
FROM produto
LIMIT 2, 3;

SELECT NomeProduto, QuantidadeEstoque
FROM produto
LIMIT 3 OFFSET 2; 

SELECT COUNT(*) AS Total FROM produto;

SELECT
MIN(QuantidadeEstoque) AS MenorEstoque,
MAX(QuantidadeEstoque) AS Maior,
SUM(QuantidadeEstoque) AS TotalEstoque, 
AVG(QuantidadeEstoque) AS "Média"
FROM produto;

SELECT FkCodSetor AS Setor,
COUNT(CodRequisicao) AS "Requisições"
FROM requisicao 
GROUP BY FkCodSetor; 

SELECT * FROM produto
WHERE NomeProduto LIKE "%neta%"; -- Qualquer posição

SELECT * FROM produto
WHERE NomeProduto LIKE "_e%"; -- Possuem "e" na segunda posição

-- B% - Começo
-- %L - Final 
-- C%r - Começa com "C" e termina com "r"

SELECT requisicao.CodRequisicao,
requisicao.DataRequisicao, Usuario.NomeUsuario, setor.NomeSetor
FROM requisicao
INNER JOIN usuario
ON requisicao.FkCodUsuario = Usuario.CodUsuario
INNER JOIN setor
ON requisicao.FkCodSetor = setor.CodSetor 
ORDER BY NomeUsuario;

SELECT usuario.NomeUsuario, COUNT(requisicao.CodRequisicao)
AS "Quantidade Requisição" 
FROM usuario
LEFT JOIN requisicao
ON usuario.CodUsuario = requisicao.FkCodUsuario
GROUP BY usuario.NomeUsuario;

SELECT produto.NomeProduto, COUNT(RequisicaoProduto.CodRequisicaoProduto) 
AS Quantidade
FROM RequisicaoProduto
RIGHT JOIN Produto
ON Produto.CodProduto = RequisicaoProduto.FkCodProduto
GROUP BY Produto.NomeProduto;

SELECT usuario.NomeUsuario, COUNT(requisicao.CodRequisicao)
AS "Quantidade Requisição" 
FROM usuario
LEFT JOIN requisicao
ON usuario.CodUsuario = requisicao.FkCodUsuario
GROUP BY usuario.NomeUsuario
HAVING COUNT(requisicao.CodRequisicao) > 0;