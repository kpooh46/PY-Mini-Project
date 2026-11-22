import matplotlib.pyplot as plt
from pathlib import Path

# Top five categories from PostgreSQL
categories = [
    "Health & Beauty",
    "Watches & Gifts",
    "Bed, Bath & Table",
    "Sports & Leisure",
    "Computer Accessories"
]

sales = [
    1258881.34,
    1205005.68,
    1036488.68,
    988998.97,
    911954.32
]

plt.figure(figsize=(11, 6))

bars = plt.barh(categories, sales, color="#2a9d8f")

plt.title("Shoplytics - Top 5 Product Categories")
plt.xlabel("Item Sales Value (BRL)")
plt.gca().invert_yaxis()

for bar in bars:
    width = bar.get_width()
    plt.text(
        width + 10000,
        bar.get_y() + bar.get_height() / 2,
        f"R${width:,.0f}",
        va="center",
        fontsize=9
    )

plt.xlim(0, 1500000)
plt.tight_layout()

output = Path(__file__).parent / "top5_categories.png"
plt.savefig(output, dpi=300)

plt.show()