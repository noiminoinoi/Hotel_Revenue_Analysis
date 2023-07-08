--Merging Data from different Yearly table into hotels CTE

WITH hotels as (
SELECT *
FROM dbo.['2018$']
UNION
SELECT *
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])

--Getting the Revenue per year. The highest revenue is during 2019 in both City Hotel and Resort Hotel.

SELECT arrival_date_year, hotel, ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr),0) AS revenue
FROM hotels
GROUP BY arrival_date_year, hotel
ORDER BY revenue DESC

--Merging with other tables to utilize for Dashboard making using visualization software
WITH hotels as (
SELECT *
FROM dbo.['2018$']
UNION
SELECT *
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])

SELECT *
FROM hotels
LEFT JOIN dbo.market_segment$
ON hotels.market_segment = market_segment$.market_segment
LEFT JOIN dbo.meal_cost$
ON meal_cost$.meal = hotels.meal