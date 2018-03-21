SELECT *, MONTH(Observation_Date), (Observation_Date), dayofmonth(Observation_Date), WEEK(Observation_Date)+1 FROM airquality.airquality LIMIT 5000;


UPDATE airquality SET 
	Year_Number = YEAR(Observation_Date), 
	Month_Name = MONTHNAME(Observation_Date), 
    Month_Number = MONTH(Observation_Date), 
    Day_Name = DAYNAME(Observation_Date),
    Day_In_Week = WEEKDAY(Observation_Date) + 1,
    Day_In_Month = DAYOFMONTH(Observation_Date),
    Day_In_Year = DAYOFYEAR(Observation_Date),
    Week_Number = WEEK(Observation_Date);

