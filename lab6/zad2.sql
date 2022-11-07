SELECT *
FROM  
(
  SELECT 
  [SalesTerritoryKey],
  MONTH([OrderDate]) as order_month,
  sum([SalesAmount]) as SalesAmount
  FROM  [AdventureWorksDW2019].[dbo].[FactInternetSales]
  where YEAR([OrderDate]) = 2011
  group by 
  MONTH([OrderDate]),[SalesTerritoryKey]
  
) AS SourceTable  
PIVOT  
(  
  SUM([SalesAmount])  
  FOR [SalesTerritoryKey] IN ([1], [2], [3], [4]  , [5] , [6] , [7] , [8] , [9] , [10] ) 

) AS PivotTable;  