WITH country_customer_id_cte AS
(SELECT
country.country,
customer.customer_id,
payment_id,
amount
FROM customer
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country ON country.country_id = city.country_id
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY 
customer.customer_id,
country.country,
payment_id
ORDER BY country.country ASC)
SELECT 
COUNT(payment_id) AS count_costumer_invoice,
country,
customer_id,
SUM (amount) as sum_amount_paid
FROM country_customer_id_cte
GROUP BY customer_id, country_customer_id_cte.country
ORDER BY count_costumer_invoice DESC
