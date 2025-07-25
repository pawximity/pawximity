-- pawximity.stg_streams definition
-- Drop table
-- DROP TABLE pawximity.stg_streams;
CREATE TABLE pawximity.stg_streams (
    id serial PRIMARY KEY,
    stream_id integer,
    stream_type text,
    length_km double precision,
    stream_geom GEOMETRY(MultiLineString, 26912)
);

CREATE INDEX stg_streams_geom_geom_idx ON pawximity.stg_streams USING gist (stream_geom);

-- TRUNCATE TABLE pawximity.stg_streams;
INSERT INTO pawximity.stg_streams (stream_id, stream_type, length_km, stream_geom)
SELECT
    ogc_fid,
    ftype_text,
    lengthkm,
    ST_Multi (geom)::geometry(MultiLineString, 26912)
FROM
    pawximity.utah_streams_hydrography_ugrc
WHERE
    inutah = 1;

