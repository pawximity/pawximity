SELECT t.id AS trail_id,
       t.osm_id,
       t.fclass AS trail_type,
       t.name AS trail_name,
       t.tunnel AS has_tunnel,
       c.ogc_fid AS county_id,
       c.name AS county_name,
       t.geom AS trail_geom,
       c.geom AS county_geom
FROM pawximity.utah_county_boundary_ugrc c
LEFT JOIN pawximity.stg_trails t ON ST_Intersects(c.geom, t.geom)
WHERE t.geom IS NOT NULL
  AND c.geom IS NOT NULL;

-- pawximity.stg_trails_by_county definition

-- Drop table

-- DROP TABLE pawximity.stg_trails_by_county;

CREATE TABLE pawximity.stg_trails_by_county (
	id SERIAL PRIMARY KEY,
	trail_id BIGINT, 
	osm_id BIGINT, 
	trail_type TEXT, 
	trail_name TEXT, 
	has_tunnel TEXT, 
	county_id INTEGER, 
	county_name TEXT, 
	trail_geom GEOMETRY(MultiLineString, 26912)
);


CREATE INDEX stg_trails_by_county_trail_geom_geom_idx ON pawximity.stg_trails_by_county USING gist (trail_geom);

-- TRUNCATE TABLE pawximity.stg_trails_by_county;

INSERT INTO pawximity.stg_trails_by_county (trail_id, osm_id, trail_type, trail_name, has_tunnel, county_id, county_name, trail_geom)
SELECT t.id,
       t.osm_id::BIGINT,
       t.fclass,
       t.name,
       t.tunnel,
       c.ogc_fid,
       c.name,
       t.geom
FROM pawximity.utah_county_boundary_ugrc c
LEFT JOIN pawximity.stg_trails t ON ST_Intersects(c.geom, t.geom)
WHERE t.geom IS NOT NULL
  AND c.geom IS NOT NULL;