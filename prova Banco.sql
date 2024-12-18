<<<<<<< HEAD
-- Database: PROVA DADOS 12-12
=======
--Avaliacao Banco
>>>>>>> b28c7f119d75b41179cf69f705a8d9f5f57264b8


CREATE TABLE IF NOT EXISTS CLIENTE(
ID SERIAL PRIMARY KEY,
NOME VARCHAR (100) NOT NULL,
EMAIL VARCHAR(100) NOT NULL UNIQUE,
TELEFONE VARCHAR (20) NOT NULL UNIQUE,
DATA_CADASTRO DATE NOT NULL,
DATA_CADASTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP


);



CREATE TABLE IF NOT EXISTS TECNICO(
ID SERIAL PRIMARY KEY,
NOME VARCHAR (100) NOT NULL,
ESPECIALIDADE VARCHAR(50) NOT NULL,
TELEFONE VARCHAR (20) NOT NULL UNIQUE,
DATA_CONTRATACAO DATE NOT NULL 


);





CREATE TABLE IF NOT EXISTS SERVICO(
ID SERIAL PRIMARY KEY,
NOME VARCHAR (100) NOT NULL,
DESCRICAO TEXT NOT NULL,
PRECO DECIMAL (10,2) NOT NULL,
TIPO_SERVICO VARCHAR NOT NULL



);




CREATE TABLE IF NOT EXISTS CHAMADO(
ID SERIAL PRIMARY KEY,
<<<<<<< HEAD
CLIENTE_ID INT ,
TECNICO_ID INT ,
SERVICO_ID INT ,
=======
CLIENTE_ID INT ON DELETE CASCADE,
TECNICO_ID INT ON DELETE CASCADE,
SERVICO_ID INT ON DELETE CASCADE,
DATA_CHAMADO DATA PADRAO CURRENT_DATE,
STATUS VARCHAR(20) NOT NULL,
>>>>>>> b28c7f119d75b41179cf69f705a8d9f5f57264b8
DATA_CHAMADO DATE NOT NULL,
STATUS VARCHAR(100) NOT NULL,
DESCRICAO TEXT NOT NULL,

CONSTRAINT FK_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTE(ID) ON DELETE CASCADE,
CONSTRAINT FK_TECNICO FOREIGN KEY (TECNICO_ID) REFERENCES TECNICO(ID)ON DELETE CASCADE,
CONSTRAINT FK_SERVICO FOREIGN KEY (SERVICO_ID) REFERENCES SERVICO(ID) ON DELETE CASCADE

);


CREATE TABLE IF NOT EXISTS PAGAMENTO(
ID SERIAL PRIMARY KEY,
CLIENTE_ID INT,
CHAMADO_ID INT ,
VALOR_PAGO DECIMAL (10,2) NOT NULL,
DATA_PAGAMENTO DATE NOT NULL,
FORMA_PAGAMENTO VARCHAR (50) NOT NULL,


CONSTRAINT FK_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTE(ID) ON DELETE CASCADE


);


ALTER TABLE CHAMADO ADD
CONSTRAINT STATUS_SERVICO CHECK(STATUS IN('PENDENTE', 'EM ANDAMENTO' , ' FINALIZADO'));

<<<<<<< HEAD
INSERT INTO CLIENTE ( NOME, EMAIL, TELEFONE, DATA_CADASTRO)
VALUES ('JOÂO SILVA', 'joao@email.com', '(11) 987565-4321','2023-01-15'),
 ('Maria Oliveira','maria@email.com','(21) 99654-321', '2023-02-20'),
 ('Pedro Souza', 'pedro@email.com', '(31) 99765-1234', '2023-03-10'),
 ('Ana Costa','ana@email.com','(41) 98888-9999','2023-04-25'),
 ('Lucas Almeida','lucas@email.com', '(61) 99123-4567','2023-05-30');


INSERT INTO SERVICO ( NOME, DESCRICAO, PRECO, TIPO_SERVICO)
VALUES ('Consultoria em TI', 'Consultoria especializada em infraestrutura de TI', 500.00, ' CONSULTORIA' ),
 ('Manutenção de Equipamentos','Manutenção preventiva e corretiva de equipamentos',300.00,'Manutenção'),
 ('Suporte Técnico', 'Suporte remoto e presencial para empresa', 200.00, 'Suporte');


INSERT INTO CHAMADO(CLIENTE_ID, TECNICO_ID, SERVICO_ID,DATA_CHAMADO, STATUS,DESCRICAO)
VALUES (1,1,1,'2023-06-01','ABERTO','Fiação da casa queimada'),
(2,2,2, '2023-07-10','em andamento','Vazamento na tubulação'),
(3,3,'2023-08-05','CONCLUIDO','Reparação no ar-condicionado'),
(4,1,2,'2023-09-20','aberto','Manutenção no servidor'),
(5,2,1,'2023-10-15','concluído','Suporte para software');



INSERT INTO PAGAMENTO(CLIENTE_ID,CHAMADO_ID,VALOR_PAGO,DATA_PAGAMENTO,FORMA_PAGAMENTO)
values
(1,1,350.00,'2023-06-15','CRÉDITO'),
(2,2,450.00,'2023-07-15','CRÉDITO'),
(2,4,600.00,'2023-07-10','CRÉDITO'),
(4,4,300.00,'2023-09-25','CRÉDITO');
=======
INSERT INTO CLIENTE (ID, NOME, EMAIL, TELEFONE, DATA_CADASTRO)
VALUES (1,'JOÂO SILVA', 'joao@email.com', '(11) 987565-4321',2023-01-15),
(2,'Maria Oliveira','maria@email.com','(21) 99654-321', 2023-02-20),
(3,'Pedro Souza', 'pedro@email.com', '(31) 99765-1234', 2023-03-10),
(4,'Ana Costa','ana@email.com','(41) 98888-9999',2023-04-25),
(5,'Lucas Almeida','lucas@email.com', '(61) 99123-4567',2023-05-30);


INSERT INTO SERVICO (ID, NOME, DESCRICAO, PRECO, TIPO_SERVICO)
VALUES (1,'Consultoria em TI', 'Consultoria especializada em infraestrutura de TI', 500.00, ' CONSULTORIA' ),
 (2,'Manutenção de Equipamentos','Manutenção preventiva e corretiva de equipamentos',300.00,'Manutenção'),
(3,'Suporte Técnico', 'Suporte remoto e presencial para empresa', 200.00, 'Suporte');

INSERT INTO TECNICO (NOME,ESPECIALIDADE, TELEFONE, DATA_CONTRATACAO)
VALUES('Carlos Oliveira', 'Consultoria em TI','(84) 9876-3456', '2022-10-10'),
('Fernanda Souza', 'Manutencao','(84) 9345=4567','2021-06-15'),
('Roberto Costa', 'Suporte Tecnico','(85) 9234=5479'. '2020-08-20');


INSERT INTO CHAMADO(CLIENTE_ID, TECNICO_ID, SERVICO_ID,DATA_CHAMADO, STATUS, DESCRICAO)
VALUES (1,1,1,2023-06-01,'ABERTO','Fiação da casa queimada'),
(2,2,2,2023-07-10,'em andamento','Vazamento na tubulação'),
(3,3,3,2023-08-05,'CONCLUIDO','Reparação no ar-condicionado'),
(4,4,1,2,2023-09-20,'aberto','Manutenção no servidor'),
(5,5,2,1,2023-10-15,'concluído','Suporte para software');


INSERT INTO PAGAMENTO(CLIENTE_ID,CHAMADO_ID,VALOR_PAGO,DATA_PAGAMENTO)
VALUES(1,1,1.350.00,'2023-06-15'),
(2,2,2,450.00,'2023-07-15', 'Crédito'),
(3,2,4,600.00,'2023-07-10','Crédito'),
(4,4,4,300.00,'2023-09-25','Crédito');
>>>>>>> b28c7f119d75b41179cf69f705a8d9f5f57264b8


--01
SELECT NOME, EMAIL FROM CLIENTE;
--02
SELECT NOME_SERVICO, PRECO FROM SERVICO;
--03
SELECT NOME_TECNICO, ESPECIALIDADE FROM TECNICO;
--04
SELECT DESCRICAO, STATUS FROM CHAMADO;
--05
SELECT VALOR_PAGO, DATA_PAGAMENTO FROM PAGAMENTO;
--06
SELECT CLIENTE.NOME, CHAMADO.DESCRICAO FROM JOIN CLIENTE ON
CHAMADO.ID_CLIENTE = CLIENTE.ID WHERE CHAMADO.STATUS = PENDENTE
--07
SELECT tecnicos.nome_tecnico FROM servicos 
JOIN tecnicos ON servicos.id_tecnico = tecnicos.id WHERE servicos.tipo = 'Manutenção'

--11
SELECT cliente.nome, valor_pago
FROM cliente 
JOIN pagamento on cliente_id = pagamento.id
WHERE (valor_pago > 0)

--12
SELECT cliente.nome, servico.nome, servico.descricao, servico.preco, servico.tipo_servico
FROM cliente
JOIN servico on cliente.id = servico.id

--13
SELECT tecnico.nome, servico.preco, servico.nome
FROM tecnico, servico
WHERE (servico.preco > 400)

--14
SELECT * FROM servico
UPDATE servico
SET preco = 350
WHERE tipo_servico = 'Manutenção' AND preco < 350;
SELECT * FROM servico

--15
SELECT * FROM tecnico
WHERE id NOT IN (SELECT DISTINCT tecnico_id FROM chamado);
SELECT * FROM TECNICO
SELECT * FROM CHAMADO
<<<<<<< HEAD





=======
>>>>>>> b28c7f119d75b41179cf69f705a8d9f5f57264b8
