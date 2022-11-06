create view carrier_sales with schemabinding as
SELECT fs.[order_details_id]
      ,fs.[order_id]
      ,fs.[pizza_id]
      ,fs.[quantity]
      ,fs.[date]
      ,fs.[time]
      ,cr.[carrier_id]
      ,fs.[customer_key]
	  ,cr.[carrier_name]
      ,cr.[address]
      ,cr.[tax_id]
      ,cr.[contact_person]
  FROM [dbo].[FactSales] fs
  join [dbo].[Carrier] cr on cr.carrier_id = fs.carrier_id

  
create unique clustered index IX_carrier_sales ON
[cwiczenia4_prod].[dbo].[carrier_sales]
([order_details_id]
      ,[order_id]
      ,[pizza_id]
      ,[quantity]
      ,[date]
      ,[time]
      ,[carrier_id]
      ,[customer_key]
      ,[carrier_name]
      ,[address]
      ,[tax_id]
      ,[contact_person]
	  )

