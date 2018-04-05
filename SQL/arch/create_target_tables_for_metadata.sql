CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS station_metadata;
CREATE TABLE station_metadata (
	uid UUID NULL DEFAULT uuid_generate_v4(),
	code varchar(45) NULL,
	international_code varchar(45) NULL,
	name varchar(45) NULL,
	legacy_code varchar(45) NULL,
	start_date timestamp NULL,
	end_date timestamp NULL,
	status varchar(20) NULL,
	type varchar(20) NULL,
	area varchar(20) NULL,
	kind varchar(100) NULL,
	voivodship varchar(100) NULL,
	city varchar(100) NULL,
	street varchar(100) NULL,
	latitude varchar(10) NULL,
	longitude varchar(15) NULL
);



DROP TABLE IF EXISTS post_metadata;
CREATE TABLE post_metadata (
	uid UUID NULL DEFAULT uuid_generate_v4(),
	post_code VARCHAR(45) NULL,
	station_code VARCHAR(45) NULL,
	station_name VARCHAR(45) NULL,
	legacy_station_code VARCHAR(45) NULL,
	indicator_code VARCHAR(20) NULL,
	indicator_desc VARCHAR(45) NULL,
	averaging_window VARCHAR(20) NULL,
	monitoring_type VARCHAR(30) NULL,
	start_date TIMESTAMP NULL,
	end_date TIMESTAMP NULL,
	status VARCHAR(20) NULL,
	voivodship VARCHAR(40) NULL,
	zone_name VARCHAR(40) NULL
);