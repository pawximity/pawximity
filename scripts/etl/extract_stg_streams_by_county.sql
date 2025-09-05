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
-- DROP MATERIALIZED VIEW pawximity.stg_streams_by_county;
CREATE MATERIALIZED VIEW pawximity.stg_streams_by_county AS
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

CREATE INDEX stg_streams_by_county_stream_geom_gix ON pawximity.stg_streams_by_county USING gist (stream_geom);

