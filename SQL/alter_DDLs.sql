SELECT
max(char_length(code))
--max(char_length(international_code))
--max(char_length("name")) 
--max(char_length(legacy_code))
--max(char_length(status)) 
--max(char_length(type))
--max(char_length(area)) 
--max(char_length(kind)) 
--max(char_length(voivodship))
--max(char_length(city)) 
--max(char_length(street))
FROM public.station_metadata;

UPDATE station_metadata SET latitude = REPLACE(latitude, ',', '.');
UPDATE station_metadata SET longitude = REPLACE(longitude, ',', '.');

ALTER TABLE station_metadata
ALTER code SET DATA TYPE varchar(30),
ALTER international_code SET DATA TYPE varchar(10),
ALTER "name" SET DATA TYPE varchar(50),
ALTER legacy_code SET DATA TYPE varchar(30),
ALTER status SET DATA TYPE varchar(10),
ALTER "type" SET DATA TYPE varchar(15),
ALTER area SET DATA TYPE varchar(15),
ALTER kind SET DATA TYPE varchar(30),
ALTER voivodship SET DATA TYPE varchar(20),
ALTER city SET DATA TYPE varchar(30),
ALTER street SET DATA TYPE varchar(40)
--ALTER latitude SET DATA TYPE float8,
--ALTER latitude SET DATA TYPE float8
;



SELECT
max(char_length(legacy_station_code))
FROM post_metadata;

ALTER TABLE post_metadata
ALTER COLUMN post_code SET DATA TYPE varchar(40),
ALTER COLUMN station_code SET DATA TYPE varchar(30),
ALTER COLUMN station_name SET DATA TYPE varchar(50),
ALTER COLUMN station_legacy_code SET DATA TYPE varchar(30),

;