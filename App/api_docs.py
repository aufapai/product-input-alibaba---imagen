# -*- coding: utf-8 -*-
"""
Interactive Website API Documentation & OpenAPI Specification Generator
For AP BOOTS® Global B2B Catalog Manager (HOTS Trading)
"""
import json

def get_openapi_spec() -> dict:
    """Returns OpenAPI 3.0 compliant JSON schema for the website API."""
    return {
        "openapi": "3.0.3",
        "info": {
            "title": "AP BOOTS® Global B2B Catalog Manager API",
            "version": "2.0.0",
            "description": "Comprehensive REST API for Catalog Management, 4-Slot Photobank Image Generation (Photoroom / Colab Inpainting / Smart Canvas), Accio AI SEO Listing, and B2B Export Logistics.",
            "contact": {
                "name": "PT Indo Sukses Semesta (HOTS Trading) & PT Waru Gunung Industri",
                "url": "https://admin.hotstrading.com"
            }
        },
        "servers": [
            {
                "url": "http://localhost:8888",
                "description": "Local Development Server"
            },
            {
                "url": "https://admin.hotstrading.com",
                "description": "Production Admin Server"
            }
        ],
        "paths": {
            "/api/stats": {
                "get": {
                    "summary": "Dashboard Overview Statistics",
                    "description": "Returns counts for total products, flagship products, live listings, and marketplace breakdowns.",
                    "responses": {
                        "200": {"description": "OK"}
                    }
                }
            },
            "/api/products": {
                "get": {
                    "summary": "List & Filter Catalog Products",
                    "parameters": [
                        {"name": "search", "in": "query", "schema": {"type": "string"}},
                        {"name": "source", "in": "query", "schema": {"type": "string", "default": "all"}},
                        {"name": "is_flagship", "in": "query", "schema": {"type": "string", "enum": ["0", "1"]}}
                    ],
                    "responses": {"200": {"description": "List of products"}}
                }
            },
            "/api/photobank/custom-generate": {
                "post": {
                    "summary": "Generate 4-Slot Photobank Image Variations",
                    "description": "Generates standardized 1:1 e-commerce images (Hero, Side, Tread, Usage) via Photoroom API, Colab Diffusers Inpainting, or Studio Smart Canvas.",
                    "requestBody": {
                        "required": True,
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object",
                                    "properties": {
                                        "sku": {"type": "string", "example": "SHP-001"},
                                        "folder": {"type": "string", "example": "AP_Boots_XTR_Hitam_Sepatu_Boot_PVC"},
                                        "slots": {"type": "array", "items": {"type": "integer"}, "example": [1, 2, 3, 4]},
                                        "target_size": {"type": "integer", "default": 1000},
                                        "fill_ratio": {"type": "number", "default": 0.85},
                                        "engine": {"type": "string", "enum": ["photoroom", "colab_diffusers", "smart_canvas", "google_ai_studio"], "default": "photoroom"},
                                        "api_key": {"type": "string", "example": "sk_pr_default_5cf2ec3a5a6ce7e52ab8dcfa7b50d2dbca4dd651"},
                                        "ngrok_url": {"type": "string", "example": "https://xxxx.ngrok-free.app/generate-background/"}
                                    }
                                }
                            }
                        }
                    },
                    "responses": {"200": {"description": "Generation result"}}
                }
            },
            "/api/photobank/upload": {
                "post": {
                    "summary": "Receive Image Upload into Photobank Storage",
                    "description": "Receiver endpoint for direct image ingestion (Base64 or Multipart) into Photobank categories.",
                    "responses": {"200": {"description": "Uploaded successfully"}}
                }
            },
            "/api/photobank/status": {
                "get": {
                    "summary": "Photobank Category Storage Status",
                    "responses": {"200": {"description": "Summary of ready images across 8 categories"}}
                }
            },
            "/api/exchange_rate": {
                "get": {
                    "summary": "Live Google Forex USD/IDR Rate",
                    "responses": {"200": {"description": "Live exchange rate and timestamp"}}
                }
            },
            "/api/calculate_carton": {
                "get": {
                    "summary": "Calculate Packaging, CBM & Container Loading",
                    "parameters": [
                        {"name": "usd", "in": "query", "schema": {"type": "number", "example": 5.50}},
                        {"name": "pairs", "in": "query", "schema": {"type": "integer", "example": 12}},
                        {"name": "category", "in": "query", "schema": {"type": "string", "example": "Safety Boots"}}
                    ],
                    "responses": {"200": {"description": "Packaging logistics calculation"}}
                }
            },
            "/api/export": {
                "post": {
                    "summary": "Export Products to Excel or CSV",
                    "requestBody": {
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object",
                                    "properties": {
                                        "target": {"type": "string", "enum": ["master", "selected", "flagship_40"]},
                                        "format": {"type": "string", "enum": ["xlsx", "csv"]},
                                        "product_ids": {"type": "array", "items": {"type": "integer"}},
                                        "shopee_folders": {"type": "array", "items": {"type": "string"}}
                                    }
                                }
                            }
                        }
                    },
                    "responses": {"200": {"description": "Export result with download link"}}
                }
            }
        }
    }

def get_api_docs_html() -> str:
    """Returns an interactive, modern, Swagger-style API Documentation Web Portal."""
    return """<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>⚡ AP BOOTS® Website REST API Portal & Explorer</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #0b132b;
            --surface: #1c2541;
            --surface-hover: #24325a;
            --card-bg: #111a36;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --border: #334155;
            --primary: #10b981;
            --primary-dark: #059669;
            --blue: #3b82f6;
            --indigo: #6366f1;
            --amber: #f59e0b;
            --purple: #8b5cf6;
            --danger: #ef4444;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--bg);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Top Header */
        header {
            background: linear-gradient(135deg, #064e3b, #0f172a);
            border-bottom: 1px solid rgba(16, 185, 129, 0.25);
            padding: 1.25rem 2rem;
            position: sticky;
            top: 0;
            z-index: 100;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.4);
        }

        .header-title {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .header-title h1 {
            font-size: 1.3rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: #ffffff;
        }

        .badge-ver {
            background: rgba(16, 185, 129, 0.2);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.4);
            font-size: 0.72rem;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 6px;
        }

        .header-links {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .btn-hdr {
            background: var(--surface);
            color: var(--text-main);
            border: 1px solid var(--border);
            padding: 8px 14px;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-hdr:hover {
            background: var(--surface-hover);
            border-color: var(--primary);
        }

        .btn-primary {
            background: var(--primary);
            color: #ffffff;
            border: none;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
        }

        /* Main Container */
        .container {
            max-width: 1300px;
            width: 100%;
            margin: 0 auto;
            padding: 2rem;
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 2rem;
            flex: 1;
        }

        @media (max-width: 900px) {
            .container { grid-template-columns: 1fr; }
            .sidebar { display: none; }
        }

        /* Sidebar Navigation */
        .sidebar {
            position: sticky;
            top: 5.5rem;
            height: calc(100vh - 7rem);
            overflow-y: auto;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 1.25rem;
        }

        .sidebar-section-title {
            font-size: 0.72rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-muted);
            margin: 1.2rem 0 0.5rem 0;
        }

        .sidebar-section-title:first-child { margin-top: 0; }

        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 10px;
            border-radius: 6px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.8rem;
            font-weight: 600;
            transition: all 0.15s ease;
            margin-bottom: 2px;
        }

        .sidebar-link:hover, .sidebar-link.active {
            color: #ffffff;
            background: rgba(16, 185, 129, 0.15);
            color: var(--primary);
        }

        /* Method Badges */
        .method-badge {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.65rem;
            font-weight: 800;
            padding: 2px 6px;
            border-radius: 4px;
            text-transform: uppercase;
        }

        .method-get { background: rgba(59, 130, 246, 0.2); color: #60a5fa; border: 1px solid rgba(59, 130, 246, 0.3); }
        .method-post { background: rgba(16, 185, 129, 0.2); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3); }

        /* API Content Cards */
        .content {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .hero-banner {
            background: linear-gradient(135deg, #1e293b, #0f172a);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.25);
        }

        .hero-banner h2 {
            font-size: 1.3rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 6px;
        }

        .hero-banner p {
            font-size: 0.85rem;
            color: var(--text-muted);
            line-height: 1.5;
        }

        .base-url-box {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 12px;
            background: #020617;
            padding: 8px 14px;
            border-radius: 8px;
            border: 1px solid #1e293b;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.82rem;
            color: #38bdf8;
        }

        /* Endpoint Card */
        .endpoint-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 12px;
            overflow: hidden;
            transition: border-color 0.2s ease;
        }

        .endpoint-card:hover {
            border-color: #475569;
        }

        .endpoint-header {
            padding: 1rem 1.25rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(15, 23, 42, 0.5);
            border-bottom: 1px solid var(--border);
            cursor: pointer;
            user-select: none;
        }

        .endpoint-route {
            display: flex;
            align-items: center;
            gap: 12px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.88rem;
            font-weight: 700;
        }

        .endpoint-desc {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .endpoint-body {
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .endpoint-notes {
            font-size: 0.82rem;
            color: #cbd5e1;
            line-height: 1.5;
        }

        /* Params and Code Blocks */
        .section-label {
            font-size: 0.72rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            margin-bottom: 4px;
        }

        .code-box {
            background: #020617;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 10px 14px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.78rem;
            color: #a7f3d0;
            overflow-x: auto;
            position: relative;
        }

        .test-panel {
            background: #0f172a;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 12px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .test-btn {
            background: linear-gradient(135deg, #10b981, #059669);
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 700;
            font-size: 0.8rem;
            cursor: pointer;
            align-self: flex-start;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: opacity 0.2s ease;
        }

        .test-btn:hover { opacity: 0.9; }
        .test-btn:disabled { opacity: 0.5; cursor: not-allowed; }

        .response-box {
            background: #020617;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.75rem;
            color: #38bdf8;
            max-height: 250px;
            overflow-y: auto;
            white-space: pre-wrap;
            display: none;
        }

        /* Search Bar */
        .search-box {
            margin-bottom: 1rem;
        }

        .search-input {
            width: 100%;
            background: var(--surface);
            border: 1px solid var(--border);
            padding: 10px 16px;
            border-radius: 8px;
            color: #fff;
            font-size: 0.88rem;
            outline: none;
        }

        .search-input:focus {
            border-color: var(--primary);
        }
    </style>
</head>
<body>
    <header>
        <div class="header-title">
            <span style="font-size: 1.8rem;">⚡</span>
            <div>
                <div style="display: flex; align-items: center; gap: 8px;">
                    <h1>AP BOOTS® Global B2B Catalog API</h1>
                    <span class="badge-ver">v2.0 REST</span>
                </div>
                <div style="font-size: 0.75rem; color: #34d399;">
                    HOTS Trading • Photobank Studio • Accio B2B • Flow Integration
                </div>
            </div>
        </div>
        <div class="header-links">
            <a href="/" class="btn-hdr">
                🖥️ Buka Catalog Web App
            </a>
            <a href="/api/openapi.json" target="_blank" class="btn-hdr">
                📜 OpenAPI Spec (.json)
            </a>
            <button onclick="testPingAll()" class="btn-hdr btn-primary">
                🧪 Test Live Ping
            </button>
        </div>
    </header>

    <div class="container">
        <!-- Sidebar Navigation -->
        <nav class="sidebar">
            <div class="sidebar-section-title">Overview</div>
            <a href="#section-intro" class="sidebar-link active">📌 Ringkasan Server</a>
            <a href="#section-auth" class="sidebar-link">🔐 Auth & CORS</a>

            <div class="sidebar-section-title">Photobank & Image Gen</div>
            <a href="#ep-custom-gen" class="sidebar-link"><span class="method-badge method-post">POST</span> /custom-generate</a>
            <a href="#ep-batch-gen" class="sidebar-link"><span class="method-badge method-post">POST</span> /batch-generate</a>
            <a href="#ep-photobank-upload" class="sidebar-link"><span class="method-badge method-post">POST</span> /upload (Receiver)</a>
            <a href="#ep-photobank-upload-admin" class="sidebar-link"><span class="method-badge method-post">POST</span> /upload-admin</a>
            <a href="#ep-photobank-status" class="sidebar-link"><span class="method-badge method-get">GET</span> /photobank/status</a>

            <div class="sidebar-section-title">Katalog & Shopee Assets</div>
            <a href="#ep-products" class="sidebar-link"><span class="method-badge method-get">GET</span> /api/products</a>
            <a href="#ep-shopee-prods" class="sidebar-link"><span class="method-badge method-get">GET</span> /shopee/products</a>
            <a href="#ep-shopee-upload" class="sidebar-link"><span class="method-badge method-post">POST</span> /shopee/upload-image</a>

            <div class="sidebar-section-title">Forex & Logistik B2B</div>
            <a href="#ep-forex" class="sidebar-link"><span class="method-badge method-get">GET</span> /exchange_rate</a>
            <a href="#ep-carton" class="sidebar-link"><span class="method-badge method-get">GET</span> /calculate_carton</a>

            <div class="sidebar-section-title">Google Flow & Export</div>
            <a href="#ep-flow-bundle" class="sidebar-link"><span class="method-badge method-get">GET</span> /flow/bundle-10</a>
            <a href="#ep-export" class="sidebar-link"><span class="method-badge method-post">POST</span> /api/export</a>
        </nav>

        <!-- Main API Content -->
        <main class="content">
            <!-- Hero / Server Info Banner -->
            <div class="hero-banner" id="section-intro">
                <h2>🚀 REST API Website & Photobank Service</h2>
                <p>
                    API ini berjalan langsung di dalam core engine server Python (Port 8888). Digunakan oleh Web Manager, Google Flow Tool (iFrame), serta script otomasi eksternal untuk membuat listing dan menghasilkan variasi foto 4-slot standar B2B.
                </p>
                <div class="base-url-box">
                    <span>⚡ Base URL:</span>
                    <strong id="displayBaseUrl">http://localhost:8888</strong>
                    <button onclick="navigator.clipboard.writeText(window.location.origin); alert('Copied base URL!');" style="margin-left: auto; background: none; border: none; color: #38bdf8; cursor: pointer; font-size: 0.75rem;">📋 Salin</button>
                </div>
            </div>

            <!-- Search Filter -->
            <div class="search-box">
                <input type="text" class="search-input" id="apiSearchInput" placeholder="🔍 Cari endpoint API (misal: photobank, shopee, export, carton)..." oninput="filterEndpoints(this.value)">
            </div>

            <!-- ============================================== -->
            <!-- SECTION 1: PHOTOBANK & IMAGE GENERATION        -->
            <!-- ============================================== -->
            <div style="font-size: 1.1rem; font-weight: 800; color: #34d399; margin-top: 1rem;">
                📸 1. Photobank & Image Generation Engine
            </div>

            <!-- Endpoint: /api/photobank/custom-generate -->
            <div class="endpoint-card" id="ep-custom-gen" data-keywords="photobank custom generate photoroom colab smart canvas slots">
                <div class="endpoint-header" onclick="toggleCard(this)">
                    <div class="endpoint-route">
                        <span class="method-badge method-post">POST</span>
                        <span>/api/photobank/custom-generate</span>
                    </div>
                    <div class="endpoint-desc">Generate Variasi Foto 4 Slot (Photoroom / Colab / Canvas)</div>
                </div>
                <div class="endpoint-body">
                    <p class="endpoint-notes">
                        Mengeksekusi generasi variasi gambar standar Alibaba B2B untuk SKU tertentu. Mendukung pemilihan slot spesifik (1, 2, 3, 4), kanvas resolusi 1:1, dan scaling 85% frame agar sepatu tidak kekecilan.
                    </p>
                    <div class="section-label">Contoh Payload JSON:</div>
                    <pre class="code-box">{
  "sku": "SHP-001",
  "folder": "AP_Boots_XTR_Hitam_Sepatu_Boot_PVC",
  "slots": [1, 2],
  "target_size": 1000,
  "fill_ratio": 0.85,
  "engine": "photoroom",
  "api_key": "sk_pr_default_5cf2ec3a5a6ce7e52ab8dcfa7b50d2dbca4dd651"
}</pre>
                    <div class="test-panel">
                        <button class="test-btn" onclick="executeApiTest('/api/photobank/custom-generate', 'POST', {sku:'SHP-001', folder:'AP_Boots_XTR_Hitam_Sepatu_Boot_PVC', slots:[1], target_size:1000, fill_ratio:0.85, engine:'photoroom', api_key:'sk_pr_default_5cf2ec3a5a6ce7e52ab8dcfa7b50d2dbca4dd651'}, 'res-custom-gen', this)">
                            ⚡ Jalankan Test (Slot 1 Photoroom)
                        </button>
                        <div class="response-box" id="res-custom-gen"></div>
                    </div>
                </div>
            </div>

            <!-- Endpoint: /api/photobank/upload (Receiver) -->
            <div class="endpoint-card" id="ep-photobank-upload" data-keywords="photobank upload receiver post image ingest">
                <div class="endpoint-header" onclick="toggleCard(this)">
                    <div class="endpoint-route">
                        <span class="method-badge method-post">POST</span>
                        <span>/api/photobank/upload</span>
                    </div>
                    <div class="endpoint-desc">Receiver Endpoint Ingest Foto ke Photobank Folder</div>
                </div>
                <div class="endpoint-body">
                    <p class="endpoint-notes">
                        Endpoint receiver untuk menerima foto hasil generate langsung dari tools luar / Google Flow / script Python. Menyimpan file ke sub-kategori <code>Output/Photobank_Siap_Upload/&lt;category&gt;/</code> dan memperbarui manifest CSV.
                    </p>
                    <div class="section-label">Format Payload JSON (Base64) atau Multipart/form-data:</div>
                    <pre class="code-box">{
  "sku": "SHP-001",
  "folder": "AP_Boots_XTR_Hitam_Sepatu_Boot_PVC",
  "slot": "slot_1_hero",
  "category": "07_Classic_Boots",
  "image_base64": "data:image/webp;base64,UklGR..."
}</pre>
                    <div class="test-panel">
                        <button class="test-btn" onclick="executeApiTest('/api/photobank/upload', 'POST', {sku:'SHP-001', folder:'AP_Boots_XTR_Hitam_Sepatu_Boot_PVC', slot:'slot_1_hero', category:'07_Classic_Boots', image_base64:'data:image/webp;base64,UklGRkAAAABXRUJQVlA4IDQAAADwAQCdASoBAAEAAkA4JaQAA3AA/vv19AA='}, 'res-upload', this)">
                            🧪 Test Ingest Dummy Foto (1x1 WebP)
                        </button>
                        <div class="response-box" id="res-upload"></div>
                    </div>
                </div>
            </div>

            <!-- Endpoint: /api/photobank/status -->
            <div class="endpoint-card" id="ep-photobank-status" data-keywords="photobank status manifest count categories">
                <div class="endpoint-header" onclick="toggleCard(this)">
                    <div class="endpoint-route">
                        <span class="method-badge method-get">GET</span>
                        <span>/api/photobank/status</span>
                    </div>
                    <div class="endpoint-desc">Status Kesiapan Foto 8 Kategori Photobank</div>
                </div>
                <div class="endpoint-body">
                    <p class="endpoint-notes">
                        Mengembalikan rekap total foto yang sudah selesai diproses, siap diunggah ke Photobank Alibaba, beserta perincian per kategori dan jumlah baris manifest CSV.
                    </p>
                    <div class="test-panel">
                        <button class="test-btn" onclick="executeApiTest('/api/photobank/status', 'GET', null, 'res-pb-status', this)">
                            🔍 Cek Status Photobank Saat Ini
                        </button>
                        <div class="response-box" id="res-pb-status"></div>
                    </div>
                </div>
            </div>

            <!-- ============================================== -->
            <!-- SECTION 2: KATALOG & SHOPEE ASSET STUDIO       -->
            <!-- ============================================== -->
            <div style="font-size: 1.1rem; font-weight: 800; color: #60a5fa; margin-top: 1rem;">
                👟 2. Katalog Produk & Shopee Asset Studio
            </div>

            <!-- Endpoint: /api/shopee/products -->
            <div class="endpoint-card" id="ep-shopee-prods" data-keywords="shopee products 123 sku hero side json status">
                <div class="endpoint-header" onclick="toggleCard(this)">
                    <div class="endpoint-route">
                        <span class="method-badge method-get">GET</span>
                        <span>/api/shopee/products</span>
                    </div>
                    <div class="endpoint-desc">Daftar 123 SKU Resmi Shopee Official (Hero & JSON Status)</div>
                </div>
                <div class="endpoint-body">
                    <p class="endpoint-notes">
                        Mengembalikan 123 produk resmi (104 AP Boots + 19 Petrova) lengkap dengan nama folder terstandarisasi, harga IDR, ketersediaan file hero local WEBP, dan Alibaba B2B JSON.
                    </p>
                    <div class="test-panel">
                        <button class="test-btn" onclick="executeApiTest('/api/shopee/products', 'GET', null, 'res-shopee-prods', this)">
                            📥 Ambil Daftar Produk Shopee
                        </button>
                        <div class="response-box" id="res-shopee-prods"></div>
                    </div>
                </div>
            </div>

            <!-- Endpoint: /api/products -->
            <div class="endpoint-card" id="ep-products" data-keywords="products catalog master alibaba database">
                <div class="endpoint-header" onclick="toggleCard(this)">
                    <div class="endpoint-route">
                        <span class="method-badge method-get">GET</span>
                        <span>/api/products?is_flagship=1</span>
                    </div>
                    <div class="endpoint-desc">Query Master Database Produk (Filter Flagship / Marketplace)</div>
                </div>
                <div class="endpoint-body">
                    <p class="endpoint-notes">
                        Query database SQLite untuk seluruh listing produk dengan parameter <code>search</code>, <code>source</code>, atau <code>is_flagship=1</code> (Flagship 40).
                    </p>
                    <div class="test-panel">
                        <button class="test-btn" onclick="executeApiTest('/api/products?is_flagship=1', 'GET', null, 'res-prods', this)">
                            ⭐ Ambil Flagship 40 Products
                        </button>
                        <div class="response-box" id="res-prods"></div>
                    </div>
                </div>
            </div>

            <!-- ============================================== -->
            <!-- SECTION 3: FOREX & LOGISTIK B2B                -->
            <!-- ============================================== -->
            <div style="font-size: 1.1rem; font-weight: 800; color: #f59e0b; margin-top: 1rem;">
                💰 3. Live Forex & Logistik Kontainer B2B
            </div>

            <!-- Endpoint: /api/exchange_rate -->
            <div class="endpoint-card" id="ep-forex" data-keywords="exchange rate forex usd idr kurs live">
                <div class="endpoint-header" onclick="toggleCard(this)">
                    <div class="endpoint-route">
                        <span class="method-badge method-get">GET</span>
                        <span>/api/exchange_rate</span>
                    </div>
                    <div class="endpoint-desc">Kurs Real-Time USD / IDR (Google Forex Engine)</div>
                </div>
                <div class="endpoint-body">
                    <p class="endpoint-notes">
                        Mengambil nilai tukar rupiah terhadap dolar terkini secara live untuk perhitungan harga ekspor B2B FOB.
                    </p>
                    <div class="test-panel">
                        <button class="test-btn" onclick="executeApiTest('/api/exchange_rate', 'GET', null, 'res-forex', this)">
                            💵 Ambil Kurs USD/IDR Terkini
                        </button>
                        <div class="response-box" id="res-forex"></div>
                    </div>
                </div>
            </div>

            <!-- Endpoint: /api/calculate_carton -->
            <div class="endpoint-card" id="ep-carton" data-keywords="calculate carton cbm container 20ft 40ft pallet packing">
                <div class="endpoint-header" onclick="toggleCard(this)">
                    <div class="endpoint-route">
                        <span class="method-badge method-get">GET</span>
                        <span>/api/calculate_carton?usd=5.50&pairs=12&category=Safety%20Boots</span>
                    </div>
                    <div class="endpoint-desc">Kalkulator Logistik CBM, Gross Weight & Kapasitas Kontainer</div>
                </div>
                <div class="endpoint-body">
                    <p class="endpoint-notes">
                        Menghitung dimensi karton kemasan (Length × Width × Height), total CBM per karton, berat kotor, serta estimasi kapasitas muatan kontainer 20ft (33 CBM) dan 40ft HQ (76 CBM).
                    </p>
                    <div class="test-panel">
                        <button class="test-btn" onclick="executeApiTest('/api/calculate_carton?usd=5.50&pairs=12&category=Safety%20Boots', 'GET', null, 'res-carton', this)">
                            📦 Hitung Logistik Kemasan Karton
                        </button>
                        <div class="response-box" id="res-carton"></div>
                    </div>
                </div>
            </div>

            <!-- ============================================== -->
            <!-- SECTION 4: GOOGLE FLOW & EXPORT                -->
            <!-- ============================================== -->
            <div style="font-size: 1.1rem; font-weight: 800; color: #a855f7; margin-top: 1rem;">
                🌐 4. Google Flow & Export Center
            </div>

            <!-- Endpoint: /api/flow/bundle-10-products -->
            <div class="endpoint-card" id="ep-flow-bundle" data-keywords="flow bundle 10 products coupled zip always approve">
                <div class="endpoint-header" onclick="toggleCard(this)">
                    <div class="endpoint-route">
                        <span class="method-badge method-get">GET</span>
                        <span>/api/flow/bundle-10-products</span>
                    </div>
                    <div class="endpoint-desc">10-Product Coupled JSON Bundle untuk Google Flow Studio</div>
                </div>
                <div class="endpoint-body">
                    <p class="endpoint-notes">
                        Membuat paket batch 10 produk coupled JSON beserta Master Prompt agentic untuk otomasi pembuatan 40 foto WebP di Google Flow.
                    </p>
                    <div class="test-panel">
                        <button class="test-btn" onclick="executeApiTest('/api/flow/bundle-10-products', 'GET', null, 'res-flow-bundle', this)">
                            🌐 Generate Bundle 10 Produk Flow
                        </button>
                        <div class="response-box" id="res-flow-bundle"></div>
                    </div>
                </div>
            </div>

            <!-- Endpoint: /api/export -->
            <div class="endpoint-card" id="ep-export" data-keywords="export excel xlsx csv alibaba bulk upload">
                <div class="endpoint-header" onclick="toggleCard(this)">
                    <div class="endpoint-route">
                        <span class="method-badge method-post">POST</span>
                        <span>/api/export</span>
                    </div>
                    <div class="endpoint-desc">Export Bulk Listing ke File Excel (.xlsx) Resmi Alibaba</div>
                </div>
                <div class="endpoint-body">
                    <p class="endpoint-notes">
                        Menghasilkan file Excel 57 kolom standar template Alibaba Bulk Upload untuk SKU terpilih atau Flagship 40 produk.
                    </p>
                    <pre class="code-box">{
  "target": "flagship_40",
  "format": "xlsx"
}</pre>
                    <div class="test-panel">
                        <button class="test-btn" onclick="executeApiTest('/api/export', 'POST', {target:'flagship_40', format:'xlsx'}, 'res-export', this)">
                            📊 Test Export Flagship 40 Excel
                        </button>
                        <div class="response-box" id="res-export"></div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        document.getElementById('displayBaseUrl').innerText = window.location.origin;

        function toggleCard(headerEl) {
            const body = headerEl.nextElementSibling;
            if (body.style.display === 'none') {
                body.style.display = 'flex';
            } else {
                body.style.display = 'none';
            }
        }

        async function executeApiTest(endpoint, method, payload, resultBoxId, btn) {
            const box = document.getElementById(resultBoxId);
            box.style.display = 'block';
            box.innerText = `⏳ Requesting ${method} ${endpoint}...\\n`;
            btn.disabled = true;

            const t0 = performance.now();
            try {
                const opt = {
                    method: method,
                    headers: { 'Accept': 'application/json' }
                };
                if (method === 'POST' && payload) {
                    opt.headers['Content-Type'] = 'application/json';
                    opt.body = JSON.stringify(payload);
                }

                const res = await fetch(endpoint, opt);
                const t1 = performance.now();
                const ms = Math.round(t1 - t0);
                const statusColor = res.ok ? '🟢' : '🔴';

                let data;
                const cType = res.headers.get('content-type') || '';
                if (cType.includes('application/json')) {
                    data = await res.json();
                    box.innerText = `${statusColor} HTTP ${res.status} ${res.statusText} (${ms} ms)\\n\\n` + JSON.stringify(data, null, 2);
                } else {
                    const txt = await res.text();
                    box.innerText = `${statusColor} HTTP ${res.status} (${ms} ms)\\n\\n` + txt.substring(0, 1000);
                }
            } catch (err) {
                box.innerText = `❌ Network/Client Error: ${err}`;
            } finally {
                btn.disabled = false;
            }
        }

        async function testPingAll() {
            alert('Menguji koneksi server ke /api/stats...');
            try {
                const res = await fetch('/api/stats');
                const data = await res.json();
                alert(`✅ Server Online! Total Produk: ${data.total}, Flagship: ${data.flagship_count}`);
            } catch (e) {
                alert(`❌ Gagal koneksi ke server: ${e}`);
            }
        }

        function filterEndpoints(q) {
            q = (q || '').toLowerCase().trim();
            const cards = document.querySelectorAll('.endpoint-card');
            cards.forEach(c => {
                const text = c.innerText.toLowerCase() + ' ' + (c.getAttribute('data-keywords') || '');
                if (!q || text.includes(q)) {
                    c.style.display = 'block';
                } else {
                    c.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>
"""
