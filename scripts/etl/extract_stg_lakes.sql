-- pawximity.stg_lakes definition
-- Drop table
-- DROP TABLE pawximity.stg_lakes
CREATE TABLE pawximity.stg_lakes (
    id serial PRIMARY KEY,
    lake_id integer,
    lake_type text,
    lake_name text,
    lake_geom GEOMETRY(MultiPolygon, 26912)
);

CREATE INDEX stg_lakes_geom_gix ON pawximity.stg_lakes USING gist (lake_geom);

-- TRUNCATE TABLE pawximity.stg_lakes;
INSERT INTO pawximity.stg_lakes (lake_id, lake_type, lake_name, lake_geom)
SELECT
    ogc_fid AS lake_id,
    ftype_text AS lake_type,
    gnis_name AS lake_name,
    ST_Multi (geom)::geometry(MultiPolygon, 26912)
FROM
    geobase.utah_lakes_hydrography_ugrc u
WHERE
    inutah = 1;