SELECT
    product_guid,
    name AS product_name,
    price AS product_price,
    inventory

FROM {{ ref('stg_postgres__products') }} 