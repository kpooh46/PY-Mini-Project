-- Shoplytics: create tables for the 11 supplied cleaned CSV files
-- Run this while connected to the shoplytics database.
-- Columns are typed from the supplied CSVs; text identifiers preserve leading zeros/ID formats.

CREATE TABLE IF NOT EXISTS "olist_customers_clean" (
    "customer_id" TEXT,
    "customer_unique_id" TEXT,
    "customer_zip_code_prefix" BIGINT,
    "customer_city" TEXT,
    "customer_state" TEXT
);

CREATE TABLE IF NOT EXISTS "olist_geolocation_clean" (
    "geolocation_zip_code_prefix" BIGINT,
    "geolocation_lat" DOUBLE PRECISION,
    "geolocation_lng" DOUBLE PRECISION,
    "geolocation_city" TEXT,
    "geolocation_state" TEXT,
    "source_rows" BIGINT
);

CREATE TABLE IF NOT EXISTS "olist_order_items_clean" (
    "order_id" TEXT,
    "order_item_id" BIGINT,
    "product_id" TEXT,
    "seller_id" TEXT,
    "shipping_limit_date" TIMESTAMP,
    "price" DOUBLE PRECISION,
    "freight_value" DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS "olist_order_payments_clean" (
    "order_id" TEXT,
    "payment_sequential" BIGINT,
    "payment_type" TEXT,
    "payment_installments" BIGINT,
    "payment_value" DOUBLE PRECISION,
    "dq_flags" TEXT
);

CREATE TABLE IF NOT EXISTS "olist_order_reviews_clean" (
    "review_id" TEXT,
    "order_id" TEXT,
    "review_score" BIGINT,
    "review_comment_title" TEXT,
    "review_comment_message" TEXT,
    "review_creation_date" TIMESTAMP,
    "review_answer_timestamp" TIMESTAMP,
    "reviews_in_raw" BIGINT,
    "low_rating_flag" BIGINT
);

CREATE TABLE IF NOT EXISTS "olist_orders_clean" (
    "order_id" TEXT,
    "customer_id" TEXT,
    "order_status" TEXT,
    "order_purchase_timestamp" TIMESTAMP,
    "order_approved_at" TIMESTAMP,
    "order_delivered_carrier_date" TIMESTAMP,
    "order_delivered_customer_date" TIMESTAMP,
    "order_estimated_delivery_date" TIMESTAMP,
    "dq_flags" TEXT,
    "purchase_to_approval_hours" DOUBLE PRECISION,
    "approval_to_carrier_hours" DOUBLE PRECISION,
    "carrier_to_delivery_days" DOUBLE PRECISION,
    "delivery_duration_days" DOUBLE PRECISION,
    "delivery_delay_days" DOUBLE PRECISION,
    "late_delivery_flag" DOUBLE PRECISION,
    "long_delivery_over_100d" BIGINT
);

CREATE TABLE IF NOT EXISTS "olist_products_clean" (
    "product_id" TEXT,
    "product_category_name" TEXT,
    "product_name_length" DOUBLE PRECISION,
    "product_description_length" DOUBLE PRECISION,
    "product_photos_qty" DOUBLE PRECISION,
    "product_weight_g" DOUBLE PRECISION,
    "product_length_cm" DOUBLE PRECISION,
    "product_height_cm" DOUBLE PRECISION,
    "product_width_cm" DOUBLE PRECISION,
    "product_category_name_english" TEXT
);

CREATE TABLE IF NOT EXISTS "olist_sellers_clean" (
    "seller_id" TEXT,
    "seller_zip_code_prefix" BIGINT,
    "seller_city" TEXT,
    "seller_state" TEXT
);

CREATE TABLE IF NOT EXISTS "order_items_analysis_table" (
    "order_id" TEXT,
    "order_item_id" BIGINT,
    "product_id" TEXT,
    "seller_id" TEXT,
    "shipping_limit_date" TIMESTAMP,
    "price" DOUBLE PRECISION,
    "freight_value" DOUBLE PRECISION,
    "product_category_name_english" TEXT,
    "seller_city" TEXT,
    "seller_state" TEXT,
    "order_status" TEXT,
    "order_purchase_timestamp" TIMESTAMP,
    "customer_unique_id" TEXT,
    "customer_city" TEXT,
    "customer_state" TEXT,
    "delivery_delay_days" DOUBLE PRECISION,
    "late_delivery_flag" DOUBLE PRECISION,
    "review_score" DOUBLE PRECISION,
    "low_rating_flag" DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS "orders_analysis_table" (
    "order_id" TEXT,
    "customer_id" TEXT,
    "order_status" TEXT,
    "order_purchase_timestamp" TIMESTAMP,
    "order_approved_at" TIMESTAMP,
    "order_delivered_carrier_date" TIMESTAMP,
    "order_delivered_customer_date" TIMESTAMP,
    "order_estimated_delivery_date" TIMESTAMP,
    "dq_flags" TEXT,
    "purchase_to_approval_hours" DOUBLE PRECISION,
    "approval_to_carrier_hours" DOUBLE PRECISION,
    "carrier_to_delivery_days" DOUBLE PRECISION,
    "delivery_duration_days" DOUBLE PRECISION,
    "delivery_delay_days" DOUBLE PRECISION,
    "late_delivery_flag" DOUBLE PRECISION,
    "long_delivery_over_100d" BIGINT,
    "customer_unique_id" TEXT,
    "customer_zip_code_prefix" BIGINT,
    "customer_city" TEXT,
    "customer_state" TEXT,
    "item_count" DOUBLE PRECISION,
    "item_sales_value" DOUBLE PRECISION,
    "freight_total" DOUBLE PRECISION,
    "seller_count" DOUBLE PRECISION,
    "payment_total" DOUBLE PRECISION,
    "max_installments" DOUBLE PRECISION,
    "main_payment_type" TEXT,
    "review_score" DOUBLE PRECISION,
    "low_rating_flag" DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS "product_category_name_translation_clean" (
    "product_category_name" TEXT,
    "product_category_name_english" TEXT
);
