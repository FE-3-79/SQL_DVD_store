SELECT film.title AS movie_titel,
rating,
COUNT (DISTINCT rental.rental_id) AS movie_count_rental,
SUM(amount) AS total_payment
FROM customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
INNER JOIN rental ON rental.rental_id = payment.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id
INNER JOIN film_category ON film.film_id = film_category.film_id
GROUP BY film.title, film.rating
ORDER BY total_payment DESC
