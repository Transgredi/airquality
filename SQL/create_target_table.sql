DROP TABLE airquality;

CREATE TABLE airquality (
	observation_date TIMESTAMP NOT NULL,
	station_code VARCHAR(45) NULL,
	pollution_type VARCHAR(6) NULL,
	granullation VARCHAR(3) NULL,
	pollution FLOAT NULL
)