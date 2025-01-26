1. 24.3.1
2. postgres:localhost2. postgres:localhost
3. 104,802; 198,924; 109,603; 27,678; 35,189 
   sql query
	select 
  sum(case when trip_distance <= 1 then 1 else 0 end) as lt_1,
  sum(case when trip_distance > 1 and trip_distance <= 3 then 1 else 0 end) as bw_1_3,
  sum(case when trip_distance > 3 and trip_distance <= 7 then 1 else 0 end) as bw_3_7,
  sum(case when trip_distance > 7 and trip_distance <= 10 then 1 else 0 end) as bw_7_10,
  sum(case when trip_distance > 10 then 1 else 0 end) as gt_10
from green_taxi_data
where lpep_pickup_datetime >= '2019-10-01' and lpep_dropoff_datetime < '2019-11-01';

4. 2019-10-31

select date_trunc('day', lpep_pickup_datetime), max(trip_distance) 
from green_taxi_data 
group by date_trunc('day', lpep_pickup_datetime)
order by max(trip_distance) desc;

5. East Harlem North, East Harlem South, Morningside Heights

select tz."Zone", sum(total_amount) 
from green_taxi_data gtd join taxi_zone tz on gtd."PULocationID" = tz."LocationID"
where date_trunc('day', lpep_pickup_datetime) = '2019-10-18'
group by tz."Zone"
order by sum(total_amount) desc;

6. JFK Airport

select dtz."Zone", gtd.tip_amount 
from green_taxi_data gtd join taxi_zone ptz on gtd."PULocationID" = ptz."LocationID" 
join taxi_zone dtz on gtd."DOLocationID" = dtz."LocationID"
where date_trunc('month', lpep_pickup_datetime) = '2019-10-01'
and ptz."Zone" = 'East Harlem North'
order by gtd.tip_amount desc
limit 5;


