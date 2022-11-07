with cte as (
SELECT
	sum([SalesAmount]) as amount,
	[OrderDate] as d
  FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
  group by [OrderDate])

  select
  amount,
  avg(amount) over (order by d
  rows between 3 preceding and current row)
  ,d as OrderDate
  from cte
  order by d