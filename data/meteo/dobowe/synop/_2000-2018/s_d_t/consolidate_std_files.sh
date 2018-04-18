#!/bin/bash

rm synop_s_d_t_2000_2018.csv;
rm synop_s_d_t_2000_2018_utf8.csv;

echo "station_code,station_name,year,month,day,cloudiness,NOS_status,wind_speed,FWS_status,avg_temp,TEMP_status,steam_pressure,CPW_status,humidity,WLGS_status,pressure_station_level,PPS_status,pressure_sea_level,PPPM_status,precipitation_day,WODZ_status,precipitation_night,WONO_status" \
>> synop_s_d_t_2000_2018.csv;

cat s_d_t_*.csv >> synop_s_d_t_2000_2018.csv;

iconv -f CP1250 -t UTF-8 synop_s_d_t_2000_2018.csv > synop_s_d_t_2000_2018_utf8.csv;
