-- Cria a função que verifica se há filmes vinculados antes de excluir o idioma
create or replace function protect_language_deletion()
    returns trigger 
    language plpgsql
as $$
begin
    
    if exists (
        select 1 
        from film 
        where language_id = old.language_id
    ) then
        raise exception 'não é possível excluir o idioma "%" (id: %), pois ele está vinculado a um ou mais filmes no catálogo.', 
            old.name, old.language_id;
    end if;
    
    return old;
end
$$;

drop trigger if exists trg_protect_language_delete on language;

create trigger trg_protect_language_delete
before delete on language
for each row
execute function protect_language_deletion();

-- Teste
DELETE FROM language WHERE language_id = 1;