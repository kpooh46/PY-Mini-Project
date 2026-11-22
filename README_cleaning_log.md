# SHOPLYTICS: Cleaned Olist Data (handover to BI / Dashboard)

Prepared by: Vishwas (Data Analyst & SQL Specialist)
Source: Brazilian E-Commerce Public Dataset by Olist (team ZIP, original row counts match the Research Framework)
Raw files were not modified; every file below is a cleaned copy.

## Start here
For the Power BI dashboard, the two **analysis tables** are the easiest starting point:
- `orders_analysis_table.csv`: one row per order (99,441 rows). Includes customer location, status, all timestamps, derived delivery measures, item/payment totals and review score.
- `order_items_analysis_table.csv`: one row per order item (112,650 rows). Adds English category, seller city/state, and the order's delay, late flag and review score. Use this for seller and category analysis.

The nine cleaned base files are also included (same names as the originals, with `_clean`) in case you want to build your own model.

## Cleaning rules applied
| Area | Issue found | What was done |
|---|---|---|
| Timestamps | Stored as text | Converted to proper date/time (format YYYY-MM-DD HH:MM:SS) in orders, items, reviews |
| Orders | Impossible sequences: 1,359 carrier-before-approval, 166 carrier-before-purchase, 23 delivered-before-carrier | Original timestamps kept. Affected stage durations set to blank; row listed in `dq_flags` |
| Orders | Delivered orders missing dates (8 customer date, 14 approval, 2 carrier); 6 non-delivered orders with a delivery date | Kept, listed in `dq_flags`; excluded from delivery metrics |
| Orders | Blank dates on cancelled / in-progress orders | Left blank on purpose (not errors) |
| Orders | 64 orders took over 100 days to deliver | Kept, marked `long_delivery_over_100d = 1` |
| Reviews | 814 repeated review IDs; 547 orders with 2-3 reviews | One review per order: the latest by answer time. 99,224 raw rows become 98,673. `reviews_in_raw` shows the original count |
| Reviews | Line breaks inside comments | Replaced by spaces |
| Geolocation | 261,831 exact duplicates; up to 1,146 rows per ZIP; 42 points outside Brazil | Removed out-of-Brazil points, then one row per ZIP prefix (average lat/lng, most common city/state). 1,000,163 rows become 19,010 |
| City names | Mixed accents/case, broken characters (`sa£o paulo`, `%26apos%3b`) | Lowercase, no accents, apostrophes fixed |
| Seller cities | Free text such as `sao paulo / sp`, `lages - sc`, an email, a number | Cleaned to the city name (37 changed); `sbc` became `sao bernardo do campo`; 7 non-city values (`sp`, numbers, email) set to blank |
| Products | 610 with no category | Category set to `unknown` |
| Products | 2 categories without English translation | Added `pc_gamer` and `portable_kitchen_food_preparers` to the translation file (my translation, please review) |
| Products | 4 weights of 0 | Set to blank |
| Products | Misspelled columns `lenght` | Renamed to `length` |
| Payments | 3 `not_defined` types, 9 zero-value payments, 2 zero-instalment rows | Kept, listed in `dq_flags` |

## Derived columns (orders_clean and orders_analysis_table)
| Column | Meaning |
|---|---|
| delivery_delay_days | Actual delivery minus estimated delivery (positive = late). Delivered orders with a customer delivery date only |
| late_delivery_flag | 1 if delivered after the estimate, 0 if on time or early; blank if not delivered |
| delivery_duration_days | Purchase to customer delivery |
| purchase_to_approval_hours | Approval minus purchase |
| approval_to_carrier_hours | Carrier handover minus approval (blank when sequence is impossible) |
| carrier_to_delivery_days | Customer delivery minus carrier handover (blank when sequence is impossible) |
| long_delivery_over_100d | 1 if delivery took more than 100 days |
| dq_flags | Data-quality issues for that row, separated by `|` (blank = none) |
| low_rating_flag | 1 for review scores 1-2 (reviews and analysis tables) |

Extra columns in `orders_analysis_table`: item_count, item_sales_value (sum of prices), freight_total, seller_count, payment_total, max_installments, main_payment_type, review_score.

## Key numbers after cleaning
- 99,441 orders; 96,470 valid delivered orders, of which 7,826 were late (about 8.1% of valid delivered orders)
- 98,673 orders have one review each; 768 orders have no review
- 775 orders have no items (mostly cancelled or unavailable), so item_sales_value is blank for them

## Things to keep in mind
- `item_sales_value` is price only; neither price nor freight is profit.
- `payment_total` can differ from item value plus freight (vouchers, rounding); 249 orders differ by more than 1.
- 157 customer ZIP prefixes have no match in the geolocation table, so they have no coordinates.
- Cancelled and unavailable orders are still in the tables. Filter by `order_status` if the dashboard should show only completed sales.
