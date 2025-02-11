-- Homework no-4
SELECT COUNT(*) 
FROM 'dezoomcamp_yellow_taxi.homework.materialized_yellow_tripdata';
WHERE fare_amount = 0;