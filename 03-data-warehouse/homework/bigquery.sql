CREATE SCHEMA `dez-bigquery-sandbox.taxi_data`;


create or replace external table `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024_external`
options (
  format='PARQUET',
  uris = ['gs://dez-bigquery-sandbox/data/yellow_tripdata_2024-*.parquet']
);

select count(1) from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024_external`;

create or replace table `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024`
as select * from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024_external`;

-- Q2 
select count(distinct(PULocationID)) from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024_external`;

select count(distinct(PULocationID)) from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024`;

-- Q3
select PULocationID from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024`;

select PULocationID, DOLocationID from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024`;

-- Q4
select count(1) from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024` 
where fare_amount = 0;

-- Q5

create or replace table `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024_dropoff_partitioned`
partition by date(tpep_dropoff_datetime)
cluster by VendorID as 
(select * from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024`);

-- Q6 

select distinct(VendorID)
from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024`
where date(tpep_dropoff_datetime) between '2024-03-01' and '2024-03-15';

select distinct(VendorID)
from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024_dropoff_partitioned`
where date(tpep_dropoff_datetime) between '2024-03-01' and '2024-03-15';


-- Bonus

select count(*) from `dez-bigquery-sandbox.taxi_data.yellow_tripdata_2024`;
