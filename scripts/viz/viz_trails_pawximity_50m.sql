-- pawximity.viz_trails_pawximity_50m definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.viz_trails_pawximity_50m;
CREATE MATERIALIZED VIEW pawximity.viz_trails_pawximity_50m AS SELECT DISTINCT
    t.*
FROM
    pawximity.trails_salt_lake_clipped t
    JOIN pawximity.viz_water_salt_lake_stacked w ON ST_DWithin (t.clipped_trail_geom, w.geom, 50);

CREATE INDEX viz_trails_pawximity_50m_geom_gix ON pawximity.viz_trails_pawximity_50m USING GIST (clipped_trail_geom);

