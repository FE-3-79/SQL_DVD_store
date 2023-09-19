SELECT customer.customer_id,
customer.last_name,
customer.first_name,
city.city,
country.country,
SUM(amount) AS total_amount_paid
FROM customer
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country ON country.country_id = city.country_id
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, first_name,last_name, city, country
ORDER BY total_amount_paid DESC
