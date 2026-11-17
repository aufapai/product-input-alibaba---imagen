import sqlite3

conn = sqlite3.connect('FINAL/master_products_consolidated.db')
c = conn.cursor()
c.execute("SELECT source_flag, COUNT(*) FROM product_reference_images GROUP BY source_flag")
print("Sources in product_reference_images:", c.fetchall())

c.execute("SELECT master_sku, source_flag, flag_label, image_url FROM product_reference_images LIMIT 15")
for r in c.fetchall():
    print(" ", r)
