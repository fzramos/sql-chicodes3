-- Question 1: List all customers who live in Texas(use JOINs)
-- Need to got from customer to address district column
-- bridge will be address_id
SELECT * 
FROM address;
SELECT *
FROM customer;

SELECT CONCAT_WS(' ', first_name, last_name, 'is from', district) texas_customers
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district LIKE 'Texas';

-- Question 2: Get all payments above $6.99 with the
-- Customer's Full Name
-- need to join customer and payment
SELECT CONCAT_WS(' ', first_name, last_name) full_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- Question 3: Show all customers names who have made payments
-- over $175 (use subquery)
SELECT CONCAT_WS(' ', first_name, last_name) full_name
FROM customer
WHERE customer_id = (
	SELECT amount
	FROM payment
	WHERE amount > 175
);
-- testing the subquery alone to make sure it works
SELECT customer_id, SUM(amount) AS suma
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175;

SELECT CONCAT_WS(' ', first_name, last_name) full_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

-- Question 4: List all customers that live in Nepal
-- (use the city table)
SELECT *
FROM country
WHERE country LIKE 'Nepal';

SELECT CONCAT_WS(' ', first_name, last_name) Nepal_customers
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country LIKE 'Nepal';

-- Question 5: Which staff member had the most transactions?
-- plan: go to rental table, count rental ids by staff_id then
-- then join it with staff names in staff table
SELECT CONCAT_WS(' ', first_name, last_name) staff_member, COUNT(rental.rental_id) AS sales
FROM rental
INNER JOIN staff
ON rental.staff_id = staff.staff_id
GROUP BY staff.staff_id
LIMIT 1;

-- Question 6: How many movies of each rating are there?
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating;

-- Question 7: Show all customers who have made a single payment
-- above $6.99
SELECT CONCAT_WS(' ', first_name, last_name) full_name
FROM customer
WHERE customer.customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
);

-- Question 8: How many free rentals did our stores give away?
-- This question is asking how many rentals do not have an
-- associated payment
-- use a exclusive left join including only the rental id values
-- no in payment table
SELECT COUNT(rental.rental_id) free_rentals
FROM rental
LEFT JOIN payment
ON payment.rental_id = rental.rental_id
WHERE payment IS NULL;


