WITH events AS (
    SELECT * FROM {{ ref('stg_postgres__events') }}
)

, final AS (
SELECT
    user_guid,
    session_guid,
    SUM(CASE WHEN event_type = 'add_to_cart' then 1 else 0 end) AS add_to_carts, 
    SUM(CASE WHEN event_type = 'checkout' then 1 else 0 end) AS checkouts, 
    SUM(CASE WHEN event_type = 'package_shipped' then 1 else 0 end) AS packages_shippeds, 
    SUM(CASE WHEN event_type = 'page_view' then 1 else 0 end) AS page_views, 
    MIN(created_at_utc) AS first_session_event_at_utc,
    MAX(created_at_utc) AS last_session_event_at_utc 
    
FROM {{ ref('stg_postgres__events') }}
GROUP BY 1, 2
)


SELECT * FROM final 