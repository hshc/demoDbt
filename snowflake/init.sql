create warehouse transforming;
create database raw;
create database analytics;
create schema raw.jaffle_shop;
create schema raw.stripe;

-- In the raw database and jaffle_shop and stripe schemas, create three tables and
-- load relevant data into them:
-- First, delete all contents (empty) in the Editor of the Snowflake worksheet. Then,
-- run this SQL command to create the customer table:
create or replace table raw.jaffle_shop.customers
(
    id integer,
    first_name varchar,
    last_name varchar
);
truncate raw.jaffle_shop.customers;

-- delete all contents in the Editor, then run this command to load data into the
-- customer table:
copy into raw.jaffle_shop.customers (id, first_name, last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    ); 

-- Delete all contents in the Editor (empty), then run this command to create the
-- orders table:
create or replace table raw.jaffle_shop.orders
( id integer,
  user_id integer,
  order_date date,
  status varchar,
  _etl_loaded_at timestamp default current_timestamp
);
truncate table raw.jaffle_shop.orders;

-- delete all contents in the Editor, then run this command to load data into the
-- orders table:
copy into raw.jaffle_shop.orders (id, user_id, order_date, status)
from 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    );

-- Delete all contents in the Editor (empty), then run this command to create the
-- payment table:
create or replace table raw.stripe.payment 
( id integer,
  orderid integer,
  paymentmethod varchar,
  status varchar,
  amount integer,
  created date,
  _batched_at timestamp default current_timestamp
);

truncate table raw.stripe.payment;

-- Delete all contents in the Editor, then run this command to load data into the
-- payment table:
copy into raw.stripe.payment (id, orderid, paymentmethod, status, amount, created)
from 's3://dbt-tutorial-public/stripe_payments.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    );

-- verify that the data is loaded by running these SQL queries. Confirm that you can
-- see output for each one.
select * from raw.jaffle_shop.customers;
select * from raw.jaffle_shop.orders;
select * from raw.stripe.payment;

copy into raw.jaffle_shop.customers (id, first_name, last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    );
