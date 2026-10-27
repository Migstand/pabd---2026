-- Questão 3

insert into inventory(film_id, store_id, last_update)
values (3, 10, '2026-10-26');

-- select * from inventory where last_update = '2026-10-26';

-- Concorrência A:
begin;

-- Primeiro:
update inventory
set store_id = 1
where inventory_id = 4592; -- id do filme criado

-- Segundo:
delete from inventory where last_update = '2026-10-26'; --inventory_id = 4591; -- id do filme criado

commit;

-- Concorrência B:
begin;

-- Primeiro:
delete from inventory where last_update = '2026-10-26'; --inventory_id = 4591; -- id do filme criado

-- Segundo:
update inventory
set store_id = 1
where inventory_id = 4592; -- id do filme criado

commit;

-- Resposta:
-- No caso da concorrência A, se o update for executado primeiro, o delete terá que esperar o commit ou rollback para ser executado.
-- No caso da concorrência B, se o delete for executado primeiro, o update terá que esperar o commit ou rollback para ser executado.