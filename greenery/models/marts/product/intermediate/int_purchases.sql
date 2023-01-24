WITH events AS (
    SELECT * FROM {{ ref('fct_events') }}
),

order_items AS (
    SELECT * FROM {{ ref('stg_postgres__order_items') }}
)

SELECT
    oi.product_guid,
    cast(COUNT(DISTINCT e.session_guid) AS numeric) AS total_purchases
FROM 
    events AS e
LEFT JOIN
    order_items AS oi
USING
    (order_guid)
WHERE 
    e.order_guid IS NOT NULL 
GROUP BY 1