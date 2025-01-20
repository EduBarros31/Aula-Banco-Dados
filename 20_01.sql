-- procedimetos = procedures
create  or replace procedure inserir_novo_autor(
   nome varchar,
   nacionalidade varchar,
   data_nascimento date
   
)
language sql
as $$
insert into autor(nome, nacionalidade, data_nascimento) 
values (nome, nacionalidade, data_nascimento)
$$;
call inserir_novo_autor('Nome','Br', '1980-11-11')

-- criar nova categoria

create or replace procedure inserir_nova_categoria(
nome varchar,
descricao text

)
language sql as $$
insert into categoria(nome, descricao)
values(nome, descricao)
$$;
call inserir_nova_categoria('nome', 'descricao')

call inserir_nova_categoria('categoria', ' Descricao categoria')


select * from categoria;

--functions - 
create or replace procedure update_telefone_unidade(
id integer , 
telefone varchar
)

language sql
as $$

update unidade 
set  telefone = telefone
where id = id;


$$;

select * from unidade


update unidade 
set  telefone = '4005-2200'
where id = 4 ;

--criar procedure para atulaizar nomde de usuario pelo id
create or replace procedure atualizar_nome_usuario(
id_usuario integer ,
nome_usuario varchar

)
language sql
as $$

update usuario 
set nome =  nome_usuario
where id = id_usuario;

$$;
 call atualizar_nome_usuario(1, 'EDu Barros');

select * from usuario;

