SELECT
    s.*,
FROM
    pawximity.stg_trails_by_county s
    JOIN pawximity.utah_county_boundary_ugrc c ON s.county_id = c.ogc_fid
WHERE
    s.county_name = 'SALT LAKE';

-- pawximity.trails_salt_lake_clipped definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.trails_salt_lake_clipped;
CREATE MATERIALIZED VIEW pawximity.trails_salt_lake_clipped AS
SELECT
    s.trail_id,
    s.osm_id,
    s.trail_type,
    s.trail_name,
    s.has_tunnel,
    s.county_id,
    s.county_name,
    ST_Intersection (s.trail_geom, c.geom)::geometry(MultiLineString, 26912) AS clipped_trail_geom
FROM
    pawximity.stg_trails_by_county s
    JOIN pawximity.utah_county_boundary_ugrc c ON s.county_id = c.ogc_fid
WHERE
    s.county_name = 'SALT LAKE';

CREATE INDEX trails_salt_lake_clipped_geom_geom_idx ON pawximity.trails_salt_lake_clipped USING gist (clipped_trail_geom);

