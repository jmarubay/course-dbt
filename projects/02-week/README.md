# Week 2 

## What is our user repeat rate?
Repeat Rate = Users who purchased 2 or more times / users who purchased 

```sql
/* Count number of orders per user */

WITH count_users_orders AS (
SELECT user_guid,
       COUNT(order_guid) AS count_order
FROM int_users_orders
GROUP BY 1
ORDER BY count_order
),

users_multiple_orders AS(
    SELECT user_guid,
    (count_order >= 1)::int as users_with_orders,
    (count_order >= 2)::int as users_with_more_than_2_orders
    FROM count_users_orders
)

SELECT SUM(users_with_more_than_2_orders) AS sum_users_with_more_than_2_orders,
       SUM(users_with_orders) AS sum_users_with_orders,
       (sum_users_with_more_than_2_orders/sum_users_with_orders) AS repeat_rate
FROM users_multiple_orders
```

**Answer:** The repeat rate is 94.35%