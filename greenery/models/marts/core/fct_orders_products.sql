SELECT 
    o.order_guid
    , o.user_guid 
    , o.product_guid
    , p.product_name
    , p.price AS product_price
    , o.quantity
    , o.order_cost
    , p.inventory
    , o.promo_desc
    , o.order_status
    , o.address_guid
    , o.shipping_service
    , o.shipping_cost
    , o.tracking_guid
    , o.order_created_at
    , o.order_estimated_delivery_at
    , o.order_delivered_at
    
FROM {{ ref('int_orders') }} AS o
JOIN {{ ref('int_products') }} AS p
USING(product_guid)
