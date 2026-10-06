drop view if exists v_staff_performance;
create view v_staff_performance as
select 
    sta.staff_id staff_id,
    sta.first_name pnome,
    sta.last_name unome,
    ci.city cidade,
    co.country pais,
    count(re.staff_id) locacoes,
    coalesce(sum(p.amount), 0) total_arrecadado
from staff sta
left join rental re on re.staff_id = sta.staff_id
left join address a on a.city_id = ci.city_id 
left join city ci on c.country_id = country.country_id
left join payment p on sta.staff_id = p.staff_id
group by sta.staff_id, sta.first_name, sta.last_name, c.;