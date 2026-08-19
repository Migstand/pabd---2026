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