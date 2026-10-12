-- Index de procura
drop index if exists idx_rental_pending;
create index idx_rental_pending 
on rental (rental_id) 
where return_date is null;

-- Analize de desempenho
explain analyze 
select rental_id, rental_date, customer_id, inventory_id 
from rental 
where return_date is null;

-- Com index
--                                                            QUERY PLAN                                                            
-- ---------------------------------------------------------------------------------------------------------------------------------
--  Index Scan using idx_rental_pending on rental  (cost=0.14..16.23 rows=183 width=18) (actual time=0.031..0.642 rows=183 loops=1)
--  Planning Time: 0.299 ms
--  Execution Time: 0.664 ms

-- Sem index
--                                               QUERY PLAN                                               
-- -------------------------------------------------------------------------------------------------------
--  Seq Scan on rental  (cost=0.00..310.44 rows=183 width=18) (actual time=0.685..1.067 rows=183 loops=1)
--    Filter: (return_date IS NULL)
--    Rows Removed by Filter: 15861
--  Planning Time: 0.098 ms
--  Execution Time: 1.085 ms

