SELECT
    l.*
FROM
    pawximity.stg_lakes_by_county l
    JOIN pawximity.utah_county_boundary_ugrc c ON l.county_id = c.ogc_fid
WHERE
    l.county_name = 'SALT LAKE';

-- pawximity.lakes_salt_lake_clipped definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.lakes_salt_lake_clipped;
CREATE MATERIALIZED VIEW pawximity.lakes_salt_lake_clipped AS
SELECT
    l.lake_id,
    l.lake_type,
    l.lake_name,
    l.county_id,
    l.county_name,
    ST_SetSRID (ST_Multi (ST_CollectionExtract (ST_Intersection (l.lake_geom, c.geom), 3)), 26912)::geometry(MultiPolygon, 26912) AS clipped_lake_geom
FROM
    pawximity.stg_lakes_by_county l
    JOIN pawximity.utah_county_boundary_ugrc c ON l.county_id = c.ogc_fid
WHERE
    l.county_name = 'SALT LAKE'
    AND NOT ST_IsEmpty (ST_Intersection (l.lake_geom, c.geom));

CREATE INDEX lakes_salt_lake_clipped_geom_geom_idx ON pawximity.lakes_salt_lake_clipped USING gist (clipped_lake_geom);

