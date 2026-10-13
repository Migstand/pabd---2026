create or replace function bloqueiar_remocao()
    returns trigger
    language plpgsql
as $$
begin
    if OLD.driver_id = driver.id then
        return OLD.name
    
    return OLD.id
end;

drop trigger if exists tg_bloquear_remocao;
create trigger tg_bloquear_remocao
before delete
each row
execute function bloqueiar_remocao();