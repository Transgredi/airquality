SELECT * FROM 2000_pm10_24g LIMIT 100;

SELECT COLUMN_NAME FROM information_schema.columns WHERE table_schema = 'airquality' AND table_name = '2000_pm10_24g' AND column_name != 'Kod stacji';

SELECT GROUP_CONCAT(COLUMN_NAME) FROM information_schema.columns WHERE table_schema = 'airquality' AND table_name = '2000_pm10_24g' AND column_name != 'Kod stacji';

SELECT MAX(ORDINAL_POSITION) FROM information_schema.columns WHERE table_schema = 'airquality' AND table_name = '2000_pm10_24g';



SELECT
	`Kod stacji`, 
	(SELECT COLUMN_NAME FROM information_schema.columns WHERE table_name = '2000_pm10_24g' AND ORDINAL_POSITION = 2) AS Station, 
    DsWrocWie
FROM 2000_pm10_24g;