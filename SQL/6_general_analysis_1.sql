--quality check
SELECT DISTINCT 
date_part('year', observation_date)::decimal AS yr,
MAX(CASE granulation WHEN '24h' THEN 1 ELSE 0 END) AS "24h",
MAX(CASE granulation WHEN '1h' THEN 1 ELSE 0 END) AS "1h",
MAX(CASE pollution_type WHEN 'PM10' THEN 1 ELSE 0 END) AS PM10,
MAX(CASE pollution_type WHEN 'PM2.5' THEN 1 ELSE 0 END) AS PM25
FROM airquality
GROUP BY yr
ORDER BY yr;




--overall analysis
SELECT
	CAST(EXTRACT(YEAR FROM observation_date) AS INT) AS yr, 	
	CAST(EXTRACT(MONTH FROM observation_date) AS INT) AS mth,
	AVG(pollution) AS pollution
FROM airquality
WHERE 
	pollution_type = 'PM10' 
	AND granulation = '24h' 
	AND station_code LIKE '%wroc%' 
	AND EXTRACT(YEAR FROM observation_date) > 2000
GROUP BY ROLLUP(yr, mth)
ORDER BY yr, mth;


SELECT
	EXTRACT(YEAR FROM observation_date)::INT AS yr, 	
	EXTRACT(MONTH FROM observation_date)::INT AS mth,
	pollution_type,
	MAX(pollution) AS pollution
FROM airquality
WHERE 
	granulation = '24h' 
	AND station_code LIKE '%wroc%' 
	AND EXTRACT(YEAR FROM observation_date) > 2014
GROUP BY CUBE(yr, mth, pollution_type)
ORDER BY yr, mth, pollution_type;