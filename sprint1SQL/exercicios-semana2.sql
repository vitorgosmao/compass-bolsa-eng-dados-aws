spool 'G:\Meu Drive\Compass\Material Semana 2\resultadosemana2.csv'

USE programa_bolsas;

/* Listar os 10 livros mais caros */
select L.Cod as CodLivro, 
       L.Titulo as TituloLivro, 
       A.CodAutor as CodAutor,
       A.Nome as NomeAutor,
       L.Valor as ValorLivro,
       E.CodEditora as CodEditora,
       E.Nome as NomeEditora
from LIVRO L
       inner join AUTOR A on L.Autor = A.CodAutor
       inner join EDITORA E on L.Editora = E.CodEditora
order by ValorLivro desc limit 10;

/* Listar as 5 editoras que mais tem livros na biblioteca */
select LIVRO.Cod, 
       LIVRO.Titulo, 
       AUTOR.CodAutor,
       AUTOR.Nome,
       LIVRO.Valor,
       TopEditoras.CodEditora,
       TopEditoras.Nome
from LIVRO inner join AUTOR
    on LIVRO.Autor = AUTOR.CodAutor
           inner join (select EDITORA.CodEditora,
                              EDITORA.Nome, 
                              count(*) as Publicacoes 
                        from EDITORA inner join LIVRO 
                            on EDITORA.CodEditora = LIVRO.Editora 
                            GROUP BY EDITORA.Nome
                            ORDER BY Publicacoes DESC LIMIT 5) TopEditoras
        on LIVRO.Editora = TopEditoras.CodEditora 
        GROUP BY TopEditoras.Nome
                            ORDER BY Publicacoes DESC LIMIT 5;
 

spool off;

