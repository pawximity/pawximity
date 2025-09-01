SELECT
    t.id AS trail_id,
    t.osm_id,
    t.fclass AS trail_type,
    t.name AS trail_name,
    t.tunnel AS has_tunnel,
    c.ogc_fid AS county_id,
    c.name AS county_name,
    t.geom AS trail_geom,
    c.geom AS county_geom
FROM
    pawximity.utah_county_boundary_ugrc c
    LEFT JOIN pawximity.stg_trails t ON ST_Intersects (c.geom, t.geom)
WHERE
    t.geom IS NOT NULL
    AND c.geom IS NOT NULL;

-- pawximity.stg_trails_by_county definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.stg_trails_by_county;
CREATE MATERIALIZED VIEW pawximity.stg_trails_by_county AS
SELECT
    t.id AS trail_id,
    t.osm_id::bigint AS osm_id,
    t.fclass AS trail_type,
    t.name AS trail_name,
    t.tunnel AS has_tunnel,
    c.ogc_fid AS county_id,
    c.name AS county_name,
    t.geom AS trail_geom
FROM
    pawximity.utah_county_boundary_ugrc c
    LEFT JOIN pawximity.stg_trails t ON ST_Intersects (c.geom, t.geom)
WHERE
    t.geom IS NOT NULL
    AND c.geom IS NOT NULL;

CREATE INDEX stg_trails_by_county_trail_geom_geom_idx ON pawximity.stg_trails_by_county USING gist (trail_geom);

