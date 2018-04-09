DELETE FROM PM10_1g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania', 'Czas pomiaru');
DELETE FROM PM10_24g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania', 'Czas pomiaru');
DELETE FROM PM25_1g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania', 'Czas pomiaru');
DELETE FROM PM25_24g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania', 'Czas pomiaru');

TRUNCATE airquality;
INSERT INTO airquality;
SELECT 
	uuid_generate_v4() AS uid, 
    str_to_date(Measure_Date,'%m/%d/%Y %H:%i') AS observation_date,
    Aggregation AS granulation,
    Station_Code AS station_code,
    Pollution_Type AS pollution_type,
    TRUNCATE(REPLACE((CASE Pollution_Level WHEN '' THEN NULL ELSE Pollution_Level END), ',', '.'), 2) AS pollution
		FROM (
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM10' AS Pollution_Type, '1g' AS Aggregation FROM PM10_1h_cons
		UNION ALL
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM10' AS Pollution_Type, '24g' AS Aggregation FROM PM10_24h_cons
		UNION ALL
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM2.5' AS Pollution_Type, '1g' AS Aggregation FROM PM25_1h_cons
		UNION ALL
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM2.5' AS Pollution_Type, '24g' AS Aggregation FROM PM25_24h_cons
		) PD WHERE Measure_Date != '';
        


UPDATE airquality SET Aggregation = '24h' WHERE Aggregation = '24g';
UPDATE airquality SET Aggregation = '1h' WHERE Aggregation = '1g';


SELECT uuid_generate_v4();