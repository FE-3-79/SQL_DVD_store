SELECT
film.film_id,
title,
DATE_PART('day', return_date - rental_date)+1 AS film_duration_days
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id
