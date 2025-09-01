SELECT
    t.*
FROM
    pawximity.stg_trails_by_county t
    JOIN pawximity.utah_county_boundary_ugrc c ON t.county_id = c.ogc_fid
WHERE
    t.county_name = 'SALT LAKE';

-- pawximity.trails_salt_lake_clipped definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.trails_salt_lake_clipped;
CREATE MATERIALIZED VIEW pawximity.trails_salt_lake_clipped AS
SELECT
    t.trail_id,
    t.osm_id,
    t.trail_type,
    t.trail_name,
    t.has_tunnel,
    t.county_id,
    t.county_name,
    ST_SetSRID (ST_Multi (ST_CollectionExtract (ST_Intersection (t.trail_geom, c.geom), 2)), 26912)::geometry(MultiLineString, 26912) AS clipped_trail_geom
FROM
    pawximity.stg_trails_by_county t
    JOIN pawximity.utah_county_boundary_ugrc c ON t.county_id = c.ogc_fid
WHERE
    t.county_name = 'SALT LAKE'
    AND NOT ST_IsEmpty (ST_Intersection (t.trail_geom, c.geom));

CREATE INDEX trails_salt_lake_clipped_geom_geom_idx ON pawximity.trails_salt_lake_clipped USING gist (clipped_trail_geom);

