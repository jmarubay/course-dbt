# Week 3

# Part 1: Create new models to answer the first two questions (answer questions in README file)

## ➤ What is our overall conversion rate?
**Answer:** The overall conversion rate is 62.45%. 

```sql
SELECT * FROM fct_session_events_conversion_rate
```


## ➤ What is our conversion rate by product?
**Answer:** See in the table below.

| PRODUCT NAME        | CONVERSION RATE |
|---------------------|-----------------|
| String of pearls    | 21.43           |
| Arrow Head          | 24.14           |
| Philodendron        | 22.56           |
| Rubber Plant        | 19.86           |
| Money Tree          | 20.63           |
| Aloe Vera           | 20.65           |
| Angel Wings Begonia | 23.3            |
| Birds Nest Fern     | 21.85           |
| Boston Fern         | 22.41           |
| Majesty Palm        | 20.89           |
| Calathea Makoyana   | 23.48           |
| Alocasia Polly      | 25.3            |
| Orchid              | 23.78           |
| Spider Plant        | 20.74           |
| Monstera            | 20.83           |
| Bamboo              | 22.78           |
| Pothos              | 25.61           |
| Peace Lily          | 22.13           |
| ZZ Plant            | 21.38           |
| Pink Anthurium      | 20.13           |
| Ponytail Palm       | 21.71           |
| Dragon Tree         | 22.31           |
| Devil's Ivy         | 20.95           |
| Bird of Paradise    | 20.45           |
| Pilea Peperomioides | 21.05           |
| Cactus              | 19.74           |
| Snake Plant         | 20              |
| Jade Plant          | 20.18           |
| Fiddle Leaf Fig     | 23.14           |
| Ficus               | 23.02           |

```sql
SELECT product_name, conversion_rate FROM fct_product_conversion_rate
```


NOTE: conversion rate is defined as the # of unique sessions with a purchase event / total number of unique sessions. Conversion rate by product is defined as the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product

A question to think about: **Why might certain products be converting at higher/lower rates than others?**
Note: we don't actually have data to properly dig into this, but we can make some hypotheses. 

# Part 2: Macros
We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project. 

Create a macro to simplify part of a model(s). Think about what would improve the usability or modularity of your code by applying a macro. Large case statements, or blocks of SQL that are often repeated make great candidates. Document the macro(s) using a .yml file in the macros directory.

## ➤ One potential macro in our data set is aggregating event types per session. Start here as your first macro and add other macros if you want to go further.

**Answer:** I used a macro from dbt_utils (get_column_values) to aggregate event types per session on the models fct_product_events_agg and int_session_events_macro_agg. I also wanted to create a new macro macro_event_types to store this use-case of the dbt_utils package, but I'm not yet sure how to do it and reference it on the models. 

# Part 3: Hook
We’re starting to think about granting permissions to our dbt models in our snowflake database so that other roles can have access to them.

## ➤ Add a post hook to your project to apply grants to the role “reporting”. 
**Answer:** I added a post-hook to all models under /marts/. Defined on the dbt_project.yml file. 

You can use the grant macro example from this week!

To check if your grants worked you can check in the query history in the snowflake UI after your dbt run, and find the grant that ran

# Part 4: Packages
After learning about dbt packages, we want to try one out and apply some macros or tests.

## ➤ Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

**Answer:** I have installed dbt-utils and codegen. I have used the dbt_utils.get_column_values a few times on my models and used codegen.generate_model_yaml to automatically generate the yaml structure for a few models. 


# PART 5: After improving our project with all the things that we have learned about dbt, we want to show off our work!

## ➤ Show how you have simplified or improved a DAG using macros and/or dbt packages.

**Answer:** My DAG was cleaner last week. I created new models for the Week 3 project and I feel they still need some refactoring to improve my DAG.  

# Part 6. dbt Snapshots

Let's update our orders snapshot again to see how our data is changing: run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. 


## ➤ Which orders changed from week 2 to week 3? 

**Answer:** The order_ids that have changed status from preparing to shipped are: 
* 29d20dcd-d0c4-4bca-a52d-fc9363b5d7c6
* c0873253-7827-4831-aa92-19c38372e58d
* e2729b7d-e313-4a6f-9444-f7f65ae8db9a


```sql
SELECT * FROM snapshot_postgres__orders
WHERE dbt_valid_to IS NOT NUll
```
