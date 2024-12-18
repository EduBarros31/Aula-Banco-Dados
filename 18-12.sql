begin;
create table autor(
     id serial primary key,
	 nome varchar(60) not null,
	 data_nascimento date,
	 constraint chk_data_nascimento check (data_nascimento <= current_date) 

);


create table livro(
   id serial primary key,
   titulo varchar(60) not null,
   id_autor integer,
   ano_publicacao int,
   constraint fk_autor_livro check foreign key (id_autor) references autor(id),
   constraint chk_ano_publicacao check (ano_publicacao <= 1500 and ano_publicacao <= and extract(year from currente date)




);



 
create table usuario(
   id serial primary key,
   nome varchar(60) not null,
   email varchar(60) unique,
   data_adesao date,
   constraint chk_data_adesao check (data_adesao <= current_date)
   
   
);

rollback;


begin
create table emprestimo(
    id serial primary key,
	id_livro integer,
	id_usuario integer,
	data_emprestimo date not null,
	data_devolucao date not null,
	
	constraint fk_livro foreign key(id_livro) references livro(id),
	constraint fk_usuario foreign key(id_usuario) references usuario(id),
	constraint chk_emprestimo_devolucao check (data_emprestimo <= data_devolucao),


	

  



);