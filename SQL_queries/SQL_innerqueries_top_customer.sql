-- QUERY ONE .................................................................................................................................
-- top 10 countries based on the count of costumers
SELECT country.country_id,
	COUNT(customer.customer_id) AS count_customer
	FROM customer
INNER JOIN address ON customer.address_id = address.address_id 
INNER JOIN city ON  address.city_id = city.city_id 
INNER JOIN country ON  city.country_id = country.country_id
GROUP BY country.country_id
ORDER BY count_customer DESC
LIMIT 10


-- QUERY TWO .................................................................................................................................
-- top 10 cities from the  | top countries based on the count of costumers

SELECT city.city_id,
	COUNT (city.city_id) AS count_city,
	country.country_id
	FROM customer
INNER JOIN address ON customer.address_id = address.address_id 
INNER JOIN city ON  address.city_id = city.city_id 
INNER JOIN country ON  city.country_id = country.country_id
--  ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– include QUERY ONE top 10 countries based on the count of costumers
INNER JOIN (
	SELECT country.country_id,
	COUNT(customer.customer_id) AS count_customer
	FROM customer
	INNER JOIN address ON customer.address_id = address.address_id 
	INNER JOIN city ON  address.city_id = city.city_id 
	INNER JOIN country ON  city.country_id = country.country_id
	GROUP BY country.country_id
	ORDER BY count_customer DESC
	LIMIT 10) AS table_top10counries ON table_top10counries.country_id = country.country_id 
--  –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– END OF QUERY ONE 
GROUP BY country.country_id, city.city_id, table_top10counries
ORDER BY count_city DESC
LIMIT 10


-- QUERY THREE .................................................................................................................................
-- the top 5 customer | of top 10 cities from the | top countries based on the count of costumers

SELECT customer.customer_id,
	   customer.last_name,
	   customer.first_name,
	   city.city_id,
	   country.country_id,
	   SUM(amount) AS total_amount_paid
FROM customer
INNER JOIN address ON customer.address_id = address.address_id 
INNER JOIN city ON  address.city_id = city.city_id 
INNER JOIN country ON  city.country_id = country.country_id
INNER JOIN payment ON customer.customer_id = payment.customer_id
INNER JOIN 
--  ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– include QUERY TWO top 10 cities from the  | top countries based on the count of costumers
	(SELECT city.city_id,
		COUNT (city.city_id) AS count_city,
		country.country_id
		FROM customer
	INNER JOIN address ON customer.address_id = address.address_id 
	INNER JOIN city ON  address.city_id = city.city_id 
	INNER JOIN country ON  city.country_id = country.country_id
--  ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– include QUERY ONE top 10 countries based on the count of costumers
		INNER JOIN (
			SELECT country.country_id,
			COUNT(customer.customer_id) AS count_customer
			FROM customer
			INNER JOIN address ON customer.address_id = address.address_id 
			INNER JOIN city ON  address.city_id = city.city_id 
			INNER JOIN country ON  city.country_id = country.country_id
			GROUP BY country.country_id
			ORDER BY count_customer DESC
			LIMIT 10) AS table_top10countries ON table_top10countries.country_id = country.country_id 
-- –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– END OF QUERY ONE
	GROUP BY country.country_id, city.city_id, table_top10countries
	ORDER BY count_city DESC
	LIMIT 10) AS table_top10cities ON table_top10cities.city_id = address.city_id 
--  ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– END OF QUERY TWO
	GROUP BY customer.customer_id,
	   customer.last_name,
	   customer.first_name,
	   city.city_id,
	   country.country_id
ORDER BY total_amount_paid DESC
LIMIT 5