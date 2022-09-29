USE programa_bolsas;

# Criar e executar as consultas abaixo sobre o modelo de dados de uma Biblioteca:

# a) Listar todos os livros publicados após 2014 - OK
SELECT * FROM LIVRO WHERE year(Publicacao) >2014;

# b) Listar os 10 livros mais caros - OK 
SELECT * FROM LIVRO ORDER BY Valor DESC LIMIT 10;

# c) Listar as 5 editoras que mais tem livros na biblioteca - OK
SELECT A.CodEditora, A.Nome, COUNT(*) AS NUMERO FROM
EDITORA A
INNER JOIN LIVRO B
ON A.CodEditora = B.Editora
GROUP BY A.Nome ORDER BY NUMERO DESC LIMIT 5;

# d) Listar a quantidade de publicações de cada autor - OK 
SELECT A.CodAutor, A.Nome, COUNT(B.Cod) FROM
AUTOR A
left JOIN LIVRO B
ON A.CodAutor = B.Autor
GROUP BY A.CodAutor, A.Nome order by COUNT(B.Cod) ;

# e) Listar a quantidade de publicações de cada editora - OK
SELECT A.CodEditora, A.Nome, COUNT(*) FROM
EDITORA A
INNER JOIN LIVRO B
ON A.CodEditora = B.Editora
GROUP BY A.CodEditora, A.Nome;

# f) Listar qual é o autor com mais publicações - OK
SELECT A.CodAutor, A.Nome, COUNT(*) AS NUMERO FROM
AUTOR A
INNER JOIN LIVRO B
ON A.CodAutor = B.Autor
GROUP BY A.CodAutor, A.Nome ORDER BY NUMERO DESC LIMIT 1;

# g) Listar qual é o autor com menos ou nenhuma publicação - OK
SELECT A.CodAutor, A.Nome, COUNT(B.Cod) AS NUMERO FROM
AUTOR A
LEFT JOIN LIVRO B
ON A.CodAutor = B.Autor
GROUP BY A.CodAutor, A.Nome ORDER BY NUMERO ASC LIMIT 1;

# Criar e executar as consultas abaixo sobre o modelo de dados de uma Loja:

# a) selecione o nome e o código do vendedor com o maior número de vendas.
SELECT A.CdVdd, A.NmVdd, COUNT(B.CdVen) AS TotalVendas FROM TbVendedor A INNER JOIN TbVendas B ON A.CdVdd = B.CdVdd
GROUP BY A.CdVdd, A.NmVdd ORDER BY TotalVendas DESC LIMIT 1;

# b) selecione o produto mais vendido entre as datas de 2014-02-03 até 2018-02-02.
SELECT NmPro, SUM(Qtd) FROM TbVendas where DtVen between '2014-02-03' and '2018-02-02'  and status = 'concluido' group by NmPro order by SUM(Qtd) desc;

# c) calcule a comissão dos vendedores.
select A.NmVdd, sum(B.Qtd * B.VrUnt) as total, sum(PercComissao/100 * (B.Qtd * B.VrUnt)) as comissao 
from TbVendedor A 
inner join TbVendas B 
on A.CdVdd = B.CdVdd 
where B.status = 'concluido'
group by A.NmVdd 
order by A.NmVdd, comissao;

# d) selecione o cliente que mais gastou.
select NmCli, sum(Qtd * VrUnt) as total from TbVendas group by NmCli order by total desc limit 1;

# f) selecione os 10 produtos menos vendidos por ecommerce e pela matriz.

# g) calcule a média de gasto por estado.
select estado, round(avg(qtd*VrUnt),2) as media from TbVendas
where status = 'concluido'
group by estado
order by media;

# h) selecione todos os registro deletado.
select * from TbVendas
where deletado = 1;

# i) calcule a media da quantidade vendida de cada produto por estado.
select estado, nmpro, round(avg(qtd),2) as media from TbVendas
where status = 'concluido'
group by estado;


