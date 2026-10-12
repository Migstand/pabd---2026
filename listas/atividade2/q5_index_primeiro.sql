-- Indece
drop index if exists idx_payment_customer_date;
create index idx_payment_customer_date 
on payment (customer_id, payment_date desc);

explain analyze
SELECT * FROM payment 
WHERE customer_id = 1
ORDER BY payment_date DESC;

-- Explicação:
-- O motivo da primeira coluna ser o customer_id é por causa da b-tree do index 
-- que seleciona todos o dados relacionados ao usuário de maneira instantânea