SELECT COUNT (film_id) AS movie_titel,
language.language_id,
language.name,
film.length
FROM film
INNER JOIN language ON film.language_id = language.language_id
GROUP by language.name, language.language_id, language, film.length
ORDER by length DESC

