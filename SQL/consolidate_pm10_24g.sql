SELECT * FROM 2000_pm10_24g LIMIT 100;

SELECT COLUMN_NAME FROM information_schema.columns WHERE table_schema = 'airquality' AND table_name = '2000_pm10_24g' AND column_name != 'Kod stacji';

SELECT GROUP_CONCAT(COLUMN_NAME) FROM information_schema.columns WHERE table_schema = 'airquality' AND table_name = '2000_pm10_24g' AND column_name != 'Kod stacji';