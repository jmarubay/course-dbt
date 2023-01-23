SELECT
     order_id AS order_guid,
     user_id AS user_guid,
     promo_id AS promo_desc,
     address_id AS address_guid,
     created_at::timestampntz AS created_at_utc,
     order_cost,
     shipping_cost,
     order_total,
     tracking_id AS tracking_guid,
     shipping_service,
     estimated_delivery_at::timestampntz AS estimated_delivery_at_utc,
     delivered_at::timestampntz AS delivery_at_utc,
     status
 FROM {{ source('postgres', 'orders') }}
