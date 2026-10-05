drop view if exists v_staff_performance;
create view v_staff_performance as
select 
    sta.id staff_id,
    sta.name funcionario,
    sto.city cidade,
    sto.address endereco,
    count(re.staff_id) locacoes,
    coalesce(sum(p.total), 0) total_arrecadado
from staff sta
left join rental re on sta.id = re.staff_id
left join payment p on sta.id = p.staff_id
group by sta.id, sta.name;