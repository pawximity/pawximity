-- pawximity.stg_springs definition
-- Drop table
-- DROP TABLE pawximity.stg_springs
CREATE TABLE pawximity.stg_springs (
    id serial PRIMARY KEY,
    spring_id integer,
    spring_type text,
    spring_name text,
    spring_geom GEOMETRY(MultiPoint, 26912)
);

CREATE INDEX stg_springs_geom_gix ON pawximity.stg_springs USING gist (spring_geom);

-- TRUNCATE TABLE pawximity.stg_springs;
INSERT INTO pawximity.stg_springs (spring_id, spring_type, spring_name, spring_geom)
SELECT
    ogc_fid AS spring_id,
    ftype_text AS spring_type,
    gnis_name AS spring_name,
    ST_Multi (geom)::geometry(MultiPoint, 26912)
FROM
    geobase.utah_springs_hydrography_ugrc u
WHERE
    inutah = 1;