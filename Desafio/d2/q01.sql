-- Questão 1
begin;

-- CERTO
insert into customer(store_id, first_name, last_name, email, address_id, active)
values(1, 'Miguel', 'da Hora', 'mig@gmail.com', 1, 20);

-- VERIFICACAO: select * from customer where first_name = 'Miguel';
-- ERRADO: "address_id == null"
insert into customer(store_id, first_name, last_name, email, active)
values(9999, 'Errinho', '.com', 'err@gmail.com', 20);

--rollback;
commit; -- Vai acontecer rollback de qualquer forma;

-- RESPOSTA:
--  Não. O banco deve esquecer os dados "salvos" devido a regra da atomicidade dos dados: 
-- Caso aconteça qualquer erro na transação, ela deve ser bloqueada e sofrer um rollback;