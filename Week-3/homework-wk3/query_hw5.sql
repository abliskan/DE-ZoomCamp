-- Homework no-5
CREATE OR REPLACE TABLE 'dezoomcamp_yellow_taxi.homework.optimized_yellow_tripdata'
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT *
FROM `dezoomcamp_yellow_taxi.homework.optimized_yellow_tripdata`;