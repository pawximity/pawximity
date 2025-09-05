-- pawximity.viz_water_pawximity_50m definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.viz_water_pawximity_50m;
CREATE MATERIALIZED VIEW pawximity.viz_water_pawximity_50m AS SELECT DISTINCT
    w.*
FROM
    pawximity.viz_water_salt_lake_stacked AS w
    JOIN pawximity.trails_salt_lake_clipped AS t ON ST_DWithin (w.geom, t.clipped_trail_geom, 50);

CREATE INDEX viz_water_pawximity_50m_gix ON pawximity.viz_water_pawximity_50m USING GIST (geom);

