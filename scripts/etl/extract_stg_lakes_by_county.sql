SELECT
    l.lake_id AS lake_id,
    l.lake_type AS lake_type,
    l.lake_name AS lake_name,
    c.ogc_fid AS county_id,
    c.name AS county_name,
    l.lake_geom AS lake_geom,
    c.geom AS county_geom
FROM
    pawximity.utah_county_boundary_ugrc c
    LEFT JOIN pawximity.stg_lakes l ON ST_Intersects (c.geom, l.lake_geom)
WHERE
    l.lake_geom IS NOT NULL
    AND c.geom IS NOT NULL;

-- pawximity.stg_lakes_by_county definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.stg_lakes_by_county;
CREATE MATERIALIZED VIEW pawximity.stg_lakes_by_county AS
SELECT
    l.lake_id AS lake_id,
    l.lake_type AS lake_type,
    l.lake_name AS lake_name,
    c.ogc_fid AS county_id,
    c.name AS county_name,
    l.lake_geom AS lake_geom
FROM
    pawximity.utah_county_boundary_ugrc c
    LEFT JOIN pawximity.stg_lakes l ON ST_Intersects (c.geom, l.lake_geom)
WHERE
    l.lake_geom IS NOT NULL
    AND c.geom IS NOT NULL;

CREATE INDEX stg_lakes_by_county_lake_geom_gix ON pawximity.stg_lakes_by_county USING gist (lake_geom);

