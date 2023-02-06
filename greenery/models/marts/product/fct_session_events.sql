{% 
    set event_types = dbt_utils.get_column_values(
        table = ref('int_events')
        , column = 'event_type'
        , order_by = 'event_type asc'
    ) 
%}


WITH events AS (
    SELECT * FROM {{ref ('int_events') }}
)

, final AS (
SELECT
    user_guid
    , session_guid
    {% for event_type in event_types %}
    , (case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}
    {% endfor %}
    
    
FROM int_events
)


SELECT * FROM final 