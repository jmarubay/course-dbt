{% 
    set event_types = dbt_utils.get_column_values(
        table = ref('stg_postgres__events')
        , column = 'event_type'
        , order_by = 'event_type asc'
    ) 
%}


WITH final AS(   
    SELECT
    p.product_guid
    , p.product_name
    {% for event_type in event_types %}
    , SUM(CASE WHEN event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}s
    {% endfor %}
    --SUM(CASE WHEN e.event_type = 'add_to_cart' then 1 else 0 end) AS add_to_carts, 
    --SUM(CASE WHEN e.event_type = 'checkout' then 1 else 0 end) AS checkouts, 
    --SUM(CASE WHEN e.event_type = 'package_shipped' then 1 else 0 end) AS packages_shippeds, 
    --SUM(CASE WHEN e.event_type = 'page_view' then 1 else 0 end) AS page_views, 
    , MIN(event_created_at) AS first_session_event_at
    , MAX(event_created_at) AS last_session_event_at 
    
FROM {{ ref('int_events') }} AS e 
LEFT JOIN {{ ref('int_product_events_checkout') }} AS p
USING(session_guid)
GROUP BY 1,2
)

SELECT * FROM final
WHERE product_guid IS NOT NULL