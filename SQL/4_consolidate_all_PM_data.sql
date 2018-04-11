DELETE FROM pollution_staging WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania', 'Czas pomiaru');

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

TRUNCATE airquality;

BEGIN;
INSERT INTO airquality
SELECT 
	uuid_generate_v4() AS uid,
	to_timestamp(Measure_Date, 'MM/DD/YYYY HH24:SS') AS observation_date,
	station_code,
	CASE WHEN "source" LIKE '%PM10%' THEN 'PM10' ELSE 'PM2.5' END AS pollution_type,
	CASE WHEN "source" LIKE '%24g%' THEN '24h' ELSE '1h' END AS granulation,
	REPLACE(CASE WHEN pollution_level = '' THEN NULL ELSE pollution_level END, ',', '.')::float8 AS pollution
FROM pollution_staging;
COMMIT;