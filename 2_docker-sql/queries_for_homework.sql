-- homework week 1

-- 3 How many taxi trips were there on January 15?
select count(*)
from yellow_taxi_data ytd
where cast(tpep_pickup_datetime as date) = '2021-01-15'


-- 4 On which day it was the largest tip in January? (note: it's not a typo, it's "tip", not "trip")

select cast(tpep_dropoff_datetime as date) as day
		, count(*)
from yellow_taxi_data ytd 
where extract(day from cast(tpep_dropoff_datetime as date)) in (1, 4, 20, 21)
group by cast(tpep_dropoff_datetime as date) 
order by count(*) desc


--5 Most popular destination *

select zdo."Zone"
, count(*)
from yellow_taxi_data ytd 
inner join zones zdo on zdo."LocationID" = ytd."DOLocationID" 
inner join zones zpu on zpu."LocationID" = ytd."PULocationID" 
where zpu."Zone" = 'Central Park'
and cast(ytd.tpep_pickup_datetime as date) = '2021-01-14'
group by zdo."Zone"
order by count(*) desc

-- 6 Most expensive route *
select concat(zpu."Zone" , '/', zdo."Zone" ) as route
, avg(ytd.total_amount) 
from yellow_taxi_data ytd 
inner join zones zdo on zdo."LocationID" = ytd."DOLocationID" 
inner join zones zpu on zpu."LocationID" = ytd."PULocationID" 
where concat(zpu."Zone" , '/', zdo."Zone" ) in ('Union Sq/Canarsie', 'Borough Park/NV', 'Alphabet City/Unknown', 'Central Park/Upper East Side North')
group by route
order by avg(ytd.total_amount) desc