SELECT
    u.user_guid,
    u.email,
    u.user_created_at,
    u.user_updated_at, 
    u.address_guid,
    o.order_guid,
    o.order_created_at,
    o.order_delivered_at,
    o.order_cost, 
    o.order_status

FROM {{ ref('int_users') }} AS u
JOIN {{ ref('int_orders') }} AS o
USING(user_guid)