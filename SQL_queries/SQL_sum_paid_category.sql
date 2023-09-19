/*Get rating and total payment */
SELECT rating AS name_rating,
SUM(amount) AS total_payment
FROM payment
INNER JOIN rental ON rental.rental_id = payment.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id
INNER JOIN film_category ON film.film_id = film_category.category_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY rating
	
/*Get category and total payment */
SELECT category.name AS name_category,
SUM(amount) AS total_payment
FROM payment
INNER JOIN rental ON rental.rental_id = payment.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id
INNER JOIN film_category ON film.film_id = film_category.category_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY name_category
