DROP TABLE IF EXISTS points_adjustment_audit;
CREATE TABLE points_adjustment_audit (
    id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    driver_id  VARCHAR(100) NOT NULL,
    old_points DECIMAL(8,2),
    new_points DECIMAL(8,2),
    changed_at TIMESTAMPTZ DEFAULT NOW()
);

create or replace function altaracoes()
    returns trigger
    language plpgsql
as $$;
begin
    insert into points_adjustment_audit
        year, 
        old_points,
        new_points

        values(NEW.driver_id, 
            OLD.points,
            NEW.points,
        );
    
    return NEW

end;


drop trigger if exists tg_season_driver_standing;

create trigger tg_season_driver_standing
after insert
each row
execute altaracoes();


select * from points_adjustment_audit;