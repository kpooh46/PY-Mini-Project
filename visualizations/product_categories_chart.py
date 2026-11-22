import matplotlib.pyplot as plt
from pathlib import Path

# Product category results from PostgreSQL
categories = [
    "Furniture & Decor",
    "Cool Stuff",
    "Housewares",
    "Auto",
    "Garden Tools"
]

sales = [
    729762.49,
    635290.85,
    632248.66,
    592720.11,
    485256.46
]

plt.figure(figsize=(10, 6))

bars = plt.barh(categories, sales, color="#2a9d8f")

plt.title("Shoplytics - Selected Product Category Sales")
plt.xlabel("Item Sales Value (BRL)")
plt.gca().invert_yaxis()

for bar in bars:
    width = bar.get_width()
    plt.text(
        width + 5000,
        bar.get_y() + bar.get_height() / 2,
        f"R${width:,.0f}",
        va="center"
    )

plt.xlim(0, 850000)
plt.tight_layout()

output = Path(__file__).parent / "product_categories.png"
plt.savefig(output, dpi=300)

plt.show()