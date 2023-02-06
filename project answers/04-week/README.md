# Week 4

# Part 1. dbt Snapshots
Let's update our orders snapshot one last time to see how our data is changing: Run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week.

### ➤ Which orders changed from week 3 to week 4?
**Answer:** The order_ids that have changed status from preparing to shipped are: 
* 0e9b8ee9-ad0a-42f4-a778-e1dd3e6f6c51
* 841074bf-571a-43a6-963c-ba7cbdb26c85
* df91aa85-bfc7-4c31-93ef-4cee8d00a343

```sql
SELECT * FROM snapshot_postgres__orders
WHERE dbt_valid_to IS NOT NUll
```

# Part 2A. Modeling challenge

### ➤ How are our users moving through the product funnel?
**Answer:** See the funnel below. I have created a model in the /analyises/ folder called 'fct_product_funnel' to answer this question.

| TOTAL_SESSIONS      | ADD_TO_CART_RATE | CONVERSION_RATE |
|---------------------|------------------|-----------------|
| 578                 | 80.79            | 62.45           |

### ➤ Which steps in the funnel have largest drop off points?
**Answer:** The checkout step has the largest dropf-off rate.

| TOTAL_SESSIONS      | ADD_TO_CART_DROP_OFF | CHECKOUT_DROP_OFF   |
|---------------------|----------------------|---------------------|
| 578                 | 19.20                | 22.69               |


```sql
WITH final AS(
    
    SELECT
    COUNT(DISTINCT session_guid) AS total_sessions
    , count(distinct (case when add_to_cart = 1 then session_guid end)) as sessions_with_add_to_cart
    , count(distinct (case when checkout = 1 then session_guid end)) as sessions_with_checkout
    , (sessions_with_add_to_cart/total_sessions)*100 AS add_to_cart_rate
    , (sessions_with_checkout/total_sessions)*100 AS conversion_rate
    , ((sessions_with_add_to_cart-sessions_with_checkout)/sessions_with_add_to_cart)*100 AS checkout_drop_off
    , ((total_sessions-sessions_with_add_to_cart)/total_sessions)*100 AS add_to_cart_drop_off
    
    FROM dev_db.dbt_jmarubaygreenpeaceorg.int_session_events
)

SELECT * FROM final

```

# Part 2B. Exposures
In addition to answering these questions right now, we want to be able to answer them at any time. The Product and Engineering teams will want to track how they are improving these metrics on an ongoing basis. As such, we need to think about how we can model the data in a way that allows us to set up reporting for the long-term tracking of our goals.

### ➤ 1. Please create any additional dbt models needed to help answer these questions from our product team, and put your answers in a README in your repo.

**Answer:** Done. See the /analyses/ folder for the SQL statements. I have used the 'int_session_events' and 'fct_product_events_agg' models to help answer these questions. 

### ➤ 2. Use an exposure on your product analytics model to represent that this is being used in downstream BI tools. Please reference the course content if you have questions.
    
**Answer:** Done. See the exposures.yml file inside the /models/ folder. 

### ➤ 3. With our funnel data model complete, let’s create a sigma workbook to visualize all of our data for our CPO and CEO

**Answer:** Not done, lack of time.

# Part 3. Reflection questions
Answer 3A or 3B.

## 3A. dbt next steps for you

### ➤ If your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?
**Answer:** Analytics engineering can help us to increase data accessibility because it allows us to use a modeled, reusable and scalable approach to generate clean and structured datasets that are necessry for stratgic decision making. This practice can also save us resources and help us improving our data maturity because this modeled and transprent approach allows for more collaboration between teams/offices.

### ➤ If your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?
**Answer:** N/A

### ➤ If you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?
**Answer:** Most importantly, this course helped me to understand the process of data modelling and how dbt can be used to make our analysis work more reusable, scalable and future-proof. I have also learned the fundamentals of dbt, developed basic skills in GIT and improved my skills in SQL. 

## 3B. Setting up for production / scheduled dbt run of your project
And finally, before you fly free into the dbt night, we will take a step back and reflect: after learning about the various options for dbt deployment and seeing your final dbt project: 

### ➤ How would you go about setting up a production/scheduled dbt run of your project in an ideal state? 
You don’t have to actually set anything up - just jot down what you would do and why and post in a README file.

_Hints: what steps would you have? Which orchestration tool(s) would you be interested in using? What schedule would you run your project on? Which metadata would you be interested in using? How/why would you use the specific metadata? , etc._

**Answer:** Similarly to the example from the course content, I would use a orchestration tool to upload data into my warehous daily, test the source freshness and run snapshots, run my models and record the metadata obtained, set alerts and update my dbt docs. I would be interested in using the metadata to track the performance of dbt runs (run_results.json), get source freshness results (sources.json) and to understand how the project resources are configured and interconnected (manifest.json). I would also like to explore the dbt Artifacts package to explore how to use these metadata better, and follow the example from the course content which developed a dashboard and integrations with Slack for alerts. 

