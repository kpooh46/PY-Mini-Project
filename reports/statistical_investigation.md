Shoplytics — Statistical Investigation

1. Objective

Investigate whether the average customer review score differs between orders delivered on time and orders delivered late in the cleaned Olist e-commerce data.

2. Research Hypotheses

* Null hypothesis (H₀): Mean review scores are equal for on-time and late deliveries.
* Alternative hypothesis (H₁): Mean review scores differ between on-time and late deliveries.

3. Data and Method

The PostgreSQL analysis joined olist_orders_clean with olist_order_reviews_clean by order_id. It included orders marked delivered with non-missing actual delivery dates, estimated delivery dates and review scores.

A delivery was classified as on time when order_delivered_customer_date <= order_estimated_delivery_date; otherwise it was classified as late. The test uses a two-sided Welch’s independent-samples t-test, which permits different group variances.

The sample statistics below come from the PostgreSQL results. The significance-test calculations use the rounded mean scores and standard deviations displayed by that query, so the results are approximate.

4. Descriptive Statistics

|Delivery status|Number of reviews|Mean rating (out of 5)|Standard deviation|
|:--------------|----------------:|---------------------:|-----------------:|
|On time        |88,163           |4.29                  |1.147             |
|Late           |7,661            |2.57                  |1.658             |

On-time deliveries received an average rating 1.72 points higher than late deliveries.

5. Statistical Results

|Statistic                                              |Approximate result|
|:------------------------------------------------------|-----------------:|
|Difference in means (on time − late)                   |1.72              |
|Standard error                                         |0.01933           |
|Welch’s t-statistic                                    |88.97             |
|Welch–Satterthwaite degrees of freedom                 |8,309             |
|Two-sided p-value                                      |< 0.001           |
|Approximate 95% confidence interval for mean difference|1.68 to 1.76      |
|Significance level                                     |0.05              |

Decision: Reject the null hypothesis at the 5% significance level. The data provide strong evidence of a difference in average review scores between the two delivery groups, subject to the assumptions below.

6. Interpretation

The observed association is substantial: orders classified as on time had markedly higher customer review scores. This finding supports treating delivery reliability as an important area for operational investigation and KPI monitoring.

This is an association, not proof of causation. Other factors, such as product quality, seller performance, order complexity or customer expectations, may influence review scores and delivery times.

7. Business Recommendations

* Monitor the frequency of late deliveries and the corresponding customer ratings.
* Investigate carrier, seller and geographic patterns among late orders.
* Improve customer notifications when estimated delivery dates are likely to be missed.
* Recheck review-score differences after operational changes, while accounting for other possible influences.

8. Limitations

* The analysis uses observational historical e-commerce data and does not establish causality.
* The t-test assumes independent observations; repeated reviews from the same customer or overlapping processes may affect independence.
* Review scores are ordinal and limited to 1–5. The mean-comparison test is an approximation; nonparametric or sensitivity analyses could complement it.
* Actual and estimated delivery dates must both exist for an order to be classified. Eight orders marked delivered had no actual delivery date in the earlier quality check.
* The reported statistics are approximate because SQL displayed rounded means and standard deviations.
* If timestamp comparisons differ from a calendar-date definition of punctuality, the operational definition should be documented consistently.

9. Conclusion

Customer ratings were statistically significantly higher among on-time deliveries than late deliveries in the analyzed records. The difference in sample mean ratings was approximately 1.72 points (95% confidence interval approximately 1.68–1.76; two-sided p < 0.001). Delivery punctuality merits close monitoring, while further investigation is needed to understand causal drivers.

────────

Project: Shoplytics — E-Commerce Sales and Performance Analysis
Data source: Cleaned Brazilian Olist e-commerce dataset in PostgreSQL
Analysis: Grouped SQL descriptive statistics and approximate Welch’s t-test