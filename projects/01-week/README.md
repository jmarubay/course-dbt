
# Week 1

## Questions

### 1. How many users do we have?
```sql
SELECT
    COUNT(DISTINCT user_guid) AS count_users
FROM
    stg_postgres__users 
```
**Answer:** We have 130 unique users

### 2. On average, how many orders do we receive per hour?

```sql
WITH orders_per_hour
AS (
SELECT
    DATE_TRUNC('hour', created_at_utc) AS hour,
    COUNT(DISTINCT order_guid) AS count_orders
FROM stg_postgres__orders
GROUP BY hour
    )
    
    
SELECT
    AVG(count_orders) AS avg_order_per_hour
FROM orders_per_hour 
```

**Answer:** We have 7.520833 orders per hour

### 3. On average, how long does an order take from being placed to being delivered?
```sql
SELECT
   AVG(TIMESTAMPDIFF(hour, created_at_utc, delivery_at_utc)) AS hour_difference
FROM stg_postgres__orders
WHERE 
    delivery_at_utc IS NOT NULL
    AND created_at_utc IS NOT NULL  
```

**Answer:** Approximately 3 days and 21 hours (93.403279 hours )

### 4. How many users have only made one purchase? Two purchases? Three+ purchases?
Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

```sql
WITH orders_per_user AS(
SELECT 
    user_guid,
    COUNT(DISTINCT order_guid) AS order_count
FROM stg_postgres__orders
GROUP BY user_guid)

SELECT 
  CASE 
    WHEN order_count = 1 THEN 1
    WHEN order_count = 2 THEN 2
    WHEN order_count >= 3 THEN 3
    ELSE NULL 
  END AS order_count_category,
  COUNT(DISTINCT user_guid) AS count_users
FROM orders_per_user
GROUP BY order_count_category
```

**Answer:**
* 1 purchase: 25
* 2 purchases: 28
* 3 or more: 71

### 5. On average, how many unique sessions do we have per hour?
```sql
WITH sessions_per_hour 
AS (
  SELECT
    DATE_TRUNC('hour', created_at_utc) AS hour, 
    COUNT(DISTINCT session_guid) as count_sessions
  FROM stg_postgres__events
  GROUP BY hour
)

SELECT 
  AVG(count_sessions)
FROM sessions_per_hour
```

**Answer:** We have 16.3 unique sessions in average. 
