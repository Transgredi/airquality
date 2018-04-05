DROP VIEW IF EXISTS list_active_stations;
CREATE VIEW list_active_stations AS
SELECT DISTINCT 
	code, 
	name,
	start_date, 
	city, 
	street
FROM station_metadata
WHERE status = 'aktywny';