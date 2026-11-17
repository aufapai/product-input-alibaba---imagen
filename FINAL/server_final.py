#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
DEDICATED HTTP SERVER FOR UNIFIED MASTER PRODUCT CATALOG (FINAL)
PT Indo Sukses Semesta - HOTS Trading
Port: 8899 (Default)
"""

import os
import sys
import json
import subprocess
import socketserver
import http.server
import urllib.parse

sys.stdout.reconfigure(encoding='utf-8')

FINAL_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(FINAL_DIR)
PORT = 8899

# Asset directories
SHOPEE_DIR = os.path.join(BASE_DIR, "Shopee_Product_Assets")
PHOTOBANK_DIR = os.path.join(BASE_DIR, "Output", "Photobank_Siap_Upload")
TOKOPEDIA_DIR = os.path.join(BASE_DIR, "Images_Tokopedia")
KATALOG_DIR = os.path.join(BASE_DIR, "Images_Produk_Katalog")

class MasterFinalHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=FINAL_DIR, **kwargs)

    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

    def do_GET(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path

        # Root redirect
        if path in ['/', '/index.html']:
            self.path = '/index.html'
            return super().do_GET()

        # Static assets routing
        if path.startswith('/assets/shopee/'):
            rel = urllib.parse.unquote(path[len('/assets/shopee/'):])
            file_path = os.path.join(SHOPEE_DIR, rel.replace('/', os.sep))
            return self.serve_direct_file(file_path)

        elif path.startswith('/assets/photobank/'):
            rel = urllib.parse.unquote(path[len('/assets/photobank/'):])
            file_path = os.path.join(PHOTOBANK_DIR, rel.replace('/', os.sep))
            return self.serve_direct_file(file_path)

        elif path.startswith('/assets/tokopedia/'):
            rel = urllib.parse.unquote(path[len('/assets/tokopedia/'):])
            file_path = os.path.join(TOKOPEDIA_DIR, rel.replace('/', os.sep))
            return self.serve_direct_file(file_path)

        elif path.startswith('/assets/katalog/'):
            rel = urllib.parse.unquote(path[len('/assets/katalog/'):])
            file_path = os.path.join(KATALOG_DIR, rel.replace('/', os.sep))
            return self.serve_direct_file(file_path)

        elif path == '/assets/placeholder_boot.webp' or path == '/assets/placeholder_boot.png':
            return self.serve_svg_placeholder()

        elif path in ['/inject_catalog_hotstrading.sql', '/api/catalog/sql']:
            fpath = os.path.join(FINAL_DIR, 'inject_catalog_hotstrading.sql')
            return self.serve_direct_file(fpath)

        # API Endpoints
        elif path == '/api/master/products':
            json_file = os.path.join(FINAL_DIR, 'master_products_catalog.json')
            if os.path.exists(json_file):
                with open(json_file, 'rb') as f:
                    content = f.read()
                self.send_response(200)
                self.send_header('Content-Type', 'application/json; charset=utf-8')
                self.send_header('Content-Length', str(len(content)))
                self.end_headers()
                self.wfile.write(content)
                return
            else:
                self.send_json({"error": "Master JSON not generated yet"}, status=404)
                return

        elif path == '/api/master/stats':
            json_file = os.path.join(FINAL_DIR, 'master_products_catalog.json')
            if os.path.exists(json_file):
                with open(json_file, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                meta = data.get("metadata", {})
                self.send_json({"success": True, "stats": meta})
                return
            else:
                self.send_json({"error": "Data not ready"}, status=404)
                return

        return super().do_GET()

    def do_POST(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path

        if path == '/api/master/resync':
            try:
                script_path = os.path.join(FINAL_DIR, "consolidate_master.py")
                res = subprocess.run([sys.executable, script_path], capture_output=True, text=True, check=True)
                self.send_json({"success": True, "output": res.stdout[-300:]})
            except Exception as e:
                self.send_json({"success": False, "error": str(e)}, status=500)
            return

        self.send_json({"error": "Endpoint not found"}, status=404)

    def serve_direct_file(self, file_path):
        if not os.path.exists(file_path) or not os.path.isfile(file_path):
            return self.serve_svg_placeholder()
        
        ext = os.path.splitext(file_path)[1].lower()
        content_type = "application/octet-stream"
        if ext in ['.webp']: content_type = "image/webp"
        elif ext in ['.jpg', '.jpeg']: content_type = "image/jpeg"
        elif ext in ['.png']: content_type = "image/png"
        elif ext in ['.json']: content_type = "application/json"
        elif ext in ['.xlsx']: content_type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        elif ext in ['.csv']: content_type = "text/csv"

        try:
            with open(file_path, 'rb') as f:
                data = f.read()
            self.send_response(200)
            self.send_header('Content-Type', content_type)
            self.send_header('Content-Length', str(len(data)))
            self.send_header('Cache-Control', 'public, max-age=86400')
            self.end_headers()
            self.wfile.write(data)
        except Exception as e:
            self.send_response(500)
            self.end_headers()
            self.wfile.write(f"Error reading file: {e}".encode())

    def serve_svg_placeholder(self):
        svg = """<svg xmlns="http://www.w3.org/2000/svg" width="600" height="600" viewBox="0 0 600 600">
            <rect width="600" height="600" fill="#0f172a"/>
            <circle cx="300" cy="270" r="100" fill="#1e293b" stroke="#334155" stroke-width="4"/>
            <text x="300" y="295" font-family="Arial, sans-serif" font-size="80" text-anchor="middle" fill="#94a3b8">🥾</text>
            <text x="300" y="420" font-family="Arial, sans-serif" font-size="22" font-weight="bold" text-anchor="middle" fill="#f8fafc">AP BOOTS &amp; PETROVA</text>
            <text x="300" y="450" font-family="Arial, sans-serif" font-size="14" text-anchor="middle" fill="#64748b">Visual Reference Master</text>
        </svg>"""
        b = svg.encode('utf-8')
        self.send_response(200)
        self.send_header('Content-Type', 'image/svg+xml')
        self.send_header('Content-Length', str(len(b)))
        self.end_headers()
        self.wfile.write(b)

    def send_json(self, data, status=200):
        b = json.dumps(data, ensure_ascii=False).encode('utf-8')
        self.send_response(status)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.send_header('Content-Length', str(len(b)))
        self.end_headers()
        self.wfile.write(b)


def run_server():
    socketserver.TCPServer.allow_reuse_address = True
    active_port = PORT
    httpd = None

    for p in [PORT, 8898, 8900, 8901, 8902]:
        try:
            server_address = ('', p)
            httpd = socketserver.TCPServer(server_address, MasterFinalHandler)
            active_port = p
            break
        except OSError:
            continue

    if not httpd:
        print(f"[ERROR] Port {PORT} and alternatives are in use!")
        return

    print("====================================================================")
    print(" AP BOOTS® & PETROVA — UNIFIED MASTER PRODUCT CATALOG (FINAL) IS LIVE!")
    print(f" Web UI URL: http://localhost:{active_port}")
    print(f" Master Excel: http://localhost:{active_port}/master_products_catalog.xlsx")
    print(f" Master JSON:  http://localhost:{active_port}/master_products_catalog.json")
    print(f" Master CSV:   http://localhost:{active_port}/master_products_catalog.csv")
    print(" Press Ctrl+C in this terminal window to stop the server.")
    print("====================================================================")

    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n[Server Stopped]")
        httpd.server_close()

if __name__ == '__main__':
    run_server()

