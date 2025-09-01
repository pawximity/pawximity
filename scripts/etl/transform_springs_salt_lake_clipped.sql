SELECT
    s.*
FROM
    pawximity.stg_springs_by_county s
    JOIN pawximity.utah_county_boundary_ugrc c ON s.county_id = c.ogc_fid
WHERE
    s.county_name = 'SALT LAKE';

-- pawximity.springs_salt_lake_clipped definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.springs_salt_lake_clipped;
CREATE MATERIALIZED VIEW pawximity.springs_salt_lake_clipped AS
SELECT
    s.spring_id,
    s.spring_type,
    s.spring_name,
    s.county_id,
    s.county_name,
    s.spring_geom
FROM
    pawximity.stg_springs_by_county s
    JOIN pawximity.utah_county_boundary_ugrc c ON ST_Intersects (s.spring_geom, c.geom)
WHERE
    s.county_name = 'SALT LAKE';

