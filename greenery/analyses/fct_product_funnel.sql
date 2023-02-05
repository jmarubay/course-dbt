WITH final AS(
    
    SELECT
    COUNT(DISTINCT session_guid) AS total_sessions
    , count(distinct (case when add_to_cart = 1 then session_guid end)) as sessions_with_add_to_cart
    , count(distinct (case when checkout = 1 then session_guid end)) as sessions_with_checkout
    , (sessions_with_add_to_cart/total_sessions)*100 AS add_to_cart_rate
    , (sessions_with_checkout/total_sessions)*100 AS conversion_rate
    
    FROM {{ref ('int_session_events') }}
)

SELECT * FROM final