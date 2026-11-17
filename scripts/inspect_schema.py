import re

with open("Database/hotj4796_hotstrading (4).sql", "r", encoding="utf-8", errors="ignore") as f:
    sql = f.read()

for t in ["categories", "manufacturers"]:
    m = re.findall(rf"INSERT INTO `{t}`.*?;", sql, re.DOTALL)
    for ins in m:
        print("="*40)
        print(f"TABLE: {t}")
        print(ins[:1500])

# Also check how many products exist and what the highest ID is
m_prod = re.findall(r"INSERT INTO `products`.*?;", sql, re.DOTALL)
print("Products insert count:", len(m_prod))
if m_prod:
    print("Products sample:\n", m_prod[0][:1500])
