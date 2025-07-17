-- DROP SEQUENCE pawximity.stg_trails_id_seq;
CREATE SEQUENCE pawximity.stg_trails_id_seq
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 2147483647 START 1
    CACHE 1 NO CYCLE;

-- pawximity.stg_trails definition
-- Drop table
-- DROP TABLE pawximity.stg_trails
CREATE TABLE pawximity.stg_trails AS
SELECT
    ogc_fid AS id,
    geom,
    osm_id,
    fclass,
    name,
    tunnel
FROM
    pawximity.utah_roads_osm
WHERE
    fclass IN ('footway', 'path', 'track', 'track_grade1', 'track_grade2', 'track_grade3', 'track_grade4', 'track_grade5', 'bridleway', 'cycleway', 'steps', 'pedestrian');

ALTER TABLE pawximity.stg_trails
    ADD PRIMARY KEY (id);

CREATE INDEX stg_trails_geom_geom_idx ON pawximity.stg_trails USING gist (geom);

