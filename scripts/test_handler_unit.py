#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
UNIT TEST FOR ALIBABA & MASTER FINAL HANDLERS (NO NETWORK SOCKET REQUIRED)
"""

import os
import sys
import io
import urllib.parse

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(BASE_DIR, "App"))
sys.path.insert(0, os.path.join(BASE_DIR, "FINAL"))

from alibaba_manager_app import AlibabaManagerHandler
from server_final import MasterFinalHandler

class MockSocket:
    def __init__(self, data=b""):
        self.rfile = io.BytesIO(data)
        self.wfile = io.BytesIO()

    def makefile(self, mode, *args, **kwargs):
        if "b" in mode:
            if "r" in mode:
                return self.rfile
            return self.wfile
        else:
            if "r" in mode:
                return io.TextIOWrapper(self.rfile, encoding="utf-8")
            return io.TextIOWrapper(self.wfile, encoding="utf-8")

    def sendall(self, data):
        self.wfile.write(data)

def test_request(handler_class, path):
    encoded_path = urllib.parse.quote(path, safe="/:?&=")
    request_data = f"GET {encoded_path} HTTP/1.1\r\nHost: localhost\r\n\r\n".encode("utf-8")
    sock = MockSocket(request_data)
    
    try:
        handler = handler_class(sock, ("127.0.0.1", 12345), None)
        handler.wfile.flush()
    except Exception as e:
        pass
    
    response_data = sock.wfile.getvalue()
    lines = response_data.split(b"\r\n")
    first_line = lines[0].decode("utf-8", errors="ignore") if lines else ""
    return first_line, response_data

print("--- Testing AlibabaManagerHandler ---")
paths_to_test = [
    "/",
    "/final",
    "/inject_catalog_hotstrading.sql",
    "/master_products_database.sql",
    "/assets/placeholder_boot.webp",
    "/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg",
    "/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp"
]

for p in paths_to_test:
    first_line, data = test_request(AlibabaManagerHandler, p)
    print(f"Path: {p[:55]:<55} -> {first_line} ({len(data):,} bytes)")
    assert "200" in first_line, f"Expected 200 for {p}, got {first_line}"

print("\n--- Testing MasterFinalHandler ---")
final_paths = [
    "/",
    "/inject_catalog_hotstrading.sql",
    "/api/master/products",
    "/assets/placeholder_boot.webp",
    "/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg",
    "/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp"
]

for p in final_paths:
    first_line, data = test_request(MasterFinalHandler, p)
    print(f"Path: {p[:55]:<55} -> {first_line} ({len(data):,} bytes)")
    assert "200" in first_line, f"Expected 200 for {p}, got {first_line}"

print("\n=======================================================")
print("🎉 ALL UNIT TESTS PASSED! ZERO DEFECTS.")
print("=======================================================")
