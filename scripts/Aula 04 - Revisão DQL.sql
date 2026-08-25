select * from funcionario;

select pnome, unome, numero_departamento from funcionario;

select pnome, || ' ' || unome, numero_departamento from funcionario;

--alias
select pnome || ' ' || unome as 'Nome Completo', numero_departamento as 'Dep' from funcionario;
select pnome || ' ' || unome nome, numero_departamento dep from funcionario;

select all numero_departamento from funcionario;
-- Exibir valores distintos
select distinct numero_departamento from funcionario;

-- round: especifica casas decimais. só aceita NUMERIC
select pnome || ' ' || unome nome, salario, salario*0.11 inss from funcionario;

-- WHERE; filtro
select cpf, pnome, unome from funcionario
where endereco = 'Natal-RN';

select cpf, pnome, unome from funcionario
where numero_departamento=1 and salario>9000;

select cpf, pnome, unome from funcionario
where salario between

select cpf, pnome, unome from funcionario
where salario between 8000 and 10000;

select cpf, pnome, unome from funcionario
where salario not between 8000 and 10000;

-- %  substitui qualquer cadeia tetual
-- _: substitui um caractere

select cpf, pnome, unome from funcionario
where endereco like '%PI';

select cpf, pnome, unome from funcionario
where pnome like '%ana%'; -- Não

-- ilike: comparação desconsiderando case sensitive
select cpf, pnome, unome from funcionario
where endereco ilike '%pi';

select cpf, pnome, unome from funcionario
where endereco ilike '%R_';

-- tabela t: para exemplo de busca de caracteres especiais
CREATE TABLE t(
    message text
);
INSERT INTO t(message)
VALUES ('The rents are now 10% higher than last month'),
        ('The new film will have _ in the title');
SELECT message FROM t;

select * from t
where message like '%10%%' escape '$';

/*
    Aula 25/08
*/

-- order by, limit;
select pnome, unome from funcionario
order by pnome, unome asc;

select pnome, unome from funcionario
order by pnome desc, unome desc;

-- Maior salário
select pnome, unome, salario from funcionario
order by salario desc
limit 1;

-- funções de agregação: count, sum, avg, min, max
select count(*)TotalFuncionarios from funcionario;

select count(distinct numero_departamento) from funcionario;

select sum(salario) as "Folha Salarial" from funcionario;

select sum(salario) as "Folha Salarial Dep1" from funcionario
where numero_departamento = 1;

select avg(salario) media_salarial from funcionario; -- Media salarial

select round(avg(salario), 2) media_salarial from funcionario; --round(parâmetro do valor para arredondar, quantidade de casas decimais para arredondar)

select
    min(salario) menor_salario,
    max(salario) maior_salario
from funcionario;

-- Qual o nome do funcionario com o menor salário?
select pnome, unome from funcionario
where salario = (
    select min(salario) from funcionario
); --Subconsulta: colocar parênteses no WHERE

-- Qual o nome do funcionario com o menor salário?
select pnome, unome from funcionario
where salario > (
    select avg(salario) media_salarial from funcionario
);

/*
    Relatório completo: total de funcionários, folha salarial,
    média salarial, menor salário e maior salário
*/
select 
    count(*)total_funcionaris,
    sum(salario) folha_salarial,
    sum(salario)*0.11 folha_inss,
    round(avg(salario), 2) media_salarial,
    min(salario) menor_salario,
    max(salario) maior_salario
from funcionario;

-- exists, not exists

-- Junções: inner join, left join, right join, full join

-- Listar nome dos funcionários e seus respectivos nomes de departamentos
select
    f.pnome || ' ' || f.unome funcionario,
    d.nome departamento
from funcionario f
join departamento d
    on f.numero_departamento = d.numero
order by d.nome, f.pnome;

-- Listar todos os funcionários e seus respectivos supervisores
select
    f.pnome || ' ' || f.unome funcionario,
    s.pnome || ' ' || s.unome funcionario
from funcionario f
join funcionario s
    on f.cpf_supervisor = s.cpf
order by f.pnome, f.unome;

-- Listar todos os funcionários e seus respectivos supervisores, 
-- incluindo funcionários sem supervisor (NULL)
select
    f.pnome || ' ' || f.unome funcionario,
    s.pnome || ' ' || s.unome funcionario
from funcionario f
left join funcionario s
    on f.cpf_supervisor = s.cpf
order by f.pnome, f.unome;

-- Coalece: Se for nulo, coloque esse valor
select
    f.pnome || ' ' || f.unome funcionario,
    coalesce(s.pnome || ' ' || s.unome, 'Sem supervisor') supervisor
from funcionario f
left join funcionario s
    on f.cpf_supervisor = s.cpf
order by s.pnome nulls last, f.pnome, f.unome;

-- exists, not exists

-- Funções de agrupamento: group by, having