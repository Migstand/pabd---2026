-- Questão 3

insert into inventory(film_id, store_id, last_update)
values (3, 10, '2026-10-26');

-- select * from inventory where last_update = '2026-10-26';

-- Concorrência A:
begin;

-- Primeiro:
update inventory(store_id)
values (11);

-- Segundo:
delete from inventory where inventory_id = 4591;

commit;

-- Concorrência B:
begin;

-- Primeiro:
delete from inventory where inventory_id = 4591;

-- Segundo:
update inventory(store_id)
values (11);

commit;