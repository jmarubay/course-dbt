SELECT
     promo_id AS promo_desc,
     discount, 
     status 
 FROM {{ source('postgres', 'promos') }}
