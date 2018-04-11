CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SELECT * INTO station_meta_new FROM
	(SELECT 
		uuid_generate_v4() AS uid,
		code, 
		'actual' AS code_type,
		international_code,
		"name",
		start_date,
		end_date,
		status,
		"type",
		area,
		kind,
		voivodship,
		city,
		street,
		latitude,
		longitude
	 FROM station_metadata
	 UNION
	 SELECT
	 	uuid_generate_v4() AS uid,
	 	legacy_code, 
	 	'legacy' AS code_type,
	 	international_code,
		"name",
		start_date,
		end_date,
		status,
		"type",
		area,
		kind,
		voivodship,
		city,
		street,
		latitude,
		longitude
	 FROM station_metadata
	 ORDER BY "name"
	) u;
	
ALTER TABLE station_metadata RENAME TO station_metadata_arch;
ALTER TABLE station_meta_new RENAME TO station_metadata;