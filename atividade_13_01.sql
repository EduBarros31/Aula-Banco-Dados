

--1 quabtidade de bibliotecario por cada unidade
select unidade.nome as unidade_nome, count(b.id)AS total_bibliotecarios
from unidade
left join bibliotecario b on b.id_unidade = unidade.id 
group by unidade.id,
unidade.nome;

--2 quantidade de livros disponiveis em cada unidade
select unidade.nome as unidade_nome, count(livro.id) as total_livros
from unidade
left join livro on livro.id_unidade = unidade.id
group by unidade.id,
unidade.nome;

--3 quantidade de emprestimos realizados em cada unidade
select unidade.nome as unidade_nome, count(emprestimo.id) as total_emprestimos
from livro
join unidade on livro.id_unidade = unidade.id
left join emprestimo on livro.id = emprestimo.id_livro
group by unidade.id, 
unidade.nome
order by unidade.nome;

5-- qunatodade de usuarios cadastrados no sistema
select count (usuario.id) as total_usuarios
from usuario;

6-- quantidade total de livros cadastrados no sistema
select count (livro.id) as total_livros
from livro;

7-- quantidade de livros emprestados por cada usuario. ordene pelo total encontrado em ordem decrescente
select usuario.nome as usuario_nome, count (emprestimo.id) as total_emprestimos
from usuario
join emprestimo on usuario.id = emprestimo.id_usuario
group by usuario.id, usuario.nome
order by total_emprestimos desc;

8--quantidade de emprestimos realizado por mes
select extract(month from emprestimo.data_emprestimo) as mes,
count (emprestimo.id) as total_emprestimo
from emprestimo
group by mes
order by mes asc, total_emprestimo desc;

9 -- media do numero de paginas dos livros cadastrados no sistema
select round(avg(numero_paginas),2)
from livro;

10-- Quantidade de livros cadastrados em cada categoria
select categoria.nome as categoria, count (livro.id) as total_livros
from categoria 
left join livro on categoria.id = livro.id_categoria
group by categoria.id
order by total_livros desc;

11-- Liste os livros cujos autores possuem nacionalidade americana.
select livro.titulo as livro, autor.nome as autor
from livro
join autor on livro.id_autor = autor.id
where autor.nacionalidade = 'Americana';

12-- Quantidade de livros emprestados atualmente (não devolvidos)
select count (emprestimo.id) as total_livros_emprestado
from livro
join unidade on livro.id_unidade = unidade.id
left join emprestimo on livro.id = emprestimo.id_livro
where emprestimo.devolvido = 'false' or emprestimo.devolvido is null;

13-- Unidades com mais de 60 livros cadastrados.
select unidade.nome, count(livro.id) as total_livros_cadastrados
from unidade
left join livro on livro.id_unidade = unidade.id
group by unidade.nome
having count(livro.id) > 60
order by unidade.nome;

14-- Quantidade de livros por autor. Ordene pelo total e em ordem decrescente
select autor.nome as autor_nome, count (livro.id) as total_livros
from autor
left join livro on livro.id_autor = autor.id
group by autor.id
order by total_livros desc;

15--Categorias que possuem mais de 5 livros disponíveis atualmente.
select categoria.nome as categoria_nome, count(livro.id) as total_livros_disponiveis
from categoria
left join livro  on livro.id_categoria = categoria.id
where livro.disponivel = 'true'
group by categoria.id
order by total_livros_disponiveis desc;

16-- Unidades com pelo menos um empréstimo em aberto.
select unidade.nome as unidade_nome, count(emprestimo.id) as total_emprestimo_aberto
from unidade
left join livro on livro.id_unidade = unidade.id
left join emprestimo on livro.id = emprestimo.id_livro
where emprestimo.devolvido = 'false' or emprestimo.devolvido is null
group by unidade.id, unidade.nome
order by total_emprestimos_aberto desc;

select * from autor;
-- Id, nome, nacionalidade, data_nascimento
select * from bibliotecario;
--id,  nome, email, telefone, id_unidade, data_contratacao
select * from categoria;
--id, nome, descricao
select * from emprestimo;
--id, id-usuario,id_livro, id_emprestimo, data_devolucao, devolvido
select *from livro;
--id, titulo,id_autor, id_categoria, ano_publicacao,numero_paginas,disponivel,id_unidade
select * from unidade;
--id, nome, endereco, telefone, horario_funcionamento
select * from usuario;
--id,nome,email, telefone, endereco, data_cadastro








