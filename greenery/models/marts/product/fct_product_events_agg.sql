{% 
    set event_types = dbt_utils.get_column_values(
        table = ref('int_events')
        , column = 'event_type'
        , order_by = 'event_type asc'
    ) 
%}

WITH product_events_checkout AS (
    SELECT * FROM {{ ref('int_product_events') }}
    WHERE event_type = ('checkout') 
)


, final AS(   
    SELECT
    p.product_guid
    , p.product_name
    {% for event_type in event_types %}
    , SUM(CASE WHEN event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}s
    {% endfor %}
    
FROM {{ ref('int_events') }} AS e 
LEFT JOIN product_events_checkout AS p
USING(session_guid)
GROUP BY 1,2
)

SELECT * FROM final
WHERE product_guid IS NOT NULL