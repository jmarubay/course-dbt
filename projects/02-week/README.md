# Week 2 

# Part 1. Models 

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

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

**Answer:** TBD

## More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units: 
* Core
* Marketing
* Product

**Answer:** Done! Check the Marts folder here: https://github.com/jmarubay/course-dbt/blob/main/greenery/models/marts

## Within each marts folder, create intermediate models and dimension/fact models. Explain the marts models you added. Why did you organize the models in the way you did?

**Answer:** Done! Check the models below. 

### Core
* https://github.com/jmarubay/course-dbt/blob/main/greenery/models/marts/core/dim_products.sql 
* https://github.com/jmarubay/course-dbt/blob/main/greenery/models/marts/core/dim_users.sql
* https://github.com/jmarubay/course-dbt/blob/main/greenery/models/marts/core/fct_events.sql
* https://github.com/jmarubay/course-dbt/blob/main/greenery/models/marts/core/fct_orders.sql 

### Marketing
* Intermediate: https://github.com/jmarubay/course-dbt/blob/main/greenery/models/marts/marketing/intermediate/int_users_orders.sql
* Dim/facts: 

For those who are less familiar with e-commerce and marketing, we might want to dig into users — when was their first order? Last order? How many orders have they made? Total spend? We might want to dig into our biggest customers and look at trends. As a simple but important model, we can connect user and order data to make querying data about a user easier for stakeholders.

### Product
* Intermediate: TBD
* Dim/facts: TBD

Again for those less familiar with e-commerce for products mart, we might we want to know how different products perform. What are daily page views by product? Daily orders by product? What’s getting a lot of traffic, but maybe not converting into purchases?

## Use the dbt docs to visualize your model DAGs to ensure the model layers make sense. Paste in an image of your DAG from the docs.

TBD

# Part 2. Tests 

## Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above.

### What assumptions are you making about each model? (i.e. why are you adding each test?)
**Answer:** TBD

### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
**Answer:** TBD

### * Apply these changes to your github repo
**Answer:**  TBD

## Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
**Answer:** TBD

# Part 3. dbt Snapshots

## Let's update our orders snapshot that we created last week to see how our data is changing: Run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. 

### Which orders changed from week 1 to week 2? 
```sql
SELECT *
FROM snapshot_postgres__orders
WHERE dbt_valid_to is not null
```

**Answer:** The query resulted in no results, probably because I deleted my previous snapshot table today while I was changing some files names and didn't realise this would impact my project's answers :D
