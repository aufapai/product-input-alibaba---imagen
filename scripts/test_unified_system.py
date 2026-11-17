#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
VERIFICATION TEST SUITE FOR COMPLETE UNIFIED MASTER SYSTEM & LOCAL ACCESS
- Tests Database/alibaba_master.db (SQLite)
- Tests FINAL/master_products_consolidated.db (SQLite)
- Tests FINAL/inject_catalog_hotstrading.sql (MySQL MariaDB)
- Tests Local HTTP Static Assets & SQL downloads via alibaba_manager_app
"""

import os
import sys
import json
import sqlite3
import threading
import time
import urllib.request

sys.stdout.reconfigure(encoding='utf-8')

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(BASE_DIR, "App"))
sys.path.insert(0, os.path.join(BASE_DIR, "FINAL"))

print("====================================================================")
print(" RUNNING AUTOMATED COMPREHENSIVE VERIFICATION TEST SUITE")
print("====================================================================")

# 1. Test FINAL/master_products_consolidated.db
db1_path = os.path.join(BASE_DIR, "FINAL", "master_products_consolidated.db")
assert os.path.exists(db1_path), "master_products_consolidated.db missing!"
conn1 = sqlite3.connect(db1_path)
c1 = conn1.cursor()
c1.execute("SELECT COUNT(*) FROM master_products")
p_count = c1.fetchone()[0]
assert p_count == 125, f"Expected 125 products, got {p_count}"

c1.execute("SELECT COUNT(*) FROM product_reference_images")
img_count = c1.fetchone()[0]
assert img_count >= 2000, f"Expected >= 2000 images, got {img_count}"

c1.execute("SELECT COUNT(*) FROM product_reference_images WHERE source_flag = 'TOKOPEDIA_LOCAL'")
tok_local_count = c1.fetchone()[0]
print(f"✓ FINAL Database verified: {p_count} Master Products, {img_count} Reference Images ({tok_local_count} Local Tokopedia Offline)")
conn1.close()

# 2. Test Database/alibaba_master.db
db2_path = os.path.join(BASE_DIR, "Database", "alibaba_master.db")
assert os.path.exists(db2_path), "alibaba_master.db missing!"
conn2 = sqlite3.connect(db2_path)
c2 = conn2.cursor()
c2.execute("SELECT COUNT(*) FROM master_products")
p_count2 = c2.fetchone()[0]
assert p_count2 == 125, f"Expected 125 products in alibaba_master.db, got {p_count2}"

c2.execute("SELECT COUNT(*) FROM products WHERE source = 'MASTER_FINAL'")
master_upsert_count = c2.fetchone()[0]
assert master_upsert_count == 125, f"Expected 125 master rows in products table, got {master_upsert_count}"
print(f"✓ Database/alibaba_master.db verified: {p_count2} Master Products, {master_upsert_count} synced products table rows")
conn2.close()

# 3. Test FINAL/inject_catalog_hotstrading.sql
sql_path = os.path.join(BASE_DIR, "FINAL", "inject_catalog_hotstrading.sql")
assert os.path.exists(sql_path), "inject_catalog_hotstrading.sql missing!"
with open(sql_path, "r", encoding="utf-8") as f:
    sql_text = f.read()

assert "INSERT INTO `categories`" in sql_text, "Missing categories insert!"
assert "INSERT INTO `manufacturers`" in sql_text, "Missing manufacturers insert!"
assert "INSERT INTO `products`" in sql_text, "Missing products insert!"
assert "INSERT INTO `product_specifications`" in sql_text, "Missing specifications insert!"
assert "INSERT INTO `product_use_cases`" in sql_text, "Missing use cases insert!"
assert "INSERT INTO `product_regions`" in sql_text, "Missing regions insert!"
assert "INSERT INTO `product_certifications`" in sql_text, "Missing certifications insert!"
assert "INSERT INTO `alibaba_export_listings`" in sql_text, "Missing alibaba export insert!"
print(f"✓ inject_catalog_hotstrading.sql verified: {len(sql_text):,} bytes with all 8 core tables populated")

# 4. Test Local Web Server & Asset Endpoints
from alibaba_manager_app import AlibabaManagerHandler
import socketserver

PORT_TEST = 8998
socketserver.TCPServer.allow_reuse_address = True
httpd = socketserver.TCPServer(('', PORT_TEST), AlibabaManagerHandler)
t = threading.Thread(target=httpd.serve_forever, daemon=True)
t.start()
time.sleep(0.5)

endpoints_to_test = [
    ("/", "text/html"),
    ("/final", "text/html"),
    ("/inject_catalog_hotstrading.sql", "application/sql"),
    ("/master_products_database.sql", "application/sql"),
    ("/assets/placeholder_boot.webp", "image/svg+xml"),
    ("/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg", "image/jpeg"),
    ("/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp", "image/webp")
]

for ep, expected_mime in endpoints_to_test:
    url = f"http://localhost:{PORT_TEST}{ep}"
    req = urllib.request.Request(url)
    with urllib.request.urlopen(req, timeout=5) as resp:
        assert resp.status == 200, f"Expected 200 for {ep}, got {resp.status}"
        ctype = resp.headers.get("Content-Type", "")
        assert expected_mime in ctype, f"Expected {expected_mime} in {ctype} for {ep}"
        data_len = len(resp.read())
        print(f"✓ Endpoint {ep[:45]:<45} -> Status 200 OK ({ctype.split(';')[0]}, {data_len:,} bytes)")

httpd.shutdown()
httpd.server_close()

print("====================================================================")
print("🎉 ALL TESTS PASSED! ZERO DEFECTS DETECTED.")
print("====================================================================")

