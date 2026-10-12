drop table if exists film_cost_audit;
create table film_cost_audit (
    audit_id serial primary key,
    film_id integer not null,
    old_cost numeric(5,2),
    new_cost numeric(5,2),
    changed_at timestamp default current_timestamp
);

create or replace function audit_film_replacement_cost()
    returns trigger 
    language plpgsql    
as $$
begin
    insert into film_cost_audit (film_id, old_cost, new_cost, changed_at)
    values (old.film_id, old.replacement_cost, new.replacement_cost, now());
    
    return new;
end
$$;

drop trigger if exists trg_film_cost_audit on film;

create trigger trg_film_cost_audit
after update on film
for each row
when (old.replacement_cost is distinct from new.replacement_cost)
execute function audit_film_replacement_cost();

-- Teste de atualização de preço em um filme
UPDATE film 
SET replacement_cost = 25.99 
WHERE film_id = 1;

-- Verificar o registro gerado na auditoria
SELECT * FROM film_cost_audit;