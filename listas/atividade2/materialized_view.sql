drop materialized view if exists mv_category_total_sales;
create materialized view mv_category_total_sales as
select
    c.name categoria,
    re.total receita
from categoria c
join rental re on re.categoria_id = c.id
group by c.name, re.total;

drop index if exists idx_category_total;

create unique index idx_category_total on address (categoria)
