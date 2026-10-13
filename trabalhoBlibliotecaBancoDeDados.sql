create database biblioteca;
use biblioteca;
create table Leitores(
	id_leitor int primary key,
    nome varchar(100) not null,
    telefone varchar(20) 
);

create table livros (
	id_livro int primary key,
    titulo varchar(255) not null,
    autor varchar(255)
);

create table exemplares(
	id_exemplar int primary key,
    id_livro int,
    disponivel boolean,
    foreign key (id_livro) references livros(id_livro)
);

create table emprestimos(
	id_emprestimo int primary key,
    id_leitor int,
    id_exemplar int,
    data_emprestimo date,
    data_devolução_programada date,
    data_devolução_real date,
    foreign key (id_leitor) references leitores(id_leitor),
    foreign key (id_exemplar) references exemplares(id_exemplar)
);

show tables;

insert into Leitores (id_leitor, nome, telefone) values
(1001, 'Ana Beatriz Souza',    '(81) 98888-1111'),
(1002, 'Carlos Eduardo Lima',  '(81) 97777-2222'),
(1003, 'Mariana Ferreira',     '(81) 99666-3333'),
(1004, 'João Pedro Alves',     '(81) 98555-4444'),
(1005, 'Fernanda Oliveira',    '(81) 97444-5555'),
(1006, 'Lucas Gabriel Santos', NULL);

insert into livros (id_livro, titulo, autor) values
(2001, 'Dom Casmurro',                       'Machado de Assis'),
(2002, 'Memórias Póstumas de Brás Cubas',    'Machado de Assis'),
(2003, 'Capitães da Areia',                  'Jorge Amado'),
(2004, 'Vidas Secas',                        'Graciliano Ramos'),
(2005, 'O Cortiço',                          'Aluísio Azevedo'),
(2006, 'A Hora da Estrela',                  'Clarice Lispector'),
(2007, 'Grande Sertão: Veredas',             'João Guimarães Rosa');

insert into exemplares (id_exemplar, id_livro, disponivel) values
(3001, 2001, false),
(3002, 2001, true),
(3003, 2002, true),
(3004, 2003, false),
(3005, 2003, true),
(3006, 2004, true),
(3007, 2004, false),
(3008, 2005, true),
(3009, 2006, false),
(3010, 2007, true);

insert into emprestimos
(id_emprestimo, id_leitor, id_exemplar, data_emprestimo, data_devolução_programada, data_devolução_real) values
(4001, 1001, 3003, '2026-08-01', '2026-08-15', '2026-08-14'),
(4002, 1002, 3006, '2026-08-05', '2026-08-19', '2026-08-25'),
(4003, 1003, 3008, '2026-09-01', '2026-09-15', '2026-09-13'),
(4004, 1001, 3001, '2026-09-28', '2026-10-12', NULL),
(4005, 1004, 3004, '2026-09-30', '2026-10-14', NULL),
(4006, 1005, 3007, '2026-10-02', '2026-10-16', NULL),
(4007, 1003, 3009, '2026-10-05', '2026-10-19', NULL);

select * from leitores;
select nome, telefone from leitores;
select COUNT(*) as total_livros from livros;

select * from livros;
select titulo, autor from livros;
select titulo, autor
from livros
where autor = 'Machado de Assis';

select * from exemplares;
select id_exemplar, id_livro
from exemplares
where disponivel = false;


select * from emprestimos;
select MIN(data_emprestimo) as primeiro,
       MAX(data_emprestimo) as ultimo
from emprestimos;

select id_leitor, COUNT(*) as total_emprestimos
from emprestimos
group by id_leitor;

select l.nome, e.id_emprestimo, e.data_emprestimo
from emprestimos e
join leitores l on e.id_leitor = l.id_leitor;

select l.nome as leitor,
       li.titulo as livro,
       e.data_emprestimo as emprestimo,
       e.data_devolução_programada as devolução
from emprestimos e
join leitores l   on e.id_leitor = l.id_leitor
join exemplares x on e.id_exemplar = x.id_exemplar
join livros li    on x.id_livro = li.id_livro;