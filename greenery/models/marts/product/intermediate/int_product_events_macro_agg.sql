{% 
    set event_types = dbt_utils.get_column_values(
        table = ref('stg_postgres__events')
        , column = 'event_type'
        , order_by = 'event_type asc'
    ) 
%}


WITH events AS (
    SELECT * FROM {{ ref('stg_postgres__events') }}
)

, final AS (
SELECT
    product_guid 
    , COUNT(DISTINCT session_guid) AS product_sessions
    {% for event_type in event_types %}
    , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as product_{{ event_type }}s
    {% endfor %}
    
FROM {{ ref('stg_postgres__events') }}
GROUP BY 1
HAVING product_guid IS NOT NULL
)


SELECT * FROM final 