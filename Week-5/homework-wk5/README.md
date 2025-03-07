# Module 5 Homework

In this homework we'll put what we learned about Spark in practice.

For this homework we will be using the Yellow 2024-10 data from the official website: 

```bash
wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-10.parquet
```


## Question 1: Install Spark and PySpark

- Install Spark
- Run PySpark
- Create a local spark session
- Execute spark.version.

What's the output? 

--> My Answer: 
- (From Video) Spark version 3.0.3
- (Personal Setup) The current spark version is 3.5.0

> [!NOTE]
> To install PySpark follow this [guide](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/05-batch/setup/pyspark.md)


## Question 2: Yellow October 2024

Read the October 2024 Yellow into a Spark Dataframe.

Repartition the Dataframe to 4 partitions and save it to parquet.

What is the average size of the Parquet (ending with .parquet extension) Files that were created (in MB)? Select the answer which most closely matches. <br>
(1) 6MB <br>
(2) 25MB <br>
(3) 75MB <br>
(4) 100MB <br>

--> My Answer: option number 2

## Question 3: Count records 

How many taxi trips were there on the 15th of October?

Consider only trips that started on the 15th of October. <br>
(1) 85,567 <br>
(2) 105,567 <br>
(3) 125,567 <br>
(4) 145,567 <br>

--> My Answer: option number 3 (128893)

## Question 4: Longest trip

What is the length of the longest trip in the dataset in hours? <br>
(1) 122 <br>
(2) 142 <br>
(3) 162 <br>
(4) 182 <br>

--> My Answer: option number 3 (6 days)

## Question 5: User Interface

Spark’s User Interface which shows the application's dashboard runs on which local port?
(1) 80 <br>
(2) 443 <br>
(3) 4040 <br>
(4) 8080 <br>

--> My Answer: option number 4

## Question 6: Least frequent pickup location zone

Load the zone lookup data into a temp view in Spark:

```bash
wget https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv
```

Using the zone lookup data and the Yellow October 2024 data, what is the name of the LEAST frequent pickup location Zone? <br>
(1) Governor's Island/Ellis Island/Liberty Island <br>
(2) Arden Heights <br>
(3) Rikers Island <br>
(1) Jamaica Bay <br>

--> My Answer: option number 1
