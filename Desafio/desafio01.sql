drop materialized view if exists mv_driver_season_summary;
create materialized view mv_driver_season_summary as 
select 
    r.year ano,
    d.name piloto,
    COUNT(rd.driver_id) races,
    d.total_race_wins vitorias,
    d.total_podiums podios,
    count(CASE WHEN race_reason_retired IS NOT NULL) abandonos,
    d.total_points pontos

from driver d
join race_data rd on rd.driver_id = d.id
join race r on r.id = rd.race_id
group by ano, piloto, races, vitorias, podios, abandonos;

select *
from mv_driver_season_summary;
