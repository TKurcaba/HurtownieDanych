with cte as (
select
[OrganizationKey],
sum([Amount]) as Amount
from [AdventureWorksDW2019].[dbo].[FactFinance]
where year([Date]) = 2012
group by [OrganizationKey]
)

select distinct do.[OrganizationKey], do.[OrganizationName], cte.Amount as TotalAmount,
PERCENT_RANK() over (order by Amount) as percentile,
STDEV([Amount]) over (order by [Amount]) as std_dev
from cte 
join [AdventureWorksDW2019].[dbo].[DimOrganization] do on do.OrganizationKey = cte.OrganizationKey
order by [OrganizationKey]