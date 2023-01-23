SELECT
    o.order_guid,
    o.user_guid,
    o.promo_desc,
    o.address_guid AS order_address, 
    o.created_at_utc AS order_created_at,
    o.estimated_delivery_at_utc AS order_estimated_delivery_at,
    o.delivered_at_utc AS order_delivered_at,
    o.order_cost,
    o.shipping_cost,
    o.tracking_guid,
    o.shipping_service,
    o.status AS order_status, 
    i.product_guid,
    i.quantity
    

FROM {{ ref('stg_postgres__orders') }} AS o
JOIN {{ ref('stg_postgres__order_items') }} AS i
USING(order_guid)