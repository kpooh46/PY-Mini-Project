Shoplytics — Data Quality Report

1. Purpose

This report documents data-quality checks performed on the cleaned Olist e-commerce datasets imported into PostgreSQL.

The checks focused on missing identifiers, duplicate IDs, missing delivery dates and missing product attributes.

2. Order Data Quality

| Check | Result |
|---|---:|
| Total orders | 99,441 |
| Missing order IDs | 0 |
| Missing customer IDs | 0 |
| Duplicate order IDs | 0 |
| Missing actual delivery dates | 2,965 |
| Delivered orders missing actual delivery dates | 8 |

The missing delivery dates require careful interpretation because many orders were not marked as delivered.

Eight orders marked as delivered lacked actual delivery dates and therefore cannot be classified as on time or late using the recorded delivery date.

3. Identifier Quality

Dataset	Total rows	Missing IDs	Duplicate IDs
Customers	99,441	0	0
Products	32,951	0	0
Sellers	3,095	0	0

The checked identifier columns were complete and unique.

4. Product Attribute Completeness

Check	Result
Total products	32,951
Missing category names	0
Missing weights	6
Missing lengths	2
Missing heights	2
Missing widths	2

Missing physical measurements should be considered when performing shipping-related calculations.

5. Data Handling Recommendations

* Preserve orders that legitimately lack delivery dates because they were not delivered.
* Flag delivered orders with missing delivery dates for investigation.
* Avoid imputing product weights or dimensions without a documented method.
* Exclude records from specific calculations only when the required information is unavailable.
* Retain the original cleaned datasets for reproducibility.

6. Limitations

These checks confirm the results of selected SQL validation queries. They do not establish that all possible data-quality issues have been identified.

The cleaning operations performed before the CSV files were supplied have not yet been independently verified.

7. Conclusion

The checked customer, product, seller and order identifiers showed no missing or duplicate IDs.

Some delivery dates and product dimensions were missing. These issues should be considered when interpreting delivery and shipping-related indicators.

The findings provide a basis for further validation and transparent reporting.