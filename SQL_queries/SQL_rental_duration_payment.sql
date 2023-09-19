SELECT 
DATE_PART('year', payment_date) AS payment_year,
payment_id,
rental.customer_id,
rental.rental_id,
amount,
DATE_PART('day', return_date - rental_date)+1 AS film_duration_days
FROM rental
INNER JOIN payment ON payment.rental_id = rental.rental_id