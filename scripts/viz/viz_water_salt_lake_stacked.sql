-- pawximity.viz_water_salt_lake_stacked definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.viz_water_salt_lake_stacked;
CREATE MATERIALIZED VIEW pawximity.viz_water_salt_lake_stacked AS
SELECT
    'stream' AS feature_type,
    NULL AS name,
    clipped_stream_geom AS geom
FROM
    pawximity.streams_salt_lake_clipped
UNION ALL
SELECT
    'lake' AS feature_type,
    lake_name AS name,
    clipped_lake_geom AS geom
FROM
    pawximity.lakes_salt_lake_clipped
UNION ALL
SELECT
    'spring' AS feature_type,
    spring_name AS name,
    spring_geom AS geom
FROM
    pawximity.springs_salt_lake_clipped;

CREATE INDEX viz_water_salt_lake_stacked_gix ON pawximity.viz_water_salt_lake_stacked USING GIST (geom);

