-- 1. List all customers who live in Texas (use JOINs)
select customer.customer_id, first_name, last_name, address.district
from customer
left join address
on address.address_id = customer.address_id
where address.district = 'Texas'
-- 5 Customers

-- 2. Get all payments above $6.99 with the Customer's Full Name
select customer.customer_id, first_name, last_name, payment.amount
from customer
left join payment
on customer.customer_id = payment.customer_id
where payment.amount > 6.99
order by customer_id desc;
-- 1406 Payments

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT store_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id, first_name, last_name;
-- 6 Customers

-- 4. List all customers that live in Nepal (use the city table)
select first_name, last_name
from customer
where address_id in(
	select address_id
	from address
	where city_id in(
		select city_id
		from city
		where country_id in(
			select country_id
			from country
			where country = 'Nepal'
		)
	)
);
-- 1 Customer

-- 5. Which staff member had the most transactions?
select first_name, last_name, staff.staff_id, count(staff.staff_id)
from staff
left join payment
on payment.staff_id = staff.staff_id
group by staff.staff_id
-- Jon Stephens


-- 6. How many movies of each rating are there?
select rating, count(rating)
from film
group by rating;
-- G: 178, PG: 194, PG-13: 223, R: 195, NC-17: 210

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT store_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	where amount > 6.99
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id, first_name, last_name;
-- 130 Customers, not working

-- 8. How many free rentals did our stores give away?
select *
from payment
where amount = 0.00
-- 24