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
-- DROP TABLE pawximity.stg_lakes_by_county;
CREATE TABLE pawximity.stg_lakes_by_county (
    id serial PRIMARY KEY,
    lake_id integer,
    lake_type text,
    lake_name text,
    county_id integer,
    county_name text,
    lake_geom GEOMETRY(MultiPolygon, 26912)
);

CREATE INDEX stg_lakes_by_county_lake_geom_geom_idx ON pawximity.stg_lakes_by_county USING gist (lake_geom);

-- TRUNCATE TABLE pawximity.stg_lakes_by_county;
INSERT INTO pawximity.stg_lakes_by_county (lake_id, lake_type, lake_name, county_id, county_name, lake_geom)
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

