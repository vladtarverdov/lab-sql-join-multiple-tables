/* 
Lab | SQL Joins on multiple tables
In this lab, you will be using the Sakila database of movie rentals.

Instructions
Write a query to display for each store its store ID, city, and country.
Write a query to display how much business, in dollars, each store brought in.
What is the average running time of films by category?
Which film categories are longest?
Display the most frequently rented movies in descending order.
List the top five genres in gross revenue in descending order.
Is "Academy Dinosaur" available for rent from Store 1?
*/
use sakila;

 -- 1. Write a query to display for each store its store ID, city, and country.
 select s.store_id, c.city_id, c.city, c.country_id, co.country
 from store s
 join address a
 on s.address_id = s.address_id
 join city c
 on c.city_id = a.city_id
 join country co
 on c.country_id = co.country_id
 order by country;
 
 
 -- 2 Write a query to display how much business, in dollars, each store brought in.
 select c.store_id, sum(p.amount) as store_brought
 from customer c
 join payment p
 on c.customer_id = p.customer_id
 group by c.store_id;
 
 
 
-- 3. What is the average running time of films by category?
select avg(f.length) as average_length, c.name category
from film f
join film_category film_cat
on f.film_id = film_cat.film_id
join category c
on film_cat.category_id = c.category_id
group by c.name;


-- 4. Which film categories are longest?
select max(f.length) as maximum_length, c.name category
from film f
join film_category film_cat
on f.film_id = film_cat.film_id
join category c
on film_cat.category_id = c.category_id
group by c.name;

 
 -- 5. Display the most frequently rented movies in descending order.
 select count(f.film_id), f.film_id, f.title
 from film f
 join inventory i
 on f.film_id = i.film_id 
 join rental r
 on r.inventory_id = i.inventory_id
 group by f.film_id, f.title;
 
 
 
 -- 6. List the top five genres in gross revenue in descending order.
 select sum(amount) as Gross_Revenue,
 c.name as Genre 
 from payment p 
 join rental r 
 on p.rental_id = r.rental_id
 join inventory i 
 on r.inventory_id = i.inventory_id
 join film_category fc 
 on i.film_id = fc.film_id
 join category c 
 on fc.category_id = c.category_id
 group by c.name
 order by SUM(amount) desc
 limit 5;
 
 
 -- 6. Is "Academy Dinosaur" available for rent from Store 1?
select f.film_id, f.title, s.store_id, i.inventory_id
from inventory i
join store s
using store_id
join film f
where f.title = 'Academy Dinosaur' and store.store_id = 1;
 
 SELECT r.rental_date, r.return_date, r.last_update, r.inventory_id
FROM film f
LEFT JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
WHERE f.title = ‘ACADEMY DINOSAUR’ AND i.store_id = 1
ORDER BY 3 DESC;
 
 
 
 
 
 