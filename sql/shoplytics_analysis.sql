-- SHOPLYTICS: E-COMMERCE PERFORMANCE ANALYSIS
-- Database: shoplytics
-- Dataset: Brazilian Olist E-Commerce

-- 1. ORDER STATUS ANALYSIS
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM olist_orders_clean
GROUP BY order_status
ORDER BY total_orders DESC;


-- 2. DELIVERY COMPLETION RATE
SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (
        WHERE order_status = 'delivered'
    ) AS delivered_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_status = 'delivered'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS delivery_percentage
FROM olist_orders_clean;


-- 3. ON-TIME AND LATE DELIVERIES
SELECT
    COUNT(*) AS delivered_orders,
    COUNT(*) FILTER (
        WHERE order_delivered_customer_date
              <= order_estimated_delivery_date
    ) AS on_time_orders,
    COUNT(*) FILTER (
        WHERE order_delivered_customer_date
              > order_estimated_delivery_date
    ) AS late_orders
FROM olist_orders_clean
WHERE order_status = 'delivered';


-- 4. CUSTOMER SATISFACTION
SELECT
    ROUND(AVG(review_score), 2) AS average_review_score,
    COUNT(*) AS total_reviews,
    COUNT(*) FILTER (
        WHERE review_score >= 4
    ) AS positive_reviews
FROM olist_order_reviews_clean;


-- 5. DELIVERY TIMING VS CUSTOMER RATINGS
WITH order_reviews AS (
    SELECT
        order_id,
        AVG(review_score) AS review_score
    FROM olist_order_reviews_clean
    GROUP BY order_id
)
SELECT
    CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On time'
    END AS delivery_status,
    COUNT(*) AS reviewed_orders,
    ROUND(AVG(r.review_score), 2) AS average_rating
FROM olist_orders_clean o
JOIN order_reviews r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY 1
ORDER BY 1;


-- 6. TOTAL RECORDED PAYMENTS
SELECT
    ROUND(SUM(payment_value)::numeric, 2)
        AS total_payment_value,
    COUNT(DISTINCT order_id)
        AS orders_with_payments,
    ROUND(
        SUM(payment_value)::numeric /
        NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_payment_per_order
FROM olist_order_payments_clean;


-- 7. TOP 10 PRODUCT CATEGORIES
SELECT
    COALESCE(
        t.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS category,
    COUNT(*) AS items_sold,
    ROUND(SUM(i.price)::numeric, 2) AS sales_value
FROM olist_order_items_clean i
JOIN olist_products_clean p
    ON i.product_id = p.product_id
LEFT JOIN product_category_name_translation_clean t
    ON p.product_category_name =
       t.product_category_name
GROUP BY 1
ORDER BY sales_value DESC
LIMIT 10;


-- 8. MONTHLY ITEM SALES FOR DELIVERED ORDERS
SELECT
    TO_CHAR(
        DATE_TRUNC('month', o.order_purchase_timestamp),
        'YYYY-MM'
    ) AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(i.price)::numeric, 2) AS item_sales_value
FROM olist_orders_clean o
JOIN olist_order_items_clean i
    ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp IS NOT NULL
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY DATE_TRUNC('month', o.order_purchase_timestamp);


-- 9. TOP 5 SALES MONTHS
SELECT
    TO_CHAR(
        DATE_TRUNC('month', o.order_purchase_timestamp),
        'YYYY-MM'
    ) AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(i.price)::numeric, 2) AS item_sales_value
FROM olist_orders_clean o
JOIN olist_order_items_clean i
    ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp IS NOT NULL
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY item_sales_value DESC
LIMIT 5;