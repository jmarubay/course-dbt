WITH events AS (
    SELECT * FROM {{ ref('stg_postgres__events') }}
)

, final AS (
SELECT
    product_guid,
    COUNT(DISTINCT session_guid) AS product_sessions, 
    SUM(CASE WHEN event_type = 'page_view' then 1 else 0 end) AS product_page_views,
    SUM(CASE WHEN event_type = 'add_to_cart' then 1 else 0 end) AS product_add_to_carts
    
FROM {{ ref('stg_postgres__events') }}
GROUP BY 1
HAVING product_guid IS NOT NULL
)


SELECT * FROM final 