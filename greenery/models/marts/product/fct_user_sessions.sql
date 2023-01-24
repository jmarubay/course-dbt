WITH sessions AS (
    SELECT * FROM int_session_events_agg
)
, users AS(
SELECT * FROM dim_users
)

SELECT
    sessions.session_guid,
    sessions.user_guid,
    users.first_name,
    users.last_name, 
    users.email,
    sessions.page_view,
    sessions.add_to_cart,
    sessions.checkout,
    sessions.packages_shipped,
    sessions.first_session_event_at_utc AS first_session_event,
    sessions.last_session_event_at_utc AS last_session_event,
    DATEDIFF('minute', first_session_event, last_session_event) AS session_length_minutes
    
FROM sessions 
LEFT JOIN users
    ON sessions.user_guid = users.user_guid
    
