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
    usuario.nome as nome_usuario
