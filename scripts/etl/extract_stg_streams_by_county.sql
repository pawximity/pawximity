SELECT
    s.stream_id AS stream_id,
    s.stream_type AS stream_type,
    s.length_km AS stream_length_km,
    c.ogc_fid AS county_id,
    c.name AS county_name,
    s.stream_geom AS stream_geom,
    c.geom AS county_geom
FROM
    pawximity.utah_county_boundary_ugrc c
    LEFT JOIN pawximity.stg_streams s ON ST_Intersects (c.geom, s.stream_geom)
WHERE
    s.stream_geom IS NOT NULL
    AND c.geom IS NOT NULL;

-- pawximity.stg_streams_by_county definition
-- Drop table
-- DROP TABLE pawximity.stg_streams_by_county;
CREATE TABLE pawximity.stg_streams_by_county (
    id serial PRIMARY KEY,
    stream_id integer,
    stream_type text,
    stream_length_km double precision,
    county_id integer,
    county_name text,
    stream_geom GEOMETRY(MultiLineString, 26912)
);

CREATE INDEX stg_streams_by_county_stream_geom_geom_idx ON pawximity.stg_streams_by_county USING gist (stream_geom);

-- TRUNCATE TABLE pawximity.stg_streams_by_county;
INSERT INTO pawximity.stg_streams_by_county (stream_id, stream_type, stream_length_km, county_id, county_name, stream_geom)
SELECT
    s.stream_id AS stream_id,
    s.stream_type AS stream_type,
    s.length_km AS stream_length_km,
    c.ogc_fid AS county_id,
    c.name AS county_name,
    s.stream_geom AS stream_geom
FROM
    pawximity.utah_county_boundary_ugrc c
    LEFT JOIN pawximity.stg_streams s ON ST_Intersects (c.geom, s.stream_geom)
WHERE
    s.stream_geom IS NOT NULL
    AND c.geom IS NOT NULL;

