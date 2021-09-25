SELECT
  address.city,
  address.country,
  COUNT(1) AS customer_count
FROM public.customer AS customer
LEFT JOIN {{ ref("full_address") }} AS address
  ON address.address_id = customer.address_id
GROUP BY address.city, address.country
