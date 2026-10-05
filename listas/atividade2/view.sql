drop view if exists v_staff_performance;
create view v_staff_performance as
select 
    sta.staff_id staff_id,
    sta.nome funcionario,
    sto.city cidade,
    sto.address endereco,
    count(re.staff_id) locacoes,
    coalesce(sum(p.total), 0) total_arrecadado
from staff sta
left join rental re on re.staff_id = sta.staff_id 
left join payment p on sta.staff_id = p.staff_id
group by sta.staff_id, sta.nome;