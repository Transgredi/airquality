DELETE FROM PM10_1g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania', 'Czas pomiaru');
DELETE FROM PM10_24g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania', 'Czas pomiaru');
DELETE FROM PM25_1g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania', 'Czas pomiaru');
DELETE FROM PM25_24g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania', 'Czas pomiaru');

SELECT Measure_Date, str_to_date(Measure_Date,'%d/%m/%Y %H:%i'), Station_Code FROM PM10_1g_cons LIMIT 1000;

TRUNCATE airquality;
INSERT INTO airquality
SELECT 
	UUID() AS ID, 
    str_to_date(Measure_Date,'%m/%d/%Y %H:%i') AS Observation_Date,
    Aggregation AS Aggregation,
    NULL AS Year_Number,
    NULL AS Month_Name,
    NULL AS Month_Number,
    NULL AS Day_Name,
    NULL AS Day_In_Week,
    NULL AS Day_In_Month,
    NULL AS Day_In_Year,
    NULL AS Week_Number,
    NULL AS City,
    Station_Code AS Station,
    Pollution_Type AS Pollution_Type,
    TRUNCATE(REPLACE((CASE Pollution_Level WHEN '' THEN NULL ELSE Pollution_Level END), ',', '.'), 2) AS Pollution_Level,
    CURRENT_TIMESTAMP()
		FROM (
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM10' AS Pollution_Type, '1g' AS Aggregation FROM PM10_1g_cons
		UNION ALL
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM10' AS Pollution_Type, '24g' AS Aggregation FROM PM10_24g_cons
		UNION ALL
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM2.5' AS Pollution_Type, '1g' AS Aggregation FROM PM25_1g_cons
		UNION ALL
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM2.5' AS Pollution_Type, '24g' AS Aggregation FROM PM25_24g_cons
		) PD WHERE Measure_Date != '';
        

-- DROP TEMPORARY TABLE PDtemp;
-- SELECT REPLACE(Pollution_Level, ',', '.') AS PL FROM PDtemp WHERE Pollution_Level LIKE '%,%';
SELECT MAX(Pollution_Level) FROM DPtemp;
SELECT * FROM DPtemp ORDER BY Load_Date DESC LIMIT 5000;
SELECT MIN(Load_Date) FROM DPtemp;

SELECT CURRENT_TIMESTAMP();
SELECT NOW()