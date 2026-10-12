-- drop view if exists v_staff_performance;
-- create view v_staff_performance as
-- select 
--     sta.staff_id staff_id,
--     sta.first_name pnome,
--     sta.last_name unome,
--     ci.city cidade,
--     co.country pais,
--     count(re.staff_id) locacoes,
--     coalesce(sum(p.amount), 0) total_arrecadado
-- from staff sta
-- left join rental re on re.staff_id = sta.staff_id
-- left join address a on a.city_id = ci.city_id 
-- left join city ci on c.country_id = country.country_id
-- left join payment p on sta.staff_id = p.staff_id
-- group by sta.staff_id, sta.first_name, sta.last_name, c.;
drop view if exists v_staff_performance;
CREATE VIEW v_staff_performance AS
SELECT 
    s.staff_id,
    s.first_name || ' ' || s.last_name AS nome_completo,
    ci.city || ', '|| co.country AS endereco_loja,
    COALESCE(r_tot.total_locacoes, 0) AS total_locacoes,
    COALESCE(p_tot.valor_total_arrecadado, 0) AS valor_total_arrecadado
FROM staff s
JOIN store st ON s.store_id = st.store_id
JOIN address a ON st.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
LEFT JOIN (
    SELECT staff_id, COUNT(rental_id) AS total_locacoes
    FROM rental
    GROUP BY staff_id
) r_tot ON s.staff_id = r_tot.staff_id

LEFT JOIN (
    SELECT staff_id, SUM(amount) AS valor_total_arrecadado
    FROM payment
    GROUP BY staff_id
) p_tot ON s.staff_id = p_tot.staff_id;

select * from v_staff_performance;