-- https://stackoverflow.com/questions/14113469/generating-time-series-between-two-dates-in-postgresql

SELECT CURRENT_DATE + i FROM GENERATE_SERIES(date '2010-01-01' - CURRENT_DATE,
	date '2010-05-01' - CURRENT_DATE) i;
	

SELECT DATE_TRUNC('hour', HH)::timestamp
FROM GENERATE_SERIES('2010-01-01'::timestamp, '2010-02-01'::timestamp,
	'1 hour'::INTERVAL) HH;
	


SELECT * INTO ts_interval_1h FROM (
	SELECT DATE_TRUNC('hour', HH)::timestamp
FROM GENERATE_SERIES('2010-01-01'::timestamp, '2010-02-01'::timestamp,
	'1 hour'::INTERVAL) HH) AS ts;