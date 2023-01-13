{% snapshot stg_postgres_orders_snapshot %}

  {{
    config(
      target_schema='DBT_JMARUBAYGREENPEACEORG',
      strategy='check',
      unique_key='order_id',
      check_cols=['status'],
    )
  }}

  SELECT * FROM {{ source('postgres', 'orders') }}

{% endsnapshot %}

# This snapshot will generate a new table in the schema selected above with the snapshot name (eg. stg_postgres_orders_snapshot)