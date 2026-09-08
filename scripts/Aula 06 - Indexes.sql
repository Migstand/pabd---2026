-- INDEXES

-- Exibe esquema, índices e 
select 
    schemaname,
    tablename,
    indexname,
    indexdef
from pg_indexes
where tablename = 'address' -- Nome da tabela
order by tablename, indexname;

select
    address_id,
    address,
    district,
    phone
from address
where phone = '223664661973';

explain analyze
select
    address_id,
    address,
    district,
    phone
from address
where phone = '223664661973';

drop index if exists idx_address_phone;


create index idx_address_phone on address(phone); 