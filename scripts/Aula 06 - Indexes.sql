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

explain analyze
select
    customer_id,
    first_name,
    last_name
from customer
where
    last_name = 'Purdy';

drop index if exists idx_customer_last_name;
create index idx_customer_last_name on customer(lower(last_name));

explain analyze
select
    customer_id,
    first_name,
    last_name
from customer
where
    lower(last_name) = 'purdy';

-- ÍNDICES PARCIAS

-- Indexando buscar por clientes inativos (active = 0)
drop index if exists idx_customer_active;
create index idx_customer_active on customer(active) where active = 0; -- Acelera a busca para esse caso

explain analyze
select
    customer_id,
    active
from
    customer
where
    active = 0; -- Predicado

where 
    column1 = v1
    AND column2 = v2;
    AND column3 = v3;

where
    column1 = v1
    AND column2 = v2;

where
    column1 = v1 

-- Executar script: \i utils/script_index_fts.sql

drop index if exists idx_people_names; 
create index idx_people_names on people(last_name, first_name);

explain analyze
select
    id,
    first_name,
    last_name
from 
    people
where
    last_name = 'Adams'
    and first_name = 'Lou';

-- O planejador opta por não utilizar o índece

explain analyze
select
    id,
    first_name,
    last_name
from 
    people
where
    first_name = 'Lou';

-- PRÁTICA

/*
    TO DO: CRIAÇÃO DE ÍNDECES - Esquema lista01

    - Baseado nas views (comando \dmv), quais índeces poderiam ser criados?
    - Para forçar o uso dos índeces em tabelas pequenas: SET enable_seqcan = off;

*/


select


from

where 
    -- 1) Busca título e corpo que conteham as palavras 'postgresql' E 'recursos'
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', 'postgres & recursos');
    -- 2) Busca título e corpo que conteham as palavras 'eficiente' OU 'recursos'
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', 'eficiente | recursos');
    -- 3) Busca título e corpo que conteha a frase "full-text search"
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', ''' full-text search ''');
    -- 4) Busca título e corpo que NÃO conteham aa palavra 'eficiente'
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', '!eficiente');
    -- 5) Busca título e corpo que com prefixo 'con'
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', 'con:*');

select 
    id,
    title,
    body,
    ts_rank(
        setweight(to_tsvector('portuguese', title), 'A') ||
        setweight(to_tsvector('portuguese', body), 'B'),
        to_tsquery('portuguese', 'postgresql')
    ) rank
from posts
where (
    setweight(to_tsvector('portuguese', title), 'A') ||
    setweight(to_tsvector('portuguese', body), 'B'),
    ) @@ to_tsquery('portuguese', 'postgresql')
