WITH movie_rental_duration_cte AS
(SELECT
film.film_id,
title,
DATE_PART('day', return_date - rental_date)+1 AS film_duration_days
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id)
SELECT 
COUNT(film_id) AS count_rental,
SUM(film_duration_days) AS sum_duration_day,
title AS movie_title
FROM movie_rental_duration_cte
GROUP BY film_id, title
ORDER BY count_rental DESC
