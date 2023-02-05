# Week 4

# Part 1. dbt Snapshots
Let's update our orders snapshot one last time to see how our data is changing: Run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week.

## ➤ Which orders changed from week 3 to week 4?
**Answer:** 

```sql

```

# Part 2. Modeling challenge

## ➤ How are our users moving through the product funnel?
**Answer:** 

```sql

```

## ➤ Which steps in the funnel have largest drop off points?
**Answer:** 

```sql

```

## ➤ Exposures
In addition to answering these questions right now, we want to be able to answer them at any time. The Product and Engineering teams will want to track how they are improving these metrics on an ongoing basis. As such, we need to think about how we can model the data in a way that allows us to set up reporting for the long-term tracking of our goals.

1. Please create any additional dbt models needed to help answer these questions from our product team, and put your answers in a README in your repo.

2. Use an exposure on your product analytics model to represent that this is being used in downstream BI tools. Please reference the course content if you have questions.

3. With our funnel data model complete, let’s create a sigma workbook to visualize all of our data for our CPO and CEO

**Answer:** 

# Part 3. Reflection questions
Answer 3A or 3B.

## 3A. dbt next steps for you

### ➤ If your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?
**Answer:** 

### ➤ If your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?
**Answer:** 

### ➤ If you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?
**Answer:** 

## 3B. Setting up for production / scheduled dbt run of your project
And finally, before you fly free into the dbt night, we will take a step back and reflect: after learning about the various options for dbt deployment and seeing your final dbt project: 

### ➤ How would you go about setting up a production/scheduled dbt run of your project in an ideal state? 
You don’t have to actually set anything up - just jot down what you would do and why and post in a README file.

**Answer:** 

Hints: what steps would you have? Which orchestration tool(s) would you be interested in using? What schedule would you run your project on? Which metadata would you be interested in using? How/why would you use the specific metadata? , etc.