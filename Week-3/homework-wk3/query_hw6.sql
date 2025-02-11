-- Homework no-6
SELECT DISTINCT VendorID
FROM 'dezoomcamp_yellow_taxi.homework.materialized_yellow_tripdata'
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';

SELECT DISTINCT VendorID
FROM 'dezoomcamp_yellow_taxi.homework.optimized_yellow_tripdata`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';