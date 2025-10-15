-- pawximity.stg_trails definition
-- Drop table
-- DROP TABLE pawximity.stg_trails
CREATE TABLE pawximity.stg_trails (
    id serial PRIMARY KEY,
    trail_id integer,
    osm_id integer,
    trail_name text,
    trail_type text,
    has_tunnel boolean,
    trail_geom GEOMETRY(MultiLineString, 26912)
);

CREATE INDEX stg_trails_geom_gix ON pawximity.stg_trails USING gist (trail_geom);

INSERT INTO pawximity.stg_trails (trail_id, osm_id, trail_name, trail_type, has_tunnel, trail_geom)
SELECT
    ogc_fid AS trail_id,
    osm_id::integer AS osm_id,
    name AS trail_name,
    fclass AS trail_type,
    tunnel::boolean AS has_tunnel,
    ST_Multi (geom)::geometry(MultiLineString, 26912)
FROM
    geobase.utah_roads_osm u
WHERE
    fclass IN ('footway', 'path', 'track', 'track_grade1', 'track_grade2', 'track_grade3', 'track_grade4', 'track_grade5', 'bridleway', 'cycleway', 'steps', 'pedestrian');