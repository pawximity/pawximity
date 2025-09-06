-- pawximity.viz_lakes_pawximity_50m definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.viz_lakes_pawximity_50m;
CREATE MATERIALIZED VIEW pawximity.viz_lakes_pawximity_50m AS
SELECT
    lake_id AS lake_id,
    'lake' AS feature_type,
    lake_name AS name,
    clipped_lake_geom AS geom
FROM
    pawximity.lakes_salt_lake_clipped l
WHERE
    EXISTS (
        SELECT
            1
        FROM
            pawximity.trails_salt_lake_clipped t
        WHERE
            ST_DWithin (l.clipped_lake_geom, t.clipped_trail_geom, 50));

CREATE INDEX viz_lakes_pawximity_50m_gix ON pawximity.viz_lakes_pawximity_50m USING GIST (geom);

