{% 
    set event_types = dbt_utils.get_column_values(
        table = ref('int_events')
        , column = 'event_type'
        , order_by = 'event_type asc'
    ) 
%}

WITH sessions AS (
    SELECT
    user_guid
    , session_guid
    {% for event_type in event_types %}
    , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}s
    {% endfor %}
    , MIN(event_created_at) AS first_session_event_at_utc
    , MAX(event_created_at) AS last_session_event_at_utc 
    FROM {{ref ('int_events') }}
    GROUP BY 1, 2
)
, users AS(
SELECT * FROM {{ ref('int_users') }}
)

SELECT
    sessions.session_guid,
    sessions.user_guid,
    users.first_name,
    users.last_name, 
    users.email,
    sessions.page_views,
    sessions.add_to_carts,
    sessions.checkouts,
    sessions.package_shippeds,
    sessions.first_session_event_at_utc AS first_session_event,
    sessions.last_session_event_at_utc AS last_session_event,
    DATEDIFF('minute', first_session_event, last_session_event) AS session_length_minutes
    
FROM sessions 
LEFT JOIN users
    ON sessions.user_guid = users.user_guid
    
