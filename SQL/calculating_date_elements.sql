SELECT *, YEAR(Observation_Date), (Observation_Date), dayofmonth(Observation_Date), weekday(Observation_Date)+1 FROM airquality.airquality LIMIT 5000;


UPDATE airquality SET Year_Number = YEAR(Observation_Date);