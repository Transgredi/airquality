SELECT max(char_length(code)) FROM public.station_metadata;

UPDATE station_metadata SET latitude = REPLACE(latitude, ',', '.');
UPDATE station_metadata SET longitude = REPLACE(longitude, ',', '.');

ALTER TABLE station_metadata
ALTER COLUMN code SET DATA TYPE varchar(30),
ALTER COLUMN international_code SET DATA TYPE varchar(10),
ALTER COLUMN "name" SET DATA TYPE varchar(50),
ALTER COLUMN legacy_code SET DATA TYPE varchar(30),
ALTER COLUMN status SET DATA TYPE varchar(10),
ALTER COLUMN "type" SET DATA TYPE varchar(15),
ALTER COLUMN area SET DATA TYPE varchar(15),
ALTER COLUMN kind SET DATA TYPE varchar(30),
ALTER COLUMN voivodship SET DATA TYPE varchar(20),
ALTER COLUMN city SET DATA TYPE varchar(30),
ALTER COLUMN street SET DATA TYPE varchar(40)
--ALTER latitude SET DATA TYPE float8,
--ALTER latitude SET DATA TYPE float8
;



SELECT max(char_length(zone_name)) FROM post_metadata;

ALTER TABLE post_metadata
ALTER COLUMN post_code SET DATA TYPE varchar(40),
ALTER COLUMN station_code SET DATA TYPE varchar(30),
ALTER COLUMN station_name SET DATA TYPE varchar(50),
ALTER COLUMN legacy_station_code SET DATA TYPE varchar(30),
ALTER COLUMN indicator_code SET DATA TYPE varchar(15),
ALTER COLUMN indicator_desc SET DATA TYPE varchar(40),
ALTER COLUMN averaging_window SET DATA TYPE varchar(15),
ALTER COLUMN monitoring_type SET DATA TYPE varchar(15),
ALTER COLUMN status SET DATA TYPE varchar(10),
ALTER COLUMN voivodship SET DATA TYPE varchar(20),
ALTER COLUMN zone_name SET DATA TYPE varchar(35);