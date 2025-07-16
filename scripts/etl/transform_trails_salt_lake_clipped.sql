SELECT s.*,
FROM pawximity.stg_trails_by_county s
JOIN pawximity.utah_county_boundary_ugrc c ON s.county_id = c.ogc_fid
WHERE s.county_name = 'SALT LAKE';

-- pawximity.trails_salt_lake_clipped definition

-- Drop table

-- DROP TABLE pawximity.trails_salt_lake_clipped;

CREATE TABLE pawximity.trails_salt_lake_clipped (
	id SERIAL PRIMARY KEY,
	trail_id BIGINT, 
	osm_id BIGINT, 
	trail_type TEXT, 
	trail_name TEXT, 
	has_tunnel TEXT, 
	county_id INTEGER, 
	county_name TEXT, 
	clipped_trail_geom GEOMETRY(MultiLineString, 26912)
);


CREATE INDEX trails_salt_lake_clipped_geom_geom_idx ON pawximity.trails_salt_lake_clipped USING gist (clipped_trail_geom);

-- TRUNCATE TABLE pawximity.trails_salt_lake_clipped;

INSERT INTO pawximity.trails_salt_lake_clipped (trail_id, osm_id, trail_type, trail_name, has_tunnel, county_id, county_name, clipped_trail_geom)
SELECT s.trail_id,
       s.osm_id,
       s.trail_type,
       s.trail_name,
       s.has_tunnel,
       s.county_id,
       s.county_name,
       ST_Intersection(s.trail_geom, c.geom)::geometry(MultiLineString, 26912) AS clipped_trail_geom
FROM pawximity.stg_trails_by_county s
JOIN pawximity.utah_county_boundary_ugrc c ON s.county_id = c.ogc_fid
WHERE s.county_name = 'SALT LAKE';