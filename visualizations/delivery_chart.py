import matplotlib.pyplot as plt
from pathlib import Path

# Delivery results from PostgreSQL
delivery_status = ["On time", "Late"]
orders = [88644, 7826]

plt.figure(figsize=(8, 5))

bars = plt.bar(
    delivery_status,
    orders,
    color=["#2a9d8f", "#e76f51"]
)

plt.title("Shoplytics - Delivery Performance")
plt.ylabel("Number of Orders")

for bar in bars:
    height = bar.get_height()
    plt.text(
        bar.get_x() + bar.get_width() / 2,
        height + 1000,
        f"{int(height):,}",
        ha="center"
    )

plt.ylim(0, 105000)
plt.tight_layout()

output = Path(__file__).parent / "delivery_performance.png"
plt.savefig(output, dpi=300)

plt.show()