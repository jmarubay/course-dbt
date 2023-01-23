SELECT
    u.user_guid,
    u.email,
    u.first_name,
    u.last_name,
    u.phone_number,
    u.created_at_utc AS user_created_at,
    u.updated_at_utc AS user_updated_at,
    a.address_guid,
    a.address,
    a.zipcode,
    a.state,
    a.country

FROM {{ ref('stg_postgres__users') }} AS u
JOIN {{ ref('stg_postgres__addresses') }} AS a
USING(address_guid)