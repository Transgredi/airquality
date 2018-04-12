DROP VIEW IF EXISTS list_active_stations;
CREATE VIEW list_active_stations AS
SELECT DISTINCT 
	code, 
	name,
	start_date, 
	city, 
	street
FROM station_metadata
WHERE status = 'aktywny';


DROP VIEW IF EXISTS PM_Wro;
CREATE VIEW PM_Wro AS
SELECT * FROM airquality 
WHERE station_code IN (SELECT lower(code) FROM station_metadata WHERE city = 'Wrocław');


DROP VIEW IF EXISTS airquality_pm10_1h;
CREATE VIEW airquality_pm10_1h AS
SELECT 
	a.observation_date,
	TO_CHAR(a.observation_date, 'YYYY') AS "year",
	TO_CHAR(a.observation_date, 'MM') AS "mth_num",
	TO_CHAR(a.observation_date, 'Month') AS "mth_name",
	TO_CHAR(a.observation_date, 'DD') AS "day_mth_num",
	TO_CHAR(a.observation_date, 'Day') AS "day_name",
	a.pollution_type,
	a.granulation,
	a.pollution,
	s.code,
	s.voivodship, 
	s.city,
	s.street
FROM airquality a
LEFT JOIN station_metadata s ON a.station_code = LOWER(s.code)
WHERE 
	a.granulation = '1h'
	AND a.pollution_type = 'PM10'
ORDER BY a.observation_date;


DROP VIEW IF EXISTS airquality_pm10_24h;
CREATE VIEW airquality_pm10_24h AS
SELECT 
	a.observation_date,
	TO_CHAR(a.observation_date, 'YYYY') AS "year",
	TO_CHAR(a.observation_date, 'MM') AS "mth_num",
	TO_CHAR(a.observation_date, 'Month') AS "mth_name",
	TO_CHAR(a.observation_date, 'DD') AS "day_mth_num",
	TO_CHAR(a.observation_date, 'Day') AS "day_name",
	a.pollution_type,
	a.granulation,
	a.pollution,
	s.code,
	s.voivodship, 
	s.city,
	s.street
FROM airquality a
LEFT JOIN station_metadata s ON a.station_code = LOWER(s.code)
WHERE 
	a.granulation = '24h'
	AND a.pollution_type = 'PM10'
ORDER BY a.observation_date;


DROP VIEW IF EXISTS airquality_pm25_1h;
CREATE VIEW airquality_pm25_1h AS
SELECT 
	a.observation_date,
	TO_CHAR(a.observation_date, 'YYYY') AS "year",
	TO_CHAR(a.observation_date, 'MM') AS "mth_num",
	TO_CHAR(a.observation_date, 'Month') AS "mth_name",
	TO_CHAR(a.observation_date, 'DD') AS "day_mth_num",
	TO_CHAR(a.observation_date, 'Day') AS "day_name",
	a.pollution_type,
	a.granulation,
	a.pollution,
	s.code,
	s.voivodship, 
	s.city,
	s.street
FROM airquality a
LEFT JOIN station_metadata s ON a.station_code = LOWER(s.code)
WHERE 
	a.granulation = '1h'
	AND a.pollution_type = 'PM2.5'
ORDER BY a.observation_date;


DROP VIEW IF EXISTS airquality_pm25_24h;
CREATE VIEW airquality_pm25_24h AS
SELECT 
	a.observation_date,
	TO_CHAR(a.observation_date, 'YYYY') AS "year",
	TO_CHAR(a.observation_date, 'MM') AS "mth_num",
	TO_CHAR(a.observation_date, 'Month') AS "mth_name",
	TO_CHAR(a.observation_date, 'DD') AS "day_mth_num",
	TO_CHAR(a.observation_date, 'Day') AS "day_name",
	a.pollution_type,
	a.granulation,
	a.pollution,
	s.code,
	s.voivodship, 
	s.city,
	s.street
FROM airquality a
LEFT JOIN station_metadata s ON a.station_code = LOWER(s.code)
WHERE 
	a.granulation = '24h'
	AND a.pollution_type = 'PM2.5'
ORDER BY a.observation_date;



/* 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * SEPARATE VIEWS FOR EACH GRANULATION AND POLLUTION TYPE FOR WROCLAW ONLY
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 */

DROP VIEW IF EXISTS PM_Wro_PM10_1h;
CREATE VIEW PM_Wro_PM10_1h AS
SELECT * FROM airquality
WHERE station_code IN (SELECT LOWER(code) FROM station_metadata WHERE city = 'Wrocław')
AND pollution_type = 'PM10' AND granulation = '1h';


DROP VIEW IF EXISTS PM_Wro_PM10_24h;
CREATE VIEW PM_Wro_PM10_24h AS
SELECT * FROM airquality
WHERE station_code IN (SELECT LOWER(code) FROM station_metadata WHERE city = 'Wrocław')
AND pollution_type = 'PM10' AND granulation = '24h';


DROP VIEW IF EXISTS PM_Wro_PM25_1h;
CREATE VIEW PM_Wro_PM25_1h AS
SELECT * FROM airquality
WHERE station_code IN (SELECT LOWER(code) FROM station_metadata WHERE city = 'Wrocław')
AND pollution_type = 'PM2.5' AND granulation = '1h';


DROP VIEW IF EXISTS PM_Wro_PM25_24h;
CREATE VIEW PM_Wro_PM25_24h AS
SELECT * FROM airquality
WHERE station_code IN (SELECT LOWER(code) FROM station_metadata WHERE city = 'Wrocław')
AND pollution_type = 'PM2.5' AND granulation = '24h';
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */