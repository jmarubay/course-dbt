SELECT
    product_guid,
    name AS product_name,
    price,
    inventory

FROM {{ ref('stg_postgres__products') }} 