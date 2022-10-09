--Zadanie 1
--Na podstawie dostarczonych danych proszę wyznaczyć średnią kwotę zamówienia w dniu 18 Lutego 2015. 

with temp_table as (
SELECT od.order_id, sum(p.price) price_sum, o.date as order_date
	FROM [cwiczenia1].[dbo].[order_details] od
	join pizzas p on p.pizza_id=od.pizza_id
	join orders o on o.order_id=od.order_id
	where o.date='2015-02-18'
	group by od.order_id, o.date
)

SELECT avg(price_sum) as average_order_amount, order_date
FROM temp_table
GROUP BY order_date;



--zadanie 2
--Pizzeria planuje wdrożenie programu lojalnościowego dla klientów którzy nigdy nie zamówili 
--pizzy z ananasem w Marcu 2015. Proszę o stworzenie tabeli z id takich zamówień. (przydatna 
--funkcja string_agg)

with result_table_2 as (
	SELECT od.order_id, string_agg(pt.ingredients, ',' ) as ingredients, o.date as order_date
	FROM [cwiczenia1].[dbo].[order_details] od
	join pizzas p on p.pizza_id=od.pizza_id
	join orders o on o.order_id=od.order_id
	join pizza_types pt on p.pizza_type_id=pt.pizza_type_id
	group by od.order_id,o.date 

)
	
SELECT order_id FROM result_table_2
WHERE MONTH(order_date) = 3 AND 'Pineapple' not in (SELECT ingredients FROM result_table_2);



--zadanie 3
--Pizzeria planuje nagrodzić klientów o najwyższych zamówieniach bonami kwotowymi. Proszę 
--przygotować tabelę z id 10 największych zamówień dla lutego wraz z ich kwotą przy użyciu 
--funkcji rank () over.


with result_table_3 as (
	SELECT 
	od.order_id,
	o.date as order_date,
	RANK() OVER ( ORDER BY  sum(p.price * od.quantity) desc) rank_place,
	sum(p.price * od.quantity) as total_price
	FROM [cwiczenia1].[dbo].[order_details] od
	join pizzas p on p.pizza_id=od.pizza_id
	join orders o on o.order_id=od.order_id
	WHERE MONTH(o.date) = 2
	GROUP BY od.order_id, o.date

)

SELECT TOP 10 order_id ,total_price FROM result_table_3
ORDER BY total_price DESC;


--zadanie 4
--stworzyć tabelę która pokaże kwotę każdego zamówienia w jednej kolumnie wraz z id 
--zamówienia w drugiej, oraz średniej kwocie zamówienia dla każdego miesiąca w formacie
--jak poniżej(w tym przypadku Common Table Expressions mogą okazać się szczególnie przydatne):


with result_table_4 as (
	SELECT 
	od.order_id,
	sum(p.price * od.quantity) as order_amount,
	o.date as order_date,
	MONTH(o.date) as order_month
	FROM [cwiczenia1].[dbo].[order_details] od
	join pizzas p on p.pizza_id=od.pizza_id
	join orders o on o.order_id=od.order_id
	group by od.order_id, o.date
),
average_for_month as (
	SELECT avg(order_amount) as average_order_amount, MONTH(order_date) as order_month
	FROM result_table_4 
	GROUP BY MONTH(order_date)
)

SELECT order_id, order_amount, average_order_amount, order_date FROM result_table_4 r
JOIN average_for_month avgM ON r.order_month = avgM.order_month;


--Zadanie 5
--Proszę przygotować tabelę z listą pokazującą liczbę zamówień dla danej pełnej godziny w dniu 
--1 Stycznia 2015 tak jak poniżej (proszę zaokrąglać do pełnych godzin w dół tj. 11:59 będzie 11):


with result_table_5 as (
	SELECT 
	count(od.order_id) as order_count,
	o.date as order_date,
	DATEPART(hh,o.time) as order_hour
	FROM [cwiczenia1].[dbo].[order_details] od
	join pizzas p on p.pizza_id=od.pizza_id
	join orders o on o.order_id=od.order_id
	WHERE o.date = '2015-01-01'
	group by od.order_id, o.date,o.time
)
SELECT count(order_count) as order_count, order_date, order_hour FROM result_table_5
GROUP BY order_date, order_hour ORDER BY order_hour;


--Zadanie 6
--Proszę wykonać tabelę z popularnością danych rodzajów pizzy w miesiącu Styczniu 2015. 
--Ma ona pokazywać ilość sprzedanych rodzajów pizz bez rozróżnienia na jej rozmiary.
--Tabela ma zawierać nazwę każdej pizzy oraz jej kategorię. 
	


with result_table_6 as (
	SELECT 
	od.quantity, pt.pizza_type_id, pt.name, pt.category
	FROM [cwiczenia1].[dbo].[order_details] od
	join pizzas p on p.pizza_id=od.pizza_id
	join orders o on o.order_id=od.order_id
	join pizza_types pt on p.pizza_type_id=pt.pizza_type_id
	WHERE MONTH(o.date) = 1 AND YEAR(o.date) = 2015

)

SELECT count(quantity) as amount, name, category FROM result_table_6
GROUP BY name,category;


--Zadanie 7 Proszę przygotować tabelę która zobrazuje popularność każdego rozmiaru 
--pizzy w miesiącu Lutym oraz Marcu 2015w formacie zbliżonym do tego poniższego:
with result_table_7 as (
	SELECT 
	p.size, COUNT(p.pizza_type_id) as amount 
	FROM [cwiczenia1].[dbo].[order_details] od
	join pizzas p on p.pizza_id=od.pizza_id
	join orders o on o.order_id=od.order_id
	join pizza_types pt on p.pizza_type_id=pt.pizza_type_id
	WHERE (MONTH(o.date) = 2 OR MONTH(o.date) = 3 ) AND YEAR(o.date) = 2015
	GROUP BY p.size

)
SELECT * FROM result_table_7 
ORDER BY
  case size
  when 'S' then 1
  when 'M' then 2
  when 'L' then 3
  when 'XL' then 4
  else 5
  end