-- Indexe
drop index if exists idx_payment_customer_date;
create index idx_customer_email_lower 
on customer (lower(email));

explain analyze 
select customer_id, first_name, last_name, email 
from customer 
where lower(email) = lower('mary.smith@sakilacustomer.org');

-- Com indexe
--                                                            QUERY PLAN                                                            
-- ---------------------------------------------------------------------------------------------------------------------------------
--  Bitmap Heap Scan on customer  (cost=4.30..11.15 rows=3 width=49) (actual time=0.026..0.027 rows=1 loops=1)
--    Recheck Cond: (lower((email)::text) = 'mary.smith@sakilacustomer.org'::text)
--    Heap Blocks: exact=1
--    ->  Bitmap Index Scan on idx_customer_email_lower  (cost=0.00..4.30 rows=3 width=0) (actual time=0.023..0.023 rows=1 loops=1)
--          Index Cond: (lower((email)::text) = 'mary.smith@sakilacustomer.org'::text)
--  Planning Time: 0.160 ms
--  Execution Time: 0.040 ms
-- (7 rows)