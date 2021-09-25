SELECT
  release_year,
  COUNT(1) AS release_count
FROM public.film
GROUP BY release_year
