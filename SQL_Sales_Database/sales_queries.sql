-- 1. Determine for each order the order value's proportion of the total revenue.

WITH TotalSales as
    (select *,
    sum(value) OVER () as TotalRevenue
    from sales )
select *,  value *1.0 /TotalRevenue  as proportion 
from TotalSales

--2. Determine for each order the order value's proportion of the customer's total revenue.
	
go 
WITH TotalSalesPerCust (cust, ToTRevenue) as 
	(select cust, sum (value) TotRevenue
	FROM sales
	group by cust)
	select s.cust, date, value, value *1.0/TotRevenue as proportion
	from sales s
join TotalSalesPerCust tsc
	on s.cust = tsc.cust

-- 3. Determine for each customer the customer's proportion of the total revenue.
	-- Find total Revenue
	go

	select cust, sum (value) *1.0 / (select sum (value) TotRev
	from sales)
	from sales
	group by cust




-- 4. Determine for each customer, 
--for each month the month's proportion of the customer's total revenue.

go
with CustRevenue (cust, tot) as 
		(select cust,  sum (value) as tot
		from sales
		group by cust),

revPerMonth (cust, month, TotRev) as
		(select cust, MONTH (date) month,  sum(value)  as TotRev
		 from sales
		 group by cust, MONTH (date))

select revPerMonth.cust, month , TotRev, TotRev * 1.0/ tot as prop
FROM CustRevenue, revPerMonth

-- 5. Determine for each customer, for each month the customer's proportion of the monthly revenue.

go
 with totRev (cust, date, value, monthlyrev, revMonth )  as
	 (select *,
	 sum(value) over (partition by month(date), cust) as monthlyrev,
	 sum (value) over (partition by month(date)) as revMonth
	from sales)
	select  distinct cust, month(date) month , monthlyrev, monthlyrev * 1.0/revMonth proportion
	from totRev

-- 6. Determine the cumulative revenue per order. -- 
go
SELECT *,
	SUM(Value) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as runningTotal
FROM sales;


-- 7  Determine for each customer the cumulative customer revenue, per order.
go
select *,
	sum(value) OVER (partition by cust order by date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) runningTotal
from sales



-- 8. Determine for each customer the cumulative revenue's proportion of the total revenue of that customer.
go
WITH tot as 
		(select *,
		SUM (value) OVER (PARTITION BY cust) totalRevenue,
		SUM (value) OVER (PARTITION BY cust order by date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) runningTot
		from sales)
		select *, runningTot * 1.0 /totalRevenue proportion
		from tot

-- 9. (*) Determine for each customer the date that he/she passed the threshold of 80% of his/her total order value.

with Threshold as
(
select cust, sum(value) * 0.8 thres
from sales
group by cust
),
cumulative
as
(
select *,
sum(value) over (partition by cust order by date ROWS  BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cum
from sales
),
PassedThres as
(
select c.cust,date,cum,
rank() over (partition by c.cust order by date) rank
from Threshold t inner join cumulative c
on t.cust = c.cust
where cum >= thres
group by c.cust,cum, date
)
select cust, date
from PassedThres
where rank = 1

-- 10. (*) Determine for each customer the ratio of the first month revenue and average monthly revenue.


-- 11. Determine for each customer the number of days between the last two orders.
go
with custRowNumber as 
		(select *,
		ROW_NUMBER () OVER (partition by cust order by date desc) rn
		from sales),
filteredRows as
        (select * 
		from custRowNumber
		where rn <= 2),
daydifference as
		(select distinct cust,
		DATEDIFF (DAY, date, LEAD(date) OVER (partition by cust ORDER BY DATE)) daydiff
		from filteredRows)
select * 
from daydifference
where daydiff is not null



-- 12. Determine for each customer the difference in value between the last two order values.

with lastTwoDate
as
(
select cust,max(date) secondLastDate
from sales
where date not in (select max(date)
from sales
group by cust)
group by cust
),
lastDate
as
(
select cust,max(date) Lastdate
from sales
group by cust
),
secondValue as
(
select s.cust, value SecLastVal
from lastTwoDate ltd inner join sales s
on ltd.secondLastDate= s.date
),
lastValue as
(
select distinct s.cust, value LastVal
from lastDate ld inner join sales s
on ld.Lastdate = s.date
)
select lv.cust, LastVal - SecLastVal
from lastValue lv inner join secondValue sv
on lv.cust = sv.cust

-- 13. Determine for each customer the average number of days between two orders.

	with lagDay
as
(
select cust, date, datediff(day, date,
lag(date) over (partition by cust order by date)) diff
from sales
)
select cust,avg(abs(diff * 1.0))average
from lagDay
group by cust



	-- 14. Determine for each customer the average of the last three order values.
		go
		with lastThreeOrder as
					(select *
					from 
						(select *,
						 ROW_NUMBER () OVER (partition by cust order by date desc ) rn
						 from sales ) d
					where d.rn <= 3)
					select distinct cust, AVG (value * 1.0)  OVER (partition by cust) average
					from lastThreeOrder

-- 15. (*) Determine which customers had never decreasing order values.

-- 16. Determine for each order whether it is over or under the average order value.
	
	go
	with totalorderAvg as 
			(select *, 
			AVG (value * 1.0) OVER () as avgOrderValue
			from sales)
			select *,
				case
					when value > avgOrderValue THEN 'OVER'
					when value < avgOrderValue THEN 'UNDER'
					ELSE 'EQUAL' 
				END as controlcheck
			from totalorderAvg

-- 17. Determine the average order value for each customer having an average order value higher than the average order value of all customers.

	go
	select distinct cust, avgCust, totAvg 
	from 
		(select *,
		AVG(value * 1.0) over () totAvg,
		AVG(value * 1.0) over (partition by cust) avgCust
		from sales) s
		where avgCust > totAvg




-- 18. (*) For each customer, for each order, determine the average order amount of each order, with the two previous orders. (This is a specific type of moving average.)


with Windows as
(
select *,
lag(value) over (partition by cust order by date) lag,
lead(value) over (partition by cust order by date) lead
from sales
)
select (value + lag + lead)*1.0 / 3
from Windows

-- 19. Determine for each month the revenue's growth percentage compared to previous month.

with MonthlyRev
as
(
select month(date) month ,year(date) year, sum(value) Rev
from sales
group by month(date), year(date)
)
select *, Rev * 1.0 / lag(Rev) over (order by year) - 1
from MonthlyRev


-- 20. (*) For each customer, show the week-over-week revenue growth.



-- 21. (*) For each customer, the biggest difference in weekly order value between 
-- 2 subsequent ordering weeks and the week number which that happened.
go
WITH salesyrwk as
(
select *,
        100 * IIF(DATEPART(ISOWW, date) = 1 and datepart(m, date) = 12, 1 + datepart(yy, date),
        iif(datepart(ISOWW, date) > 51 and datepart(m, date) = 1, datepart(yy,date) - 1,
        datepart(yy, date)))+ DATEPART(ISOWW, [date]) yrwk
from sales
),
weeks as
(
select distinct yrwk
from salesyrwk
),
custs as
(
select distinct cust
from sales
),
allcombinations as
(
select *
from custs, weeks
),
weeklyrevpercustomer as
(
select w.cust, w.yrwk,
coalesce(SUM(value),0) total
from allcombinations w
left join salesyrwk s
on  w.cust = s.cust and w.yrwk = s.yrwk
group by w.cust, w.yrwk
),
wklydiff as
(
select cust, yrwk, total,
total - lag(total) over (partition by cust order by yrwk) as diff
from weeklyrevpercustomer
),
maxdiff as
(
select cust, abs(max(diff)) as maxdiff
from wklydiff
group by cust
)



select *
from maxdiff md
inner join wklydiff wd
on md.cust= wd.cust and
wd.diff = md.maxdiff


-- 22. What was the weekday of the previous order for all orders placed on a Friday?

	go
	with weedays as 
			(SELECT *,  
			datename( weekday, date) weekday,
			DATEPART(WEEKDAY, date) weekdayNumb
			FROM SALES)
			select *,
			lag(weekdayNumb) OVER (order by weekdayNumb) previousweekday
			FROM weedays
			where weekdayNumb < 6


with weekday
as
(
select *, DATEPART(WEEKDAY, date) weekday
from sales
),
friday as
(
select *
from weekday
where weekday = 5
),
daybefore as
(
select *,
lag(weekday) over (order by date) DayBefore
from weekday
)
select *
from daybefore
where weekday = 5

-- 23. (*) Determine for each customer the number of days between passing the 40% and the 80% threshold of his/her total order value.	
 
