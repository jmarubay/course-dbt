{{
  config(
    materialized='table'
  )
}}

select * from {{ ref('stg_postgres_orders_snapshot') }}