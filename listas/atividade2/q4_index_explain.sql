-- Index
drop index if exists idx_film_description_fts;
create index idx_film_description_fts 
on film using gin (to_tsvector('english', description));

explain analyze 
select film_id, title, description 
from film 
where to_tsvector('english', description) @@ to_tsquery('english', 'documentary & drama');

-- Com index
--                                                             QUERY PLAN                                                            
-- ----------------------------------------------------------------------------------------------------------------------------------
--  Bitmap Heap Scan on film  (cost=12.96..17.22 rows=1 width=113) (actual time=0.039..0.040 rows=0 loops=1)
--    Recheck Cond: (to_tsvector('english'::regconfig, description) @@ '''documentari'' & ''drama'''::tsquery)
--    ->  Bitmap Index Scan on idx_film_description_fts  (cost=0.00..12.96 rows=1 width=0) (actual time=0.037..0.038 rows=0 loops=1)
--          Index Cond: (to_tsvector('english'::regconfig, description) @@ '''documentari'' & ''drama'''::tsquery)
--  Planning Time: 0.287 ms
--  Execution Time: 0.061 ms
-- (6 rows)

-- Sem index
--                                              QUERY PLAN                                              
-- ------------------------------------------------------------------------------------------------------
--  Seq Scan on film  (cost=0.00..350.50 rows=1 width=113) (actual time=241.758..241.759 rows=0 loops=1)
--    Filter: (to_tsvector('english'::regconfig, description) @@ '''documentari'' & ''drama'''::tsquery)
--    Rows Removed by Filter: 1000
--  Planning Time: 228.931 ms
--  Execution Time: 241.781 ms
-- (5 rows)

