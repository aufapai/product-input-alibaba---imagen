#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
END-TO-END TEST SUITE: ALIBABA EXTENSION BRIDGE + CHROME EXTENSION + LOCAL ASSETS
Starts AlibabaManagerHandler on a local test port inside the same process,
probes all HTTP GET/POST endpoints over real TCP/HTTP, validates JS/JSON/Batch files,
and checks message-type parity between popup/content_overlay and background.js.
"""

import os
import sys
import re
import json
import time
import sqlite3
import threading
import subprocess
import socketserver
import urllib.request
import urllib.parse

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(BASE_DIR, "App"))

from alibaba_manager_app import AlibabaManagerHandler

_NO_PROXY_OPENER = urllib.request.build_opener(urllib.request.ProxyHandler({}))

def http_get_json(url):
    with _NO_PROXY_OPENER.open(url, timeout=8) as resp:
        assert resp.status == 200, f"GET {url} returned {resp.status}"
        return json.loads(resp.read().decode("utf-8"))

def http_post_json(url, payload):
    body = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(
        url,
        data=body,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    with _NO_PROXY_OPENER.open(req, timeout=8) as resp:
        assert resp.status == 200, f"POST {url} returned {resp.status}"
        return json.loads(resp.read().decode("utf-8"))

def run_tests():
    print("===================================================================")
    print(" E2E VERIFICATION: HOTS ALIBABA EXTENSION + FLOW + LOCAL BRIDGE")
    print("===================================================================")

    # 1. Start real HTTP server in background thread (ephemeral port)
    socketserver.TCPServer.allow_reuse_address = True
    httpd = socketserver.TCPServer(("127.0.0.1", 0), AlibabaManagerHandler)
    port = httpd.server_address[1]
    base_url = f"http://127.0.0.1:{port}"
    t = threading.Thread(target=httpd.serve_forever, daemon=True)
    t.start()
    time.sleep(0.3)
    print(f"[1/5] Local Bridge HTTP Server started for test at {base_url}")

    try:
        # 2. Probe Core GET Endpoints
        health = http_get_json(f"{base_url}/api/ext/health")
        assert health["success"] is True and health["total_master_skus"] == 125
        assert health["chrome_profile_target"] == "aufahots@gmail.com"
        print(f"  ✓ /api/ext/health -> ONLINE, {health['total_master_skus']} SKU, target={health['chrome_profile_target']}")

        cats = http_get_json(f"{base_url}/api/ext/categories")
        assert cats["success"] is True and len(cats["categories"]) == 11
        print(f"  ✓ /api/ext/categories -> {len(cats['categories'])} kategori folder resmi")

        q_all = http_get_json(f"{base_url}/api/ext/queue")
        assert q_all["success"] is True and q_all["count"] == 125
        print(f"  ✓ /api/ext/queue -> {q_all['count']} SKU dimuat")

        q_kids = http_get_json(f"{base_url}/api/ext/queue?category=08_Kids_Boots")
        assert q_kids["success"] is True and q_kids["count"] > 0
        assert all(it["photobank_group"] == "08_Kids_Boots" for it in q_kids["items"])
        print(f"  ✓ /api/ext/queue?category=08_Kids_Boots -> {q_kids['count']} SKU terfilter akurat")

        q_search = http_get_json(f"{base_url}/api/ext/queue?q=terra")
        assert q_search["success"] is True and q_search["count"] > 0
        print(f"  ✓ /api/ext/queue?q=terra -> {q_search['count']} SKU ditemukan")

        # 3. Probe Product Details & Local Images
        for sku, expected_group in [("MST-001", "01_Safety_Boots"), ("MST-080", "08_Kids_Boots")]:
            prod = http_get_json(f"{base_url}/api/ext/product/{sku}")
            assert prod["success"] is True and prod["lock"] is True
            assert prod["Photobank_Group"] == expected_group, f"{sku} got {prod['Photobank_Group']}"
            assert prod["MOQ"] > 0 and prod["Price_Min"] > 0 and prod["Price_Max"] >= prod["Price_Min"]
            assert len(prod["images"]) > 0
            # Fetch first local image over HTTP
            first_img = prod["images"][0]
            img_path = first_img["path"] if first_img["path"].startswith("/") else "/" + first_img["path"]
            img_url = base_url + urllib.parse.quote(img_path, safe="/")
            with _NO_PROXY_OPENER.open(img_url, timeout=8) as ir:
                assert ir.status == 200
                img_bytes = ir.read()
                assert len(img_bytes) > 500
            print(f"  ✓ /api/ext/product/{sku} -> Group={expected_group}, lock=True, MOQ={prod['MOQ']}, FOB=${prod['Price_Min']}-${prod['Price_Max']}, img={len(img_bytes):,} bytes")

        # 4. Probe Google Flow 4-Slot Jobs
        flow_jobs = http_get_json(f"{base_url}/api/ext/flow-jobs/MST-001")
        assert flow_jobs["success"] is True and len(flow_jobs["jobs"]) == 4
        slot_keys = [j["slot_key"] for j in flow_jobs["jobs"]]
        assert slot_keys == ["slot_1_hero", "slot_2_side", "slot_3_tread", "slot_4_contextual"]
        print(f"  ✓ /api/ext/flow-jobs/MST-001 -> 4 slot siap: {slot_keys}")

        # 5. Probe POST /api/ext/sync-alibaba-list & /api/ext/status (and restore status)
        conn = sqlite3.connect(os.path.join(BASE_DIR, "Database", "alibaba_master.db"))
        orig_row = conn.execute("SELECT status, alibaba_product_id FROM products WHERE sku='MST-001'").fetchone()
        conn.close()

        sync_res = http_post_json(f"{base_url}/api/ext/sync-alibaba-list", {
            "items": [{"alibaba_product_id": "1600999888", "title": "AP MAX Coklat Hitam Waterproof Safety Boots"}]
        })
        assert sync_res["success"] is True and sync_res["matched_master_skus"] >= 1
        print(f"  ✓ POST /api/ext/sync-alibaba-list -> matched={sync_res['matched_master_skus']}")

        # Restore original status
        if orig_row:
            restore_res = http_post_json(f"{base_url}/api/ext/status", {
                "sku": "MST-001",
                "status": orig_row[0] or "APPROVED",
                "alibaba_product_id": orig_row[1] or ""
            })
            assert restore_res["success"] is True
            print("  ✓ POST /api/ext/status -> verified & restored clean DB state")

        # 6. Probe UI pages
        for ui_path in ["/", "/final"]:
            with _NO_PROXY_OPENER.open(f"{base_url}{ui_path}", timeout=8) as r:
                assert r.status == 200 and len(r.read()) > 10000
                print(f"  ✓ GET {ui_path} -> HTTP 200 OK")

    finally:
        httpd.shutdown()
        httpd.server_close()

    # 7. Validate Chrome Extension Manifest, JS Syntax & Message Parity
    print("\n[2/5] Validating Chrome_Extension/ Manifest & JS Syntax...")
    ext_dir = os.path.join(BASE_DIR, "Chrome_Extension")
    with open(os.path.join(ext_dir, "manifest.json"), encoding="utf-8") as f:
        mf = json.load(f)
    for perm in ["activeTab", "tabs", "tabGroups", "storage", "downloads"]:
        assert perm in mf["permissions"], f"Missing permission: {perm}"
    print(f"  ✓ manifest.json MV3 valid, permissions={mf['permissions']}")

    js_files = ["background.js", "popup.js", "content_overlay.js"]
    for jf in js_files:
        jpath = os.path.join(ext_dir, jf)
        assert os.path.exists(jpath), f"Missing {jf}"
        # Check with node --check if available
        try:
            res = subprocess.run(["node", "--check", jpath], capture_output=True, text=True, timeout=5)
            if res.returncode != 0:
                raise AssertionError(f"JS syntax error in {jf}: {res.stderr}")
            print(f"  ✓ node --check {jf} -> syntax OK")
        except FileNotFoundError:
            print(f"  ℹ node not found; checked existence of {jf}")

    # 8. Verify message parity between callers (popup.js + content_overlay.js) and background.js
    print("\n[3/5] Checking Extension Message Parity...")
    with open(os.path.join(ext_dir, "background.js"), encoding="utf-8") as f:
        bg_txt = f.read()
    handled_types = set(re.findall(r'msg\.type\s*===\s*"([A-Z0-9_]+)"', bg_txt))

    for caller in ["popup.js", "content_overlay.js"]:
        with open(os.path.join(ext_dir, caller), encoding="utf-8") as f:
            c_txt = f.read()
        sent_types = set(re.findall(r'sendMessage\(\s*\{\s*type:\s*"([A-Z0-9_]+)"', c_txt))
        sent_types |= set(re.findall(r'sendMsg\(\s*\{\s*type:\s*"([A-Z0-9_]+)"', c_txt))
        missing = sent_types - handled_types
        assert not missing, f"{caller} sends unhandled message types: {missing}"
        print(f"  ✓ {caller} -> all {len(sent_types)} message types handled in background.js")

    # 9. Verify Batch Script Safety
    print("\n[4/5] Checking Batch & Launcher Scripts...")
    bat_path = os.path.join(BASE_DIR, "run_alibaba_extension_flow.bat")
    with open(bat_path, encoding="utf-8") as f:
        for idx, line in enumerate(f, 1):
            low = line.strip().lower()
            if low.startswith("title ") or low.startswith("echo "):
                assert "&" not in line, f"Unescaped & in {bat_path} line {idx}: {line}"
    print("  ✓ run_alibaba_extension_flow.bat -> clean (no unescaped &)")

    print("\n[5/5] Summary:")
    print("  🎉 ALL E2E TESTS PASSED WITHOUT ERRORS!")

if __name__ == "__main__":
    run_tests()
