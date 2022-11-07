select 
[OrganizationKey], [DepartmentGroupKey],sum([Amount])
from [AdventureWorksDW2019].[dbo].[FactFinance]
group by rollup([OrganizationKey],DepartmentGroupKey)
order by OrganizationKey;

select 
[OrganizationKey], [DepartmentGroupKey],sum([Amount]) as amount
from [AdventureWorksDW2019].[dbo].[FactFinance]
group by cube([OrganizationKey],DepartmentGroupKey)
order by OrganizationKey;
