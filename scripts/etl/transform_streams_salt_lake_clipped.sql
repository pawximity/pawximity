SELECT
    s.*
FROM
    pawximity.stg_streams_by_county s
    JOIN pawximity.utah_county_boundary_ugrc c ON s.county_id = c.ogc_fid
WHERE
    s.county_name = 'SALT LAKE';

-- pawximity.streams_salt_lake_clipped definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.streams_salt_lake_clipped;
CREATE MATERIALIZED VIEW pawximity.streams_salt_lake_clipped AS
SELECT
    s.stream_id,
    s.stream_type,
    s.stream_length_km,
    s.county_id,
    s.county_name,
    ST_SetSRID (ST_Multi (ST_CollectionExtract (ST_Intersection (s.stream_geom, c.geom), 2)), 26912)::geometry(MultiLineString, 26912) AS clipped_stream_geom
FROM
    pawximity.stg_streams_by_county s
    JOIN pawximity.utah_county_boundary_ugrc c ON s.county_id = c.ogc_fid
WHERE
    s.county_name = 'SALT LAKE'
    AND NOT ST_IsEmpty (ST_Intersection (s.stream_geom, c.geom));

CREATE INDEX streams_salt_lake_clipped_geom_geom_idx ON pawximity.streams_salt_lake_clipped USING gist (clipped_stream_geom);

