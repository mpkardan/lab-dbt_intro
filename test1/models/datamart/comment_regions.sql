

{# THIS IS A TEST #}

{{
  config(
    materialized="incremental",
    unique_key="id",
  )
}}
SELECT
  comment.id,
  comment.customer_id,
  address.city,
  address.country,
  address.postal_code,
  comment.body
FROM
  public.comment AS comment
  LEFT JOIN public.customer AS customer
    ON customer.customer_id = comment.customer_id
  LEFT JOIN {{ ref("full_address") }} AS address
    ON address.address_id = customer.address_id
{% if is_incremental() %}
WHERE comment.id > (SELECT MAX(id) FROM {{ this }})
{% endif %}
