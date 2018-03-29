SELECT
	EXTRACT(YEAR FROM observation_date) AS yr, 	
	EXTRACT(MONTH FROM observation_date) AS mth,
	station_code,
	MAX(pollution) AS pollution
FROM public.airquality
WHERE 
	pollution_type = 'PM10' 
	AND granulation = '24h' 
	AND station_code LIKE '%Wroc%' 
	AND EXTRACT(YEAR FROM observation_date) > 2014
GROUP BY ROLLUP(yr, mth, station_code)
ORDER BY yr, mth, station_code;


SELECT
	EXTRACT(YEAR FROM observation_date) AS yr, 	
	EXTRACT(MONTH FROM observation_date) AS mth,
	station_code,
	MAX(pollution) AS pollution
FROM public.airquality
WHERE 
	pollution_type = 'PM10' 
	AND granulation = '24h' 
	AND station_code LIKE '%Wroc%' 
	AND EXTRACT(YEAR FROM observation_date) > 2014
GROUP BY CUBE(yr, mth, station_code)
ORDER BY yr, mth, station_code;