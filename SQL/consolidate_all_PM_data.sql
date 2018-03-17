DELETE FROM PM10_1g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania');
DELETE FROM PM10_24g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania');
DELETE FROM PM25_1g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania');
DELETE FROM PM25_24g_cons WHERE Measure_Date IN ('Wskaźnik', 'Czas uśredniania');


INSERT INTO airquality 
SELECT 
	UUID() AS ID, 
    Measure_Date AS Observation_Date,
    Aggregation AS Aggregation,
    NULL AS Year_Number,
    NULL AS Month_Number,
    NULL AS Month_Name,
    NULL AS Week_Number,
    NULL AS Day_Name,
    NULL AS City,
    Station_Code AS Station,
    Pollution_Type AS Pollution_Type,
    Pollution_Level AS Pollution_Level
		FROM (
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM10' AS Pollution_Type, '1g' AS Aggregation FROM PM10_1g_cons
		UNION ALL
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM10' AS Pollution_Type, '24g' AS Aggregation FROM PM10_24g_cons
		UNION ALL
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM2.5' AS Pollution_Type, '1g' AS Aggregation FROM PM25_1g_cons
		UNION ALL
		SELECT Measure_Date, Station_Code, Pollution_Level, 'PM2.5' AS Pollution_Type, '24g' AS Aggregation FROM PM25_24g_cons
		) PD;