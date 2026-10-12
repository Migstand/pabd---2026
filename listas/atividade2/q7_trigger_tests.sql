-- Function
create or replace function validate_rental_dates()
    returns trigger 
    language plpgsql
as $$
begin
    
    if new.return_date is not null and new.return_date < new.rental_date then
        raise exception 'erro de validação: a data de devolução (%) não pode ser anterior à data de locação (%).', 
            new.return_date, new.rental_date;
    end if;
    
    return new;
end
$$;

-- Trigger
drop trigger if exists trg_validate_rental_dates on rental;

create trigger trg_validate_rental_dates
before insert or update on rental
for each row
execute function validate_rental_dates();

-- Teste de Falha 
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES ('2026-06-10 14:00:00', 1, 1, '2026-06-05 14:00:00', 1);

-- Teste de Sucesso 
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES ('2026-06-10 14:00:00', 1, 1, '2026-06-15 14:00:00', 1);