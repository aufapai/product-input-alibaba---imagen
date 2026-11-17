import sqlite3

m_conn = sqlite3.connect("FINAL/master_products_consolidated.db")
c = m_conn.cursor()
c.execute("SELECT name FROM sqlite_master WHERE type='table'")
print("Tables in master DB:", c.fetchall())

