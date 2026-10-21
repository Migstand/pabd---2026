/*
    Aula 08 - TRANSACTIONS
*/

-- !!! begin; -- Aceita tudo que está em cima !!!
-- !!! commit; --rollback; -- Volta para a transação !!!

-- Verificando ID da instância 

-- ==================================================
-- Exemplo 1 - Aluguel com sucesso
-- ==================================================

begin;

-- Rental
insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (now(), 1, 1, 1);

select * from rental order by rental_id desc limit 5;

-- Payment
insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
values (1, 1, currval('rental_rental_id_seq'), 4.99, now());

select payment_id, rental_id, amount from payment order by payment_id desc limit 5;

commit;

-- ==================================================
-- Exemplo 2 - Simular uma falha
-- ==================================================
begin;

insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (now(), 1, 1, 1);

-- ERRO(customer_id  inexistente)
insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
values (99999, 1, currval('rental_rental_id_seq'), 4.99, now());

commit;

-- ==================================================
-- Exemplo 3 - Testar DML em geral
-- ==================================================

begin;

insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (now(), 1, 1, 1),
(now(), 2, 2, 1),
(now(), 3, 2, 1);

select rental_id, rental_date from rental order by rental_id desc limit 5;

rollback;

select rental_id, rental_date from rental order by rental_id desc limit 5;

-- ==================================================
-- Exemplo 4 - SAVEPOINT
-- ==================================================

begin;
insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (now(), 1, 1, 1);

savepoint aluguel_criado;

insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
values (9999, 1, currval('rental_rental_id_seq'), 4.99, now());

select payment_id, rental_id, amount from payment order by payment_id desc limit 5;

rollback to aluguel_criado;

insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
values (1, 1, currval('rental_rental_id_seq'), 4.99, now());

commit; -- No exemplo, usei ROLLBACK para não atrapalhar os próximos exemplos

-- delete from rental where rental_date > "2009-01-01 00:00:00";

-- ==================================================
-- Exemplo 5 - Locação concorrente (ROW-LEVEL BLOCK)
-- ==================================================

begin;

select inventory_id from inventory where inventory_id = 1
for update;

-- Verificar disponibilidade do exemplar
do $$
begin
    if exists (
        select 1
        from rental
        where inventory_id = 1 and return_date is null
    ) then
        raise exception 'Exemplar indisponível T_T';
    end if;
end;
$$;

-- Copiar até aqui. Executar na sessão A e B
-- Verifique que a sessão B 

insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (now(), 1, 1, 1);

commit;