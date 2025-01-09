
-- Início da transação para criar as tabelas
BEGIN;

-- Criação da tabela cliente
create table if not exists cliente( 
    id serial primary key,
    nome varchar(100) not null,
    cpf varchar(11) unique not null,
    email varchar(100) unique,
    telefone varchar(20),
    data_cadastro date not null default current_date
);

-- Criação da tabela produto
create table if not exists produto(
    id serial primary key,
    nome varchar(100) not null,
    descricao text,
    preco decimal(10,2) not null,
    data_cadastro date not null default current_date,
    constraint preco_maior_zero check (preco > 0)
);

-- Criação da tabela funcionario
create table if not exists funcionario(
    id serial primary key,
    nome varchar(100) not null,
    cpf varchar(11) unique not null,
    cargo varchar(120) not null,
    salario decimal(10,2) not null,
    email varchar(100) unique,
    constraint salario_maior_zero check (salario > 0),
    date_contracao date not null default current_date
);

-- Criação da tabela venda
create table if not exists venda(
    id serial primary key,
    cliente_id int not null,
    funcionario_id int,
    data_venda date default current_date,
    total_venda decimal(10,2) not null,
    constraint total_venda_maior_zero check (total_venda > 0),
    constraint fk_cliente foreign key (cliente_id) references cliente(id) on delete cascade,
    constraint fk_funcionario foreign key (funcionario_id) references funcionario(id) on delete set null
);

-- Criação da tabela itens_venda
create table if not exists itens_venda(
    id serial primary key,
    venda_id int,
    produto_id int,
    quantidade_itens integer not null,
    preco_unitario decimal(10,2) not null,
    subtotal decimal(10,2) not null,
    constraint fk_venda foreign key (venda_id) references venda(id) on delete cascade,
    constraint fk_produto foreign key (produto_id) references produto(id) on delete cascade,
    constraint quantidade_maior_zero check (quantidade_itens > 0),
    constraint preco_unitario_maior_zero check (preco_unitario > 0)
);

-- Se todas as operações forem bem-sucedidas, confirme a transação
COMMIT;

-- Caso algum erro aconteça em qualquer parte do processo, reverte as mudanças
-- ROLLBACK;

-- Início da transação para criar os registros nas tabelas
BEGIN;

-- Inserção de 5 registros de exemplo na tabela cliente
insert into cliente (nome, cpf, email, telefone) values
('João Silva', '12345678901', 'joao@exemplo.com', '11987654321'),
('Maria Oliveira', '23456789012', 'maria@exemplo.com', '11976543210'),
('Pedro Costa', '34567890123', 'pedro@exemplo.com', '11965432109'),
('Ana Santos', '45678901234', 'ana@exemplo.com', '11954321098'),
('Carlos Souza', '56789012345', 'carlos@exemplo.com', '11943210987');

-- Inserção de 5 registros de exemplo na tabela produto
insert into produto (nome, descricao, preco) values
('Notebook', 'Notebook 15 polegadas', 3500.00),
('Smartphone', 'Smartphone Android 6GB RAM', 1500.00),
('Cadeira Escritório', 'Cadeira ergonômica', 700.00),
('Teclado Mecânico', 'Teclado mecânico RGB', 300.00),
('Mouse', 'Mouse óptico sem fio', 80.00);

-- Inserção de 5 registros de exemplo na tabela funcionario
insert into funcionario (nome, cpf, cargo, salario, email) values
('Roberta Lima', '67890123456', 'Gerente', 5000.00, 'roberta@empresa.com'),
('Felipe Almeida', '78901234567', 'Vendedor', 3000.00, 'felipe@empresa.com'),
('Luciana Pereira', '89012345678', 'Assistente Administrativo', 2500.00, 'luciana@empresa.com'),
('Marcos Silva', '90123456789', 'Analista de TI', 4000.00, 'marcos@empresa.com'),
('Juliana Costa', '01234567890', 'Supervisor', 4500.00, 'juliana@empresa.com');

-- Inserção de 5 registros de exemplo na tabela venda
insert into venda (cliente_id, funcionario_id, total_venda) values
(1, 2, 4000.00),
(2, 3, 1500.00),
(3, 4, 3000.00),
(4, 5, 2200.00),
(5, 1, 5000.00);

-- Inserção de 5 registros de exemplo na tabela itens_venda
insert into itens_venda (venda_id, produto_id, quantidade_itens, preco_unitario, subtotal) values
(1, 1, 2, 3500.00, 7000.00),
(1, 2, 1, 1500.00, 1500.00),
(2, 3, 1, 700.00, 700.00),
(3, 4, 1, 300.00, 300.00),
(4, 5, 3, 80.00, 240.00);

-- Se todas as operações forem bem-sucedidas, confirme a transação
COMMIT;

-- Caso algum erro aconteça em qualquer parte do processo, reverte as mudanças
-- ROLLBACK;

-- Consultas as tabelas
SELECT * FROM cliente;
SELECT * FROM produto;
SELECT * FROM funcionario;
SELECT * FROM venda;
SELECT * FROM itens_venda;



-- 1. Listar total de vendas por cada cliente
SELECT cliente.nome, COUNT(venda.cliente_id) AS total_vendas
FROM venda
JOIN cliente ON venda.cliente_id = cliente.id
GROUP BY cliente.nome
ORDER BY cliente.nome ASC;

-- 2. Listar total de vendas por funcionário
SELECT funcionario.nome, COUNT(venda.funcionario_id) AS total_vendas
FROM venda
JOIN funcionario ON venda.funcionario_id = funcionario.id
GROUP BY funcionario.nome
ORDER BY funcionario.nome ASC;

-- 3. Listar a quantidade total de produtos vendidos por cada venda
SELECT venda.id AS venda_id, SUM(itens_venda.quantidade_itens) AS total_produtos
FROM itens_venda
JOIN venda ON itens_venda.venda_id = venda.id
GROUP BY venda.id
ORDER BY venda_id;

-- 4. Listar a quantidade total de itens vendidos por produto
SELECT produto.nome, SUM(itens_venda.quantidade_itens) AS total_itens_vendidos
FROM itens_venda
JOIN produto ON itens_venda.produto_id = produto.id
GROUP BY produto.nome
ORDER BY total_itens_vendidos DESC;

-- 5. Listar os clientes que realizaram mais de 5 compras
SELECT cliente.nome, COUNT(venda.id) AS total_compras
FROM venda
JOIN cliente ON venda.cliente_id = cliente.id
GROUP BY cliente.nome
HAVING COUNT(venda.id) > 5
ORDER BY total_compras DESC;

-- 6. Listar os produtos que possuem mais de 50 unidades em estoque
-- Alteração para adicionar coluna de estoque na tabela produto
ALTER TABLE produto ADD COLUMN estoque integer NOT NULL DEFAULT 0;
SELECT nome, estoque
FROM produto
WHERE estoque > 50
ORDER BY nome;

-- 7. Listar os funcionários que participaram de mais de 10 vendas
SELECT funcionario.nome, COUNT(venda.id) AS total_vendas
FROM venda
JOIN funcionario ON venda.funcionario_id = funcionario.id
GROUP BY funcionario.nome
HAVING COUNT(venda.id) > 10
ORDER BY total_vendas DESC;

-- 8. Listar os produtos que venderam mais de 100 unidades
SELECT produto.nome, SUM(itens_venda.quantidade_itens) AS total_vendido
FROM itens_venda
JOIN produto ON itens_venda.produto_id = produto.id
GROUP BY produto.nome
HAVING SUM(itens_venda.quantidade_itens) > 100
ORDER BY total_vendido DESC;

-- 9. Calcular o valor total das vendas de cada cliente
SELECT cliente.nome, SUM(venda.total_venda) AS total_gasto
FROM venda
JOIN cliente ON venda.cliente_id = cliente.id
GROUP BY cliente.nome
ORDER BY total_gasto DESC;

-- 10. Calcular o valor total das vendas realizadas por cada funcionário
SELECT funcionario.nome, SUM(venda.total_venda) AS total_vendas_funcionario
FROM venda
JOIN funcionario ON venda.funcionario_id = funcionario.id
GROUP BY funcionario.nome
ORDER BY total_vendas_funcionario DESC;

-- 11. Calcular o total de itens vendidos por venda
SELECT venda.id AS venda_id, SUM(itens_venda.quantidade_itens) AS total_itens_vendidos
FROM itens_venda
JOIN venda ON itens_venda.venda_id = venda.id
GROUP BY venda.id
ORDER BY venda_id;

-- 12. Calcular o total de produtos vendidos agrupados por categoria (após adicionar coluna categoria na tabela produto)
ALTER TABLE produto ADD COLUMN categoria varchar(50);  -- Adiciona a coluna categoria à tabela produto
SELECT produto.categoria, SUM(itens_venda.quantidade_itens) AS total_produtos_vendidos
FROM itens_venda
JOIN produto ON itens_venda.produto_id = produto.id
GROUP BY produto.categoria
ORDER BY total_produtos_vendidos DESC;

-- add eletronicos
select * from produto
update produto 
set categoria = 'Eletrônico'
where id in (1,2)
-- add cadeiras
update produto 
set categoria = 'Cadeiras'
where id in (3)
-- add acessorios
update produto 
set categoria = 'Acessórios'
where id in (4,5)
select * from produto;

--13 calcule o total arrecadado com vendas para cada cliente
select cliente.nome , sum (venda.total_venda) as total_arrecadado 
from venda 
join cliente on venda.cliente_id = cliente.id
group by cliente.nome
order by total_arrecadado desc;

--14 calcule a media dos produtos em estoque
select avg (preco) as preco_medio
from produto
where estoque > 0;

--15 calcular preco medio dos produtos vendidos por venda
select venda.id as venda_id, round(avg(itens_venda.preco_unitario),2)
as preco_medio_produtos_vendidos
from itens_venda
join venda on itens_venda.venda_id = venda.id
group by venda.id
order by venda_id;

--16 calcule a media de salarios dos fucionarios 
select round(avg(salario),2) as salario_medio_funcionario
from funcionario;

--17 calcule a media do total 
