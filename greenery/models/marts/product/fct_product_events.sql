WITH events AS (
    SELECT * FROM {{ ref('int_product_events_agg') }}
)
, products AS(
SELECT * FROM {{ ref('int_products') }}
)

SELECT
    events.product_guid,
    products.product_name,
    products.price,
    products.inventory,
    events.product_sessions,
    events.product_page_views,
    events.product_add_to_carts
    
FROM events 
LEFT JOIN products
    ON events.product_guid = products.product_guid
    
