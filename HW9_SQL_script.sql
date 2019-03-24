USE sakila;

#1a
SELECT first_name, last_name FROM actor;
#1b
SELECT CONCAT(first_name, " ", last_name) as Actor_Name
FROM actor;
#2a
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';
#2b
SELECT * FROM actor
WHERE last_name LIKE '%GEN%';
#2c 
SELECT * FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;
#2d
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
#3a
ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_name;
#3b
ALTER TABLE actor
DROP COLUMN description;
#4a
SELECT last_name, COUNT(last_name) AS actor_count
FROM actor
group by last_name;
#4b
SELECT last_name, COUNT(last_name) AS actor_count
FROM actor
group by last_name
HAVING actor_count >= 2;
#4c
SELECT actor_id, first_name, last_name from actor
where first_name = "groucho";
UPDATE actor
SET first_name = 'Harpo'
WHERE actor_id = 172;
#4d
SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';
SET SQL_SAFE_UPDATES=1;
#5a
SHOW CREATE TABLE actor;
#6a
SELECT first_name, last_name, address
FROM staff
INNER JOIN address ON staff.address_id = address.address_id;
#6b
SELECT payment.staff_id, amount, payment_date
FROM staff
INNER JOIN payment ON staff.staff_id = payment.staff_id
HAVING payment_date like "2005-08%";
#6c
SELECT title, film.film_id, actor_id, count(title) as Number_of_Actors
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY title;
#6d
SET sql_mode = ',STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,
NO_ENGINE_SUBSTITUTION';
SELECT film.film_id, title, count(inventory.film_id) AS inventory_count
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.film_id
HAVING film.film_id = 439;
#6e
SELECT payment.customer_id, last_name, first_name, sum(amount) AS total_paid
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer_id
ORDER BY last_name;
#7a
SELECT title
FROM film
WHERE language_id IN
	(SELECT language_id
	FROM language
    WHERE name = 'English'
	)
		AND title LIKE "K%" or title LIKE "Q%"
		;
#7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(SELECT actor_id
    FROM film_actor
    WHERE film_id IN
		(SELECT film_id 
        FROM film
        WHERE title = 'Alone Trip'
	)
       );
#7c
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN
	(SELECT address_id
    FROM address
    WHERE city_id IN
		(SELECT city_id 
        FROM city
        WHERE country_id IN
			(SELECT country_id
            FROM country
            WHERE country = 'CANADA'
            )
		)
	);
#7d
SELECT title, rating
FROM film
WHERE film_id IN
	(SELECT film_id
    FROM film_category
    WHERE category_id IN
		(SELECT category_id
        FROM category
        WHERE name = 'FAMILY'
        )
	);
#7e
SELECT title, COUNT(rental.inventory_id) AS Rental_Count
FROM rental, inventory, film
WHERE inventory.inventory_id = rental.inventory_id
AND inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY Rental_Count desc;


#7f
SELECT SUM(AMOUNT) AS 'STORE 1', (SELECT SUM(AMOUNT) FROM payment WHERE staff_id=2) AS 'STORE 2'
FROM payment
WHERE staff_id = 1;

#7g
SELECT store_id, city, country
FROM store, address, city, country
WHERE store.address_id = address.address_id
AND address.city_id = city.city_id
AND city.country_id = country.country_id;

#8a
CREATE VIEW hw_view AS(
SELECT store_id, city, country
FROM store, address, city, country
WHERE store.address_id = address.address_id
AND address.city_id = city.city_id
AND city.country_id = country.country_id
);
#8b
SELECT * FROM hw_view;
#8c
DROP VIEW hw_view;





