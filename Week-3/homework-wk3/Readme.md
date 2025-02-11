## Module 3 Homework

ATTENTION: At the end of the submission form, you will be required to include a link to your GitHub repository or other public code-hosting site. 
This repository should contain your code for solving the homework. If your solution includes code that is not in file format (such as SQL queries or 
shell commands), please include these directly in the README file of your repository.

<b><u>Important Note:</b></u> <p> For this homework we will be using the Yellow Taxi Trip Records for **January 2024 - June 2024 NOT the entire year of data** 
Parquet Files from the New York
City Taxi Data found here: </br> https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page </br>
If you are using orchestration such as Kestra, Mage, Airflow or Prefect etc. do not load the data into Big Query using the orchestrator.</br> 
Stop with loading the files into a bucket. </br></br>

**Load Script:** You can manually download the parquet files and upload them to your GCS Bucket or you can use the linked script [here](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/cohorts/2025/03-data-warehouse/load_yellow_taxi_data.py):<br>
You will simply need to generate a Service Account with GCS Admin Priveleges or be authenticated with the Google SDK and update the bucket name in the script to the name of your bucket<br>
Nothing is fool proof so make sure that all 6 files show in your GCS Bucket before begining.</br><br>

<u>NOTE:</u> You will need to use the PARQUET option files when creating an External Table</br>

<b>BIG QUERY SETUP:</b></br>
Create an external table using the Yellow Taxi Trip Records. </br>
Create a (regular/materialized) table in BQ using the Yellow Taxi Trip Records (do not partition or cluster this table). </br>
</p>

## Question 1:
Question 1: What is count of records for the 2024 Yellow Taxi Data? <br>
(1) 65,623 <br>
(2) 840,402 <br>
(3) 20,332,093 <br>
(4) 85,431,289 <br>

--> My Answer: option number 3

## Question 2:
Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.</br> 
What is the **estimated amount** of data that will be read when this query is executed on the External Table and the Table? <br>
(1) 18.82 MB for the External Table and 47.60 MB for the Materialized Table <br>
(2) 0 MB for the External Table and 155.12 MB for the Materialized Table <br>
(3) 2.14 GB for the External Table and 0MB for the Materialized Table <br>
(4) 0 MB for the External Table and 0MB for the Materialized Table <br>

--> My Answer: option number 2

## Question 3:
Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table. Why are the estimated number of Bytes different?
(1) BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires 
reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed.
(2) BigQuery duplicates data across multiple storage partitions, so selecting two columns instead of one requires scanning the table twice, 
doubling the estimated bytes processed.
(3) BigQuery automatically caches the first queried column, so adding a second column increases processing time but does not affect the estimated bytes scanned.
(4) When selecting multiple columns, BigQuery performs an implicit join operation between them, increasing the estimated bytes processed

--> My Answer: option number 1

## Question 4:
How many records have a fare_amount of 0? <br>
(1) 128,210 <br>
(2) 546,578 <br>
(3) 20,188,016 <br>
(4) 8,333 <br>

--> My Answer: option number 4

## Question 5:
What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy) <br>
(1) Partition by tpep_dropoff_datetime and Cluster on VendorID <br>
(2) Cluster on by tpep_dropoff_datetime and Cluster on VendorID <br>
(3) Cluster on tpep_dropoff_datetime Partition by VendorID <br>
(4) Partition by tpep_dropoff_datetime and Partition by VendorID <br>

--> My Answer: option number 1

## Question 6:
Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime
2024-03-01 and 2024-03-15 (inclusive)</br>
Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values? </br>
Choose the answer which most closely matches. </br> 
(1) 12.47 MB for non-partitioned table and 326.42 MB for the partitioned table <br>
(2) 310.24 MB for non-partitioned table and 26.84 MB for the partitioned table <br>
(3) 5.87 MB for non-partitioned table and 0 MB for the partitioned table <br>
(4) 310.31 MB for non-partitioned table and 285.64 MB for the partitioned table <br>

--> My Answer: option number 2

## Question 7: 
Where is the data stored in the External Table you created? <br>
(1) Big Query <br>
(2) Container Registry <br>
(3) GCP Bucket <br>
(4) Big Table <br>

--> My Answer: option number 3

## Question 8:
It is best practice in Big Query to always cluster your data: <br>
(1) True
(2) False

--> My Answer: option number 2

## (Bonus: Not worth points) Question 9:
No Points: Write a `SELECT count(*)` query FROM the materialized table you created. How many bytes does it estimate will be read? Why?
```
SELECT COUNT(*)
FROM 'dezoomcamp_yellow_taxi.homework.materialized_yellow_tripdata';
-- bytes processed: 0 bytes
```
