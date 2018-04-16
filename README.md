# Datasources
1. **GIOS** http://powietrze.gios.gov.pl/pjp/archives
2. **Meteo** https://dane.imgw.pl/#dane-pomiarowo-obserwacyjne

# Systems & platforms
1. Initialy - MySQL
2. Target - PostgreSQL
3. R and Python

# Steps
1. Download Excel files
2. Convert Excel files to CSV
3. Load CSV to the DB
4. Merge staging tables into tables by pollution type and time granulation
5. Merge all data into one final table
6. Load metadata for monitoring stations
7. Export data to CSV files

```bash
#!/bin/sh

psql -d airquality -c \
"COPY (SELECT * FROM airquality_pm25_24h) TO stdout DELIMITER ';' CSV HEADER;" \
| gzip > airquality_pm25_24h_2000-2016.csv.gz

psql -d airquality -c \
"COPY (SELECT * FROM airquality_pm25_1h) TO stdout DELIMITER ';' CSV HEADER;" \
| gzip > airquality_pm25_1h_2000-2016.csv.gz

psql -d airquality -c \
"COPY (SELECT * FROM airquality_pm10_24h) TO stdout DELIMITER ';' CSV HEADER;" \
| gzip > airquality_pm10_24h_2000-2016.csv.gz

psql -d airquality -c \
"COPY (SELECT * FROM airquality_pm10_1h) TO stdout DELIMITER ';' CSV HEADER;" \
| gzip > airquality_pm10_1h_2000-2016.csv.gz
```

# Weather data
```bash 
echo "header1, header2, ..." >> synop_s_d_t_2000-2018.csv
cat *.csv >> synop_s_d_t_2000-2018.csv
iconv -f CP1250 -t UTF-8 synop_s_d_t_2000-2018 > synop_s_d_t_2000-2018_utf8.csv
```






![Data flow](data_flow_overview.png)
