/* 
Based on https://stackoverflow.com/questions/16359345/transposing-dynamic-columns-to-rows 
*/


SET @sql = NULL;

SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'SELECT `Kod stacji`, ''',
      c.column_name,
      ''' as Station_Code, ',
      c.column_name,
      ' as Pollution_Level FROM 2016_pm10_24g
      '
    ) SEPARATOR ' UNION ALL ') INTO @sql
FROM information_schema.columns c WHERE c.table_name = '2016_pm10_24g' AND c.column_name != 'Kod stacji' ORDER BY c.ordinal_position;

SET @sql = CONCAT('SELECT `Kod stacji`, Station_Code, Pollution_Level FROM (\n\t', @sql, ') U');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



SET @sql2 = NULL;
SET @sql2 = CONCAT('CREATE TEMPORARY TABLE PM10cons24g SELECT `Kod stacji`, Station_Code, Pollution_Level FROM (\n\t', @sql, ') U');
SELECT @sql2;
PREPARE stmt FROM @sql2;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SELECT * FROM PM10cons24g;