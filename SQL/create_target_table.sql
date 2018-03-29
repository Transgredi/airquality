DROP TABLE airquality;
CREATE TABLE airquality (
	uid UUID NOT NULL,
	observation_date TIMESTAMP NOT NULL,
	station_code VARCHAR(45) NULL,
	pollution_type VARCHAR(6) NULL,
	granulation VARCHAR(3) NULL,
	pollution FLOAT NULL
);