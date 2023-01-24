SELECT 
    product_guid,
    COUNT(DISTINCT session_guid)::numeric AS page_views
FROM 
    {{ ref('stg_postgres__events') }}
WHERE 
    event_type = 'page_view'
GROUP BY 1