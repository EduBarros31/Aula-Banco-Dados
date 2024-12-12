create table if not exists GENERO(
ID SERIAL primary key,
NOME VARCHAR(50)not null UNIQUE
);

create table if not exists FILME(
ID SERIAL primary key,
NOME VARCHAR(60) not null unique, 
ID_GENERO INT not null,
constraint FK_GENERO foreign key(ID_GENERO) references GENERO(ID)
);
--questão 04
insert into GENERO (id, nome)
values (1, 'Animação'), (2,'Terror'), (3,'Ação'), (4,'Drama'), (5,'Comedia');
 --questão 05
insert into FILME(nome, id_genero)
values ('Batman', 3), ('The Battle of the Dark River', 3),
('White Duck', 1), ('Breaking Barriers', 4), ('The Two Hours', 2);

insert into GENERO (id, nome)
values (6,'Documentario'), (7, 'Suspense');

insert into FILME(nome, id_genero)
values ('Batman - o retorno', 3), ('Moana', 7),
('Pato Donald', 1), ('Hulk', 2), ('Tropa de Elite', 6);
--questão 06 LISTAR OS FILMES TERROR
select nome from filme where id_genero = (SELECT ID FROM GENERO WHERE NOME = 'Terror');
--questão 07 TRAZER OS FILMES HORROR OU DRAMA
select nome from filme where id_genero = (SELECT ID FROM GENERO WHERE NOME = 'Terror') 
or id_genero= (SELECT ID FROM GENERO WHERE NOME = 'Drama') ;




  
select * from genero ;
select * from FILME;
--questao 8
select from filme where nome LIKE '%t%';
-- ATUALIZAR 
UPDATE FILME
SET ID_GENERO=4
WHERE ID_GENERO=3;

select * from FILME

UPDATE FILME
   SET ID_GENERO = (SELECT ID FROM GENERO WHERE NOME='Ação')
   WHERE ID_GENERO = (SELECT ID FROM GENERO WHERE NOME='Drama');

select * from FILME
select * from genero



select filme.nome, GENERO.NOME  from filme, genero
WHERE ID_GENERO = GENERO.ID;
;

SELECT FILME.NOME AS NOME_DO_FILME , GENERO.NOME AS GENERO FROM FILME, GENERO
WHERE ID_GENERO =GENERO.ID ORDER BY FILME.NOME;

SELECT FILME.NOME AS FILME_NOME, GENERO.NOME AS GENERO_NOME
FROM FILME JOIN GENERO ON FILME.ID_GENERO = GENERO.ID ORDER BY FILME.NOME;

-- APAGAR CAMPO DA TABELA

DELETE  FROM FILME WHERE ID_GENERO =
(SELECT ID FROM GENERO WHERE NOME='Ação');


