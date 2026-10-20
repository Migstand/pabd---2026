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