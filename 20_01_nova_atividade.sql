--1 criar uma view livros
create view vw_listar_todos_livros as 
select * from livro
select * from vw_listar_todos_livros

--2 criar view livros disponiveis com titulo, unidade e categoria
create view vw_listar_livros_atributos as
select 
livro.id as id_livro,
livro.titulo,
unidade.nome as unidade_nome,
categoria.nome as categoria_nome
from 
livro
join unidade on livro.id_unidade = unidade.id
join categoria on livro.id_categoria = categoria.id;

select * from vw_listar_livros_atributos

--3 crie uma view para listar os usuários e o total de empréstimos realizados por cada um
create view vw_listar_usuarios_emprestimos as select
usuario.id as id_usuario,
usuario.nome as nome_usuario,
count(emprestimo.id) as total_emorestimos
from usuario
join  emprestimo on usuario.id = emprestimo.id_usuario
group by
usuario.id, usuario.nome;

select * from vw_listar_usuarios_emprestimos

--4 crie uma view que mostre os empréstimos atrasados com os nomes dos usuários e todos os livros
create view vw_listar_emprestimos_atrasados as select 
    usuario.id as id_usuario,
    usuario.nome as nome_usuario,
	livro.titulo as livro_titulo, emprestimo.data_emprestimo,
	emprestimo.data_devolucao from usuario
	join
	emprestimo on usuario.id = emprestimo.id_usuario
	join 
	livro on emprestimo.id_livro = livro.id
	where 
	emprestimo.devolvido = 'false'
	and emprestimo.data_devolucao = current_date;

select * from vw_listar_usuarios_emprestimos

--5 crie uma view para exibir o nome das unidades e o total de livros disponíveis em cada uma
create view vw_unidades_total_livro as select 
   unidade.nome, count(livro.disponivel)
   from unidade
   join livro on unidade.id = livro.id_unidade
   where disponivel = 'true'
   group by unidade.id

select * from vw_unidades_total_livro

--6 Crie uma view que exiba todos os autores com o número total de livros publicado
create view vw_exbir_autores_total_publicados as select 
autor.nome, count (livro.titulo)
from autor
join livro on autor.id = livro.id_autor
group by autor.nome

select * from vw_exbir_autores_total_publicados

--7  Crie uma view para listar todos os empréstimos com o status de devolução (devolvido ou nao)
create view vw_exibir_status_devolucao as select 
 emprestimo.id,
 emprestimo.data_emprestimo,
 emprestimo.data_devolucao,
 case
   when emprestimo.data_devolucao is not null then 'devolvido'
   else 'não devolvido'
 end as status_devolvido
 from
 emprestimo;

 select * from vw_exibir_status_devolucao

 --8  Crie uma view para listar os livros categorizados por ano de publicação, ordenados do mais recente para o mais antigo
 create view vw_exibir_livros_por_ano_publicado as select 
 ano_publicacao, titulo,
 id_autor
 from 
 livro
 order by
 ano_publicacao desc;

select * from vw_exibir_livros_por_ano_publicado

--9 Crie uma view que mostre os bibliotecários e as unidades às quais estão associados
create view vw_bibliotecarios_unidades as select 
bibliotecario.id as id_bibliotecario,
unidade.id as id_unidade
from unidade
join bibliotecario on unidade.id = bibliotecario.id_unidade;

select * from vw_bibliotecarios_unidades

--10 crie uma view para exibir os usuários que nunca realizaram empréstimos

create view vw_exibir_usuarios_sem_emprestimos as select 
usuario.id as id_usuario,
usuario.nome as nome_usuario
from usuario
join emprestimo on usuario.id = emprestimo.id_usuario
where emprestimo.id is null;

select * from vw_exibir_usuarios_sem_emprestimos



-- PROCEDURES

--1 Crie uma procedure para adicionar um novo autor ao banco de dados

CREATE OR REPLACE PROCEDURE INSERIR_NOVO_AUTOR(
NOME VARCHAR,
NACIONALIDADE VARCHAR,
DATA_NASCIMENTO DATE)
LANGUAGE SQL
AS $$
INSERT INTO AUTOR(NOME, NACIONALIDADE, DATA_NASCIMENTO)
VALUES (NOME, NACIONALIDADE, DATA_NASCIMENTO)
$$;

CALL INSERIR_NOVO_AUTOR('E.Barros', 'Brasileira','1982-10-01');

--2  Crie uma procedure para registrar um novo empréstimo, verificando se o livro está disponivel

CREATE OR REPLACE PROCEDURE REGISTRAR_NOVO_EMPRESTIMO( ID_USUARIO INTEGER, 
ID_LIVRO INTEGER, DATA_DEVOLUCAO DATE )

LANGUAGE plpgsql
as $$
begin
INSERT INTO EMPRESTIMO( ID_USUARIO, ID_LIVRO, DATA_DEVOLUCAO)
VALUES(ID_USUARIO, ID_LIVRO, DATA_DEVOLUCAO);

update livro
set disponivel = false
where id = id_livro;
end;
$$;

call registrar_novo_emprestimo(4, 237,'2025-01-30')

--3 crie uma procedure para devolver um livro, atualizando o status de devolução e a disponibilidade
 CREATE OR REPLACE PROCEDURE DEVOLVER_LIVRO( P_ID_EMPRESTIMO INT)
language plpgsql
AS $$
BEGIN
update emprestimo
set devolvido = true
where id = p_id_emprestimo;

update livro
set disponivel = true 
FROM EMPRESTIMO
where livro.id = emprestimo.id_livro and emprestimo.id = p_id_emprestimo;
end;
$$;

call DEVOLVER_LIVRO(3)

--4 rie uma procedure para excluir uma unidade, garantindo que os livros relacionados sejam removidos
CREATE OR REPLACE PROCEDURE EXCLUIR_UNIDADE(ID_UNIDADE INTEGER, NOME VARCHAR, 
TELEFONE VARCHAR, HORARIO_FUNCIONAMENTO VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
UPDATE UNIDADE


SELECT * FROM UNIDADE