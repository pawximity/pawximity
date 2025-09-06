-- pawximity.viz_springs_pawximity_50m definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.viz_springs_pawximity_50m;
CREATE MATERIALIZED VIEW pawximity.viz_springs_pawximity_50m AS
SELECT
    spring_id AS spring_id,
    'spring' AS feature_type,
    spring_name AS name,
    spring_geom AS geom
FROM
    pawximity.springs_salt_lake_clipped s
WHERE
    EXISTS (
        SELECT
            1
        FROM
            pawximity.trails_salt_lake_clipped t
        WHERE
            ST_DWithin (s.spring_geom, t.clipped_trail_geom, 50));

CREATE INDEX viz_springs_pawximity_50m_gix ON pawximity.viz_springs_pawximity_50m USING GIST (geom);

