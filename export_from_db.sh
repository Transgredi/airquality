#!/bin/sh

psql -d airquality -c \
"COPY (SELECT * FROM airquality_pm25_24h) TO 'stdout DELIMITER ';' CSV HEADER;" \
| gzip > airquality_pm25_24h_2000-2016.csv.gz
