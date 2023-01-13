{% snapshot orders_snapshot %}

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