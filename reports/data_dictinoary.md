Shoplytics — Data Dictionary

Purpose

This document explains the main business fields in the cleaned Brazilian Olist e-commerce tables imported into the Shoplytics PostgreSQL database. The companion data_dictionary_columns.csv contains the exported table names, column names, PostgreSQL data types, and nullability settings for 113 database columns.

Customers — olist_customers_clean

|Column                    |Description                                                       |
|:-------------------------|:-----------------------------------------------------------------|
|customer_id             |Identifier for a customer record, used to link orders to customers|
|customer_unique_id      |Identifier used to recognize the same customer across orders      |
|customer_zip_code_prefix|Postal code prefix of the customer’s location                     |
|customer_city           |Customer’s city                                                   |
|customer_state          |Customer’s state                                                  |

Orders — olist_orders_clean

|Column                         |Description                                      |
|:------------------------------|:------------------------------------------------|
|order_id                     |Unique identifier for an order                   |
|customer_id                  |Identifier linking the order to a customer record|
|order_status                 |Recorded order status                            |
|order_purchase_timestamp     |Date and time the order was placed               |
|order_delivered_customer_date|Recorded actual customer delivery date and time  |
|order_estimated_delivery_date|Estimated customer delivery date                 |

Products — olist_products_clean

|Column                 |Description                   |
|:----------------------|:-----------------------------|
|product_id           |Unique product identifier     |
|product_category_name|Original product category name|
|product_weight_g     |Product weight in grams       |
|product_length_cm    |Product length in centimeters |
|product_height_cm    |Product height in centimeters |
|product_width_cm     |Product width in centimeters  |

Sellers — olist_sellers_clean

|Column                  |Description                |
|:-----------------------|:--------------------------|
|seller_id             |Unique seller identifier   |
|seller_zip_code_prefix|Seller’s postal code prefix|
|seller_city           |Seller’s city              |
|seller_state          |Seller’s state             |

Data Quality Summary

|Check                                         |Verified result|
|:---------------------------------------------|--------------:|
|Orders checked                                |99,441         |
|Missing or duplicate order IDs                |0              |
|Missing actual delivery dates                 |2,965          |
|Delivered orders missing actual delivery dates|8              |
|Missing or duplicate customer IDs             |0              |
|Missing or duplicate product IDs              |0              |
|Missing or duplicate seller IDs               |0              |
|Products missing weights                      |6              |
|Products missing length                       |2              |
|Products missing height                       |2              |
|Products missing width                        |2              |

For detailed checks, see data_quality_report.md.

Scope and Next Documentation Step

This document describes principal business fields, not every one of the 113 columns. Use data_dictionary_columns.csv as the schema inventory and add definitions of the remaining columns after checking the corresponding CSV headers and transformation logic. SQL is_nullable metadata indicates whether the database allows NULL values; it is not a count of missing values.