SELECT
  address.address_id,
  address.address,
  address.address2,
  address.district,
  city.city,
  country.country,
  address.postal_code,
  address.phone
FROM
  public.address AS address
  LEFT JOIN public.city AS city
    ON city.city_id = address.city_id
  LEFT JOIN public.country AS country
    ON country.country_id = city.country_id
