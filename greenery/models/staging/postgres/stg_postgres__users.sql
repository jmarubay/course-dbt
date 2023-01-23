SELECT
     user_id AS user_guid,
     first_name, 
     last_name,
     email,
     phone_number,
     created_at::timestampntz AS created_at_utc,
     updated_at::timestampntz AS updated_at_utc,
     address_id AS address_guid
 FROM {{ source('postgres', 'users') }}
