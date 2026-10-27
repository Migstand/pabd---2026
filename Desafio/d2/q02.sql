-- Questão 2
begin;

insert into inventory(film_id, store_id, last_update)
values (4, 10, '2026-10-20');

select * from inventory where last_update = '2026-10-20';
SAVEPOINT estoque_atualizado;

-- Certo:
insert into inventory(film_id, store_id, last_update)
values (120, 50, '2024-10-11');
select * from inventory where last_update = '2024-10-11';

-- Errado:
insert into inventory(film_id, store_id, last_update)
values (9999, 10, '2026-10-20');
rollback to estoque_atualizado;

commit;

-- RESPOSTA:
-- Ambos os registros. A principal vantagem em utilizar savepoints é que eles
-- facilitam na produtividade ao fazer transações, acelerando a produção dos códigos.