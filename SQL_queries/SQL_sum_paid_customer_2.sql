/*Get customer count and total payment received against each country */
SELECT country.country,
COUNT(DISTINCT payment.customer_id) AS customer_count,
SUM(amount) AS total_amount_paid
FROM customer
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country ON country.country_id = city.country_id
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY country.country
ORDER BY total_amount_paid DESC
