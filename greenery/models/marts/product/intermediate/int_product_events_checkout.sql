WITH o AS (
    SELECT * FROM {{ ref('fct_orders_products') }}
)

, e AS (
    SELECT * FROM {{ ref('int_events') }}
    WHERE event_type = ('checkout') 
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
    
    FROM o
    JOIN e
    USING(order_guid)
    ) 
    
SELECT * FROM final

