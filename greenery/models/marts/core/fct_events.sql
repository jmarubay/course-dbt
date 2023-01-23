SELECT
    event_guid,
    session_guid,
    user_guid,
    page_url,
    created_at_utc AS event_created_at,
    order_guid,
    product_guid

FROM {{ ref('stg_postgres__events') }} 