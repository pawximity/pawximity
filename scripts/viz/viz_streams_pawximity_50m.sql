-- pawximity.viz_streams_pawximity_50m definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.viz_streams_pawximity_50m;
CREATE MATERIALIZED VIEW pawximity.viz_streams_pawximity_50m AS
SELECT
    stream_id AS stream_id,
    'stream' AS feature_type,
    NULL AS name,
    clipped_stream_geom AS geom
FROM
    pawximity.streams_salt_lake_clipped s
WHERE
    EXISTS (
        SELECT
            1
        FROM
            pawximity.trails_salt_lake_clipped t
        WHERE
            ST_DWithin (s.clipped_stream_geom, t.clipped_trail_geom, 50));

CREATE INDEX viz_streams_pawximity_50m_gix ON pawximity.viz_streams_pawximity_50m USING GIST (geom);

