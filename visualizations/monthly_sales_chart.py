import matplotlib.pyplot as plt
from pathlib import Path

# Top 5 sales months from our PostgreSQL analysis
months = ["Nov 2017", "May 2018", "Apr 2018",
          "Mar 2018", "Jan 2018"]

sales = [987765.37, 977544.69, 973534.09,
         953356.25, 924645.00]

# Create bar chart
plt.figure(figsize=(10, 6))

bars = plt.bar(
    months,
    sales,
    color="#2a9d8f"
)

plt.title("Shoplytics - Top 5 Sales Months")
plt.xlabel("Month")
plt.ylabel("Item Sales Value (BRL)")

# Add sales values above the bars
for bar in bars:
    height = bar.get_height()
    plt.text(
        bar.get_x() + bar.get_width() / 2,
        height + 10000,
        f"R${height:,.0f}",
        ha="center",
        fontsize=9
    )

plt.ylim(0, 1150000)
plt.tight_layout()

# Save chart in visualizations folder
output = Path(__file__).parent / "monthly_sales.png"
plt.savefig(output, dpi=300)

plt.show()