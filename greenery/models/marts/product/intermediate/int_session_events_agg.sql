WITH events AS (
    SELECT * FROM {{ ref('fct_events') }}
)

, final AS (
SELECT
    user_guid,
    session_guid,
    SUM(CASE WHEN event_type = 'add_to_cart' then 1 else 0 end) AS add_to_cart, 
    SUM(CASE WHEN event_type = 'checkout' then 1 else 0 end) AS checkout, 
    SUM(CASE WHEN event_type = 'package_shipped' then 1 else 0 end) AS packages_shipped, 
    SUM(CASE WHEN event_type = 'page_views' then 1 else 0 end) AS page_view, 
    MIN(event_created_at) AS first_session_event_at_utc,
    MAX(event_created_at) AS last_session_event_at_utc 
    
FROM {{ ref('fct_events') }}
GROUP BY 1, 2
)


SELECT * FROM final 