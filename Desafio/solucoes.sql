drop materialized view if exists mv_driver_season_summary;

create materialized view mv_driver_season_summary as
select
    r.year as season_year,
    rd.driver_id,
    d.full_name,
    count(*) as total_races,
    count(CASE WHEN rd.position_number = 1 then 1 end) as wins,
    count(CASE WHEN rd.position_number <= 3 then 1 end) as podiums,
    count(CASE WHEN rd.race_reason_retired = IS NOT NULL then 1 end) as podiums,
    coalesce(sum(rd.race_points), 0) as total_points

from race_data rd
join race r on r.id = rd.race_id
join driver d on d.id = rd.driver_id
where rd.type = 'RACE_RESULT'
group by r.year, rd.driver_id, d.full_name;

create unique index idx_mv_driver_season_summary
on mv_driver_season_summary(season_year, driver_id);

refresh materialized view concurrently mv_driver_season_summary;

select * from mv_driver_season_summary
where driver_id = 'ayrton-senna'
order by season_year desc
limit 10;