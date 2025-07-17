-- DROP SCHEMA pawximity;

CREATE SCHEMA pawximity AUTHORIZATION postgres;
-- DROP SEQUENCE pawximity.utah_county_boundary_ugrc_ogc_fid_seq;

CREATE SEQUENCE pawximity.utah_county_boundary_ugrc_ogc_fid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE pawximity.utah_lakes_hydrography_ugrc_ogc_fid_seq;

CREATE SEQUENCE pawximity.utah_lakes_hydrography_ugrc_ogc_fid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE pawximity.utah_roads_osm_ogc_fid_seq;

CREATE SEQUENCE pawximity.utah_roads_osm_ogc_fid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE pawximity.utah_springs_hydrography_ugrc_ogc_fid_seq;

CREATE SEQUENCE pawximity.utah_springs_hydrography_ugrc_ogc_fid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE pawximity.utah_state_boundary_ugrc_ogc_fid_seq;

CREATE SEQUENCE pawximity.utah_state_boundary_ugrc_ogc_fid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE pawximity.utah_streams_hydrography_ugrc_ogc_fid_seq;

CREATE SEQUENCE pawximity.utah_streams_hydrography_ugrc_ogc_fid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- pawximity.utah_county_boundary_ugrc definition
-- Drop table
-- DROP TABLE pawximity.utah_county_boundary_ugrc;

CREATE TABLE pawximity.utah_county_boundary_ugrc (
	ogc_fid serial4 NOT NULL,
	geom public.geometry(multipolygon,
26912) NULL,
	object_id int4 NULL,
	countynbr varchar NULL,
	entitynbr int4 NULL,
	entityyr int4 NULL,
	"name" varchar NULL,
	fips int4 NULL,
	stateplane varchar NULL,
	pop_lastcensus int4 NULL,
	pop_currestimate int4 NULL,
	global_id varchar NULL,
	fips_str varchar NULL,
	color4 int4 NULL,
	CONSTRAINT utah_county_boundary_ugrc_pk PRIMARY KEY (ogc_fid)
);

CREATE INDEX utah_county_boundary_ugrc_geom_geom_idx ON
pawximity.utah_county_boundary_ugrc
	USING gist (geom);
-- pawximity.utah_lakes_hydrography_ugrc definition
-- Drop table
-- DROP TABLE pawximity.utah_lakes_hydrography_ugrc;

CREATE TABLE pawximity.utah_lakes_hydrography_ugrc (
	ogc_fid serial4 NOT NULL,
	geom public.geometry(multipolygon,
26912) NULL,
	object_id int4 NULL,
	permanent_identifier varchar NULL,
	fdate varchar NULL,
	resolution int4 NULL,
	gnis_id varchar NULL,
	gnis_name varchar NULL,
	areasqkm float8 NULL,
	elevation float8 NULL,
	reachcode varchar NULL,
	ftype int4 NULL,
	ftype_text varchar NULL,
	fcode int4 NULL,
	fcode_text varchar NULL,
	inutah int4 NULL,
	ismajor int4 NULL,
	CONSTRAINT utah_lakes_hydrography_ugrc_pk PRIMARY KEY (ogc_fid)
);

CREATE INDEX utah_lakes_hydrography_ugrc_geom_geom_idx ON
pawximity.utah_lakes_hydrography_ugrc
	USING gist (geom);
-- pawximity.utah_roads_osm definition
-- Drop table
-- DROP TABLE pawximity.utah_roads_osm;

CREATE TABLE pawximity.utah_roads_osm (
	ogc_fid serial4 NOT NULL,
	geom public.geometry(multilinestring,
26912) NULL,
	osm_id varchar(12) NULL,
	code NUMERIC(4) NULL,
	fclass varchar(28) NULL,
	"name" varchar(100) NULL,
	"ref" varchar(20) NULL,
	oneway varchar(1) NULL,
	maxspeed NUMERIC(3) NULL,
	layer NUMERIC(12) NULL,
	bridge varchar(1) NULL,
	tunnel varchar(1) NULL,
	CONSTRAINT utah_roads_osm_pk PRIMARY KEY (ogc_fid)
);

CREATE INDEX utah_roads_osm_geom_geom_idx ON
pawximity.utah_roads_osm
	USING gist (geom);
-- pawximity.utah_springs_hydrography_ugrc definition
-- Drop table
-- DROP TABLE pawximity.utah_springs_hydrography_ugrc;

CREATE TABLE pawximity.utah_springs_hydrography_ugrc (
	ogc_fid serial4 NOT NULL,
	geom public.geometry(multipoint,
26912) NULL,
	object_id int4 NULL,
	permanent_identifier varchar NULL,
	fdate varchar NULL,
	resolution int4 NULL,
	gnis_id varchar NULL,
	gnis_name varchar NULL,
	reachcode varchar NULL,
	ftype int4 NULL,
	ftype_text varchar NULL,
	fcode int4 NULL,
	fcode_text varchar NULL,
	inutah int4 NULL,
	CONSTRAINT utah_springs_hydrography_ugrc_pk PRIMARY KEY (ogc_fid)
);

CREATE INDEX utah_springs_hydrography_ugrc_geom_geom_idx ON
pawximity.utah_springs_hydrography_ugrc
	USING gist (geom);
-- pawximity.utah_state_boundary_ugrc definition
-- Drop table
-- DROP TABLE pawximity.utah_state_boundary_ugrc;

CREATE TABLE pawximity.utah_state_boundary_ugrc (
	ogc_fid serial4 NOT NULL,
	geom public.geometry(multipolygon,
26912) NULL,
	object_id int4 NULL,
	state varchar NULL,
	global_id varchar NULL,
	CONSTRAINT utah_state_boundary_ugrc_pk PRIMARY KEY (ogc_fid)
);

CREATE INDEX utah_state_boundary_ugrc_geom_geom_idx ON
pawximity.utah_state_boundary_ugrc
	USING gist (geom);
-- pawximity.utah_streams_hydrography_ugrc definition
-- Drop table
-- DROP TABLE pawximity.utah_streams_hydrography_ugrc;

CREATE TABLE pawximity.utah_streams_hydrography_ugrc (
	ogc_fid serial4 NOT NULL,
	geom public.geometry(multilinestring,
26912) NULL,
	object_id int4 NULL,
	permanent_identifier varchar NULL,
	fdate varchar NULL,
	resolution int4 NULL,
	gnis_id varchar NULL,
	gnis_name varchar NULL,
	lengthkm float8 NULL,
	reachcode varchar NULL,
	flowdir int4 NULL,
	wbarea_permanent_identifier varchar NULL,
	ftype int4 NULL,
	ftype_text varchar NULL,
	fcode int4 NULL,
	fcode_text varchar NULL,
	enabled int4 NULL,
	inutah int4 NULL,
	ismajor int4 NULL,
	submerged int4 NULL,
	CONSTRAINT utah_streams_hydrography_ugrc_pk PRIMARY KEY (ogc_fid)
);

CREATE INDEX utah_streams_hydrography_ugrc_geom_geom_idx ON
pawximity.utah_streams_hydrography_ugrc
	USING gist (geom);