drop table if exists customer_rental_stats;
CREATE TABLE customer_rental_stats (
    customer_id INTEGER PRIMARY KEY,
    total_rentals INTEGER NOT NULL DEFAULT 0
);

insert into customer_rental_stats (customer_id, total_rentals)
select 
    customer_id, 
    count(rental_id) as total_rentals
from rental
group by customer_id;

CREATE OR REPLACE FUNCTION update_customer_rental_stats()
    RETURNS TRIGGER 
     LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE customer_rental_stats
    SET total_rentals = total_rentals + 1
    WHERE customer_id = NEW.customer_id;
    
    IF NOT FOUND THEN
        INSERT INTO customer_rental_stats (customer_id, total_rentals)
        VALUES (NEW.customer_id, 1);
    END IF;

    RETURN NEW;
END
$$;

DROP TRIGGER IF EXISTS trg_update_customer_rental_stats ON rental;

CREATE TRIGGER trg_update_customer_rental_stats
AFTER INSERT ON rental
FOR EACH ROW
EXECUTE FUNCTION update_customer_rental_stats();

-- Verifica o total atual de um cliente
SELECT * FROM customer_rental_stats WHERE customer_id = 1;

-- Insire uma nova locação para esse mesmo cliente
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_TIMESTAMP, 1, 1, NULL, 1);

SELECT * FROM customer_rental_stats WHERE customer_id = 1;