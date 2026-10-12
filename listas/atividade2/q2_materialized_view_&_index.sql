-- drop materialized view if exists mv_category_total_sales;
-- create materialized view mv_category_total_sales as
-- select
--     c.name categoria,
--     re.total receita
-- from categoria c
-- join rental re on re.categoria_id = c.id
-- group by c.name, re.total;

-- drop index if exists idx_category_total;

-- create unique index idx_category_total on address (categoria)
-- Cria a Materialized View com o total de receita por categoria
drop materialized view if exists mv_category_total_sales;
create materialized view mv_category_total_sales as
select 
    c.name as category_name,
    coalesce(sum(p.amount), 0) as total_revenue
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by c.name;

-- Cria um índice ÚNICO obrigatório baseado no nome da categoria para permitir o REFRESH CONCURRENTLY
drop index if exists idx_mv_category_total_sales_name;
create unique index idx_mv_category_total_sales_name 
on mv_category_total_sales (category_name);

explain analyze
select * from mv_category_total_sales;
--refresh materialized view concurrently mv_category_total_sales;

-- Seq Scan on mv_category_total_sales  (cost=0.00..1.16 rows=16 width=100) (actual time=0.009..0.011 rows=16 loops=1)
--  Planning Time: 0.076 ms
--  Execution Time: 0.020 ms