-- pawximity.viz_trails_pawximity_50m definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.viz_trails_pawximity_50m;
CREATE MATERIALIZED VIEW pawximity.viz_trails_pawximity_50m AS SELECT DISTINCT
    t.*
FROM
    pawximity.trails_salt_lake_clipped t
WHERE
    EXISTS (
        SELECT
            1
        FROM
            pawximity.viz_streams_pawximity_50m s
        WHERE
            ST_DWithin (t.clipped_trail_geom, s.geom, 50))
    OR EXISTS (
        SELECT
            1
        FROM
            pawximity.viz_lakes_pawximity_50m l
        WHERE
            ST_DWithin (t.clipped_trail_geom, l.geom, 50))
    OR EXISTS (
        SELECT
            1
        FROM
            pawximity.viz_springs_pawximity_50m p
        WHERE
            ST_DWithin (t.clipped_trail_geom, p.geom, 50));

CREATE INDEX viz_trails_pawximity_50m_geom_gix ON pawximity.viz_trails_pawximity_50m USING GIST (clipped_trail_geom);

