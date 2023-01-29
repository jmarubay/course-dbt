WITH final AS(
    
    SELECT
    COUNT(DISTINCT session_guid) AS total_sessions
    , SUM(checkout) AS checkouts
    , (checkouts/total_sessions)*100 AS conversion_rate
    
    FROM {{ref ('int_session_events') }}
)

SELECT * FROM final