select 
[OrganizationKey], [DepartmentGroupKey],sum([Amount])
from [AdventureWorksDW2019].[dbo].[FactFinance]
group by rollup([OrganizationKey],DepartmentGroupKey)
order by OrganizationKey;

