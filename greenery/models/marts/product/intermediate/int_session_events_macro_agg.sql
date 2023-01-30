{% 
    set event_types = dbt_utils.get_column_values(
        table = ref('stg_postgres__events')
        , column = 'event_type'
        , order_by = 'event_type asc'
    ) 
%}

SELECT
    user_guid
    , session_guid
    {% for event_type in event_types %}
    , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}s
    {% endfor %}
    , MIN(created_at_utc) AS first_session_event_at_utc
    , MAX(created_at_utc) AS last_session_event_at_utc 
FROM {{ref ('stg_postgres__events') }}
GROUP BY 1, 2