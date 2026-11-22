import matplotlib.pyplot as plt
from pathlib import Path

# Results from PostgreSQL
delivery_status = ["On time", "Late"]
ratings = [4.29, 2.57]

plt.figure(figsize=(8, 5))

bars = plt.bar(
    delivery_status,
    ratings,
    color=["#2a9d8f", "#e76f51"]
)

plt.title("Shoplytics - Customer Ratings by Delivery Status")
plt.ylabel("Average Review Score")
plt.ylim(0, 5)

for bar in bars:
    height = bar.get_height()
    plt.text(
        bar.get_x() + bar.get_width() / 2,
        height + 0.1,
        f"{height:.2f}",
        ha="center"
    )

plt.tight_layout()

output = Path(__file__).parent / "customer_ratings.png"
plt.savefig(output, dpi=300)

plt.show()