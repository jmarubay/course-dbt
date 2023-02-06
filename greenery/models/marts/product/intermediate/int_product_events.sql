WITH o AS (
    SELECT * FROM {{ ref('int_orders') }} AS o
    JOIN {{ ref('int_products') }} AS p
    USING(product_guid)
)

, e AS (
    SELECT * FROM {{ ref('int_events') }}
)

, final AS (
    SELECT 
    o.order_guid,
    o.user_guid,
    e.session_guid,
    o.product_guid,
    o.product_name,
    o.product_price,
    e.event_guid,
    e.event_type,
    e.event_created_at,    
    o.promo_desc,
    o.address_guid, 
    o.order_created_at,
    o.order_estimated_delivery_at,
    o.order_delivered_at,
    o.order_cost,
    o.shipping_cost,
    o.tracking_guid,
    o.shipping_service,
    o.order_status, 
    o.quantity    
    
    FROM e
    LEFT JOIN o
    USING(order_guid)
    ) 
    
SELECT * FROM final

