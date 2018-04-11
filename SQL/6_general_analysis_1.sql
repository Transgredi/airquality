SELECT
	CAST(EXTRACT(YEAR FROM observation_date) AS INT) AS yr, 	
	CAST(EXTRACT(MONTH FROM observation_date) AS INT) AS mth,
	AVG(pollution) AS pollution
FROM airquality
WHERE 
	pollution_type = 'PM10' 
	AND granulation = '24h' 
	AND station_code LIKE '%Wroc%' 
	AND EXTRACT(YEAR FROM observation_date) > 2014
GROUP BY ROLLUP(yr, mth)
ORDER BY yr, mth;


SELECT
	EXTRACT(YEAR FROM observation_date) AS yr, 	
	EXTRACT(MONTH FROM observation_date) AS mth,
	pollution_type,
	MAX(pollution) AS pollution
FROM airquality
WHERE 
	granulation = '24h' 
	AND station_code LIKE '%Wroc%' 
	AND EXTRACT(YEAR FROM observation_date) > 2014
GROUP BY CUBE(yr, mth, pollution_type)
ORDER BY yr, mth, pollution_type;