-- Drop table
-- DROP TABLE pawximity.stg_lakes;
CREATE TABLE pawximity.stg_lakes (
    id serial4 NOT NULL,
    lake_id int4 NULL,
    lake_type text NULL,
    lake_name text NULL,
    lake_geom public.GEOMETRY(multipolygon, 26912) NULL,
    CONSTRAINT stg_lakes_pkey PRIMARY KEY (id)
);

CREATE INDEX stg_lakes_geom_gix ON pawximity.stg_lakes USING gist (lake_geom);

-- Drop table
-- DROP TABLE pawximity.stg_springs;
CREATE TABLE pawximity.stg_springs (
    id serial4 NOT NULL,
    spring_id int4 NULL,
    spring_type text NULL,
    spring_name text NULL,
    spring_geom public.GEOMETRY(multipoint, 26912) NULL,
    CONSTRAINT stg_springs_pkey PRIMARY KEY (id)
);

CREATE INDEX stg_springs_geom_gix ON pawximity.stg_springs USING gist (spring_geom);

-- Drop table
-- DROP TABLE pawximity.stg_streams;
CREATE TABLE pawximity.stg_streams (
    id serial4 NOT NULL,
    stream_id int4 NULL,
    stream_type text NULL,
    length_km float8 NULL,
    stream_geom public.GEOMETRY(multilinestring, 26912) NULL,
    CONSTRAINT stg_streams_pkey PRIMARY KEY (id)
);

CREATE INDEX stg_streams_geom_gix ON pawximity.stg_streams USING gist (stream_geom);

-- Drop table
-- DROP TABLE pawximity.stg_trails;
CREATE TABLE pawximity.stg_trails (
    id serial4 NOT NULL,
    trail_id int4 NULL,
    osm_id int4 NULL,
    trail_name text NULL,
    trail_type text NULL,
    has_tunnel bool NULL,
    trail_geom public.GEOMETRY(multilinestring, 26912) NULL,
    CONSTRAINT stg_trails_pkey PRIMARY KEY (id)
);

CREATE INDEX stg_trails_geom_gix ON pawximity.stg_trails USING gist (trail_geom);