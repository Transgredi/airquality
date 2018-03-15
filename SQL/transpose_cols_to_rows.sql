SET @sql = NULL;

SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'SELECT `Kod stacji`, ''',
      c.column_name,
      ''' as Station_Code, ',
      c.column_name,
      ' as Pollution_Level FROM 2000_pm10_24g
      '
    ) SEPARATOR ' UNION ALL ') INTO @sql
FROM information_schema.columns c WHERE c.table_name = '2000_pm10_24g' AND c.column_name != 'Kod stacji' ORDER BY c.ordinal_position;

SET @sql = CONCAT('SELECT `Kod stacji`, Station_Code, Pollution_Level FROM (\n\t', @sql, ') U');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;