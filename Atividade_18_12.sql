--Sistema Gestão de Biblioteca
begin;
create table autor(
     id serial primary key,
	 nome varchar(60) not null,
	 data_nascimento date,
	 constraint chk_data_nascimento check (data_nascimento <= current_date) 

);
begin;
create table livro(
   id serial primary key,
   titulo varchar(60) not null,
   id_autor integer,
   ano_publicacao int,
   constraint fk_autor_livro foreign key (id_autor) references autor(id),
   constraint chk_ano_publicacao check (ano_publicacao >= 1500 and ano_publicacao <=  extract(year from current_date))


);



begin;
create table usuario(
   id serial primary key,
   nome varchar(60) not null,
   email varchar(60) unique,
   data_adesao date,
   constraint chk_data_adesao check (data_adesao <= current_date)
   
   
);


begin;
create table emprestimo(
    id serial primary key,
	id_livro integer,
	id_usuario integer,
	data_emprestimo date not null,
	data_devolucao date not null,
	
	constraint fk_livro foreign key(id_livro) references livro(id),
	constraint fk_usuario foreign key(id_usuario) references usuario(id),
	constraint chk_emprestimo_devolucao check (data_emprestimo <= data_devolucao)



);
commit;
rollback;

begin;
insert into autor(nome, data_nascimento)
values ('R.R Tolkien', '1925-03-20'),
('Mario Puzo', '1900-03-20'),
('j.K Rowling', ' 1910-12-20'),
('Alan Moore', ' 1920-11-03');

select nome,data_nascimento from autor

begin;
insert into livro(titulo,id_autor,ano_publicacao)
values('Senhor dos Aneis',1,'1980'),
('O Poderoso Chefao', 2, '1940'),
('Harry Potter',3,'1950' ),
('The Watchmen',4,'1960');

select titulo,id_autor,ano_publicacao from livro

begin;
insert into usuario(nome,email, data_adesao)
values('Gabriel', 'gabriel@gmail.com', '11-05-2024'),
('Luis', 'luis@gmail.com', '12-08-2024'),
('David', 'david@gmail.com', '12-16-2024'),
('Tiago', 'tiago@gmail.com', '09-20-2024');

rollback;

--01 liste todos os livros com seus respectivos autores
--select livro.titulo, autor.nome from autor
--join livro on livro.id_autor = autor-id;




--informacoes do livro, do usarios e as datas
select usuario.nome, livro.titulo, emprestimo.data_emprestimo, emprestimo.data_devolucao
from emprestimo
join livro on id_livro = livro.id
join usuario on 


18. -- Encontre o usuarios que pegaram emprestado  livros do autor ' um dos autores'

select usuario.nome,livro.titulo,  autor.nome 
from emprestimo
join livro on id_livro = livro.id
join usuario on  id_usuario = usuario.id
join autor on id_autor = autor.id
where autor.nome = 'J.K Rowling'

