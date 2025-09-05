SELECT
    s.spring_id AS spring_id,
    s.spring_type AS spring_type,
    s.spring_name AS spring_name,
    c.ogc_fid AS county_id,
    c.name AS county_name,
    s.spring_geom AS spring_geom,
    c.geom AS county_geom
FROM
    pawximity.utah_county_boundary_ugrc c
    LEFT JOIN pawximity.stg_springs s ON ST_Intersects (c.geom, s.spring_geom)
WHERE
    s.spring_geom IS NOT NULL
    AND c.geom IS NOT NULL;

-- pawximity.stg_springs_by_county definition
-- Drop table
-- DROP MATERIALIZED VIEW pawximity.stg_springs_by_county;
CREATE MATERIALIZED VIEW pawximity.stg_springs_by_county AS
SELECT
    s.spring_id AS spring_id,
    s.spring_type AS spring_type,
    s.spring_name AS spring_name,
    c.ogc_fid AS county_id,
    c.name AS county_name,
    s.spring_geom AS spring_geom
FROM
    pawximity.utah_county_boundary_ugrc c
    LEFT JOIN pawximity.stg_springs s ON ST_Intersects (c.geom, s.spring_geom)
WHERE
    s.spring_geom IS NOT NULL
    AND c.geom IS NOT NULL;

CREATE INDEX stg_springs_by_county_spring_geom_gix ON pawximity.stg_springs_by_county USING gist (spring_geom);

