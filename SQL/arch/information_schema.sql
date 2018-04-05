SELECT * FROM information_schema.COLUMNS WHERE table_schema = "airquality" ORDER BY TABLE_NAME, ORDINAL_POSITION;

SHOW columns FROM 2000_pm10_24g;

DESCRIBE 2000_pm10_24g;

SELECT table_name,GROUP_CONCAT(column_name ORDER BY ordinal_position)
FROM information_schema.columns
WHERE table_schema = DATABASE()
GROUP BY table_name
ORDER BY table_name;


SELECT * FROM information_schema.COLUMNS WHERE table_schema = "airquality" AND ORDINAL_POSITION = 2 ORDER BY TABLE_NAME, ORDINAL_POSITION;