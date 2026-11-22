Shoplytics — Data Cleaning and Validation Notes

1. Purpose and Scope

These notes document checks verified in PostgreSQL on the cleaned Brazilian Olist e-commerce tables, and identify items requiring follow-up. They do not claim that any particular transformation was performed when the original cleaning script or cleaning log has not been inspected.

The analyzed inputs are cleaned CSVs imported into the shoplytics PostgreSQL database. The detailed column inventory is in data_dictionary_columns.csv; business definitions are summarized in data_dictionary.md.

2. Verified Order-Table Checks

|Check                                        |Observed result|Interpretation / action                                   |
|---------------------------------------------|--------------:|----------------------------------------------------------|
|Total order records                          |99,441         |Scope of order validation                                 |
|Missing order_id                           |0              |No missing order identifiers observed                     |
|Duplicate order_id                         |0              |No repeated order identifiers observed                    |
|Missing customer_id                        |0              |No missing order-to-customer identifiers observed         |
|Missing order_delivered_customer_date      |2,965          |Do not assume all are errors; investigate by order status |
|Delivered orders missing actual delivery date|8              |Flag as inconsistent / incomplete for punctuality analysis|

Most missing actual delivery dates occur in orders not marked delivered. Only eight orders marked delivered were observed without an actual delivery date. For delivery-punctuality calculations, exclude records without both dates and state the denominator explicitly; preserve these rows in the source tables.

3. Verified Identifier Checks

|Table                  |Records|Missing primary identifier values|Duplicate identifier values|
|-----------------------|------:|--------------------------------:|--------------------------:|
|olist_customers_clean|99,441 |0                                |0                          |
|olist_products_clean |32,951 |0                                |0                          |
|olist_sellers_clean  |3,095  |0                                |0                          |

These checks only establish completeness and uniqueness of the respective IDs, not full record correctness or referential integrity.

4. Verified Product-Attribute Checks

|Check in olist_products_clean|Missing values|
|-------------------------------|-------------:|
|product_category_name        |0             |
|product_weight_g             |6             |
|product_length_cm            |2             |
|product_height_cm            |2             |
|product_width_cm             |2             |

The missing measurement counts may overlap across records. Do not add the counts to infer the number of distinct affected products. Keep affected products available for analyses not requiring measurements; for shipping-related analyses, filter only the fields needed and disclose exclusions.

5. Handling Rules Recommended for Analysis

|Situation                                 |Recommended handling                                               |Implemented during original cleaning?|
|------------------------------------------|-------------------------------------------------------------------|-------------------------------------|
|Undelivered orders without delivery date  |Retain; do not classify as late/on time                            |Not verified                         |
|Delivered order without delivery date     |Flag for quality review; omit from punctuality calculation         |Not verified                         |
|Products with missing dimensions or weight|Preserve; exclude only from metrics requiring those attributes     |Not verified                         |
|Missing or repeated IDs                   |Investigate before joining; none found in the checked ID fields    |Not applicable to observed checks    |
|Timestamp comparisons                     |Specify whether punctuality uses exact timestamps or calendar dates|Definition requires confirmation     |

Important: The rules above are recommendations for downstream analysis, not a record of edits already applied to CSVs.

6. Outstanding Validation and Cleaning Provenance

Before calling the cleaning workflow fully documented, confirm from the original preparation script(s), if available:

* Original CSV sources and source-to-cleaned file mapping
* Whether column types, date formats, names, encodings, or missing-value markers were changed
* Whether records were dropped, deduplicated, joined, or aggregated
* Treatment of outliers and invalid amounts, prices or timestamps
* Key relationships across orders, items, payments, reviews, customers, sellers and products
* Whether a separate log or README records these decisions

The 11 cleaned datasets were imported and SQL analysis completed, but the transformations applied before import are not established by the checks above.

7. Reproducibility and Deliverables

* sql/shoplytics_create_tables.sql — schema creation
* sql/import_cleaned_csvs.psql — data import commands
* sql/shoplytics_analysis.sql — analytical queries
* reports/data_dictionary_columns.csv — 113 exported column records including name, PostgreSQL type and nullability
* reports/data_dictionary.md — business descriptions for selected key columns
* reports/data_quality_report.md — detailed quality findings
* reports/statistical_investigation.md — review-score comparison by delivery timeliness

8. Conclusion

Validation found complete and unique checked IDs, 2,965 missing actual delivery dates (including eight orders recorded as delivered), and a small number of missing product measurements. These issues should be transparently acknowledged. The original data-cleaning transformations remain unverified until the preprocessing scripts or cleaning records are reviewed.