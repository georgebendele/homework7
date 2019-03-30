USE sakila;

SELECT first_name, last_name
FROM actor;

SELECT CONCAT(first_name," ", last_name)
FROM actor;

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%GEN%";

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;  

SELECT country_id, country
FROM country
WHERE country in ("Afghanistan", "Bangladesh", "China");

ALTER TABLE actor
ADD description BLOB; 

ALTER TABLE actor DROP description;

SELECT last_name, COUNT(actor_id)
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(*) count
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 2;

UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "Williams";

UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

CREATE TABLE address(
				address_id INT AUTO_INCREMENT PRIMARY KEY,
                address VARCHAR(255),
                address2 VARCHAR(255),
                district VARCHAR(255),
                city_id INTEGER,
                postal_code VARCHAR(255),
                phone VARCHAR(255),
                location VARCHAR(255),
                last_update DATETIME
                );
         

SELECT first_name, last_name, address
FROM staff
JOIN address;

SELECT first_name, last_name, SUM(amount)
FROM staff
JOIN payment
WHERE payment_date LIKE ("2005-08%")
GROUP BY last_name, first_name;

SELECT title, COUNT(actor_id)
FROM film
INNER JOIN film_actor on film.film_id = film_actor.film_id
GROUP BY title;

SELECT COUNT(inventory_id)
FROM inventory
JOIN film ON film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible";

SELECT customer.first_name, customer.last_name, SUM(payment.amount)
FROM customer
JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY customer.last_name, customer.first_name;

SELECT film.title
FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%' AND title IN
		(
		SELECT title
		FROM film
		WHERE language_id IN
			(
			SELECT language_id
			FROM language
			WHERE name = "English"
			)
		);

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(SELECT actor_id
	FROM film_actor
	WHERE film_id IN
		(SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
		)
	);

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = "Canada";

SELECT film.title, category.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Family";

SELECT title, rental_date
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
ORDER BY rental_date DESC
LIMIT 10;

SELECT store.store_id, SUM(payment.amount)
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY store.store_id;

SELECT category.name, SUM(payment.amount)
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
LIMIT 5;

CREATE VIEW Top_Genres AS
SELECT category.name, SUM(payment.amount)
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
LIMIT 5;

SELECT * FROM Top_Genres;

DROP VIEW Top_Genres;