import os
import json
import re

tokopedia_dir = 'Images_Tokopedia'
with open('FINAL/master_products_catalog.json', 'r', encoding='utf-8') as f:
    master = json.load(f)

products = master.get('products', [])

# Map Tokopedia folders
tokopedia_folders = []
for root, dirs, files in os.walk(tokopedia_dir):
    imgs = [f for f in sorted(files) if f.lower().endswith(('.jpg', '.jpeg', '.png', '.webp'))]
    if imgs:
        rel_folder = os.path.relpath(root, tokopedia_dir)
        tokopedia_folders.append({
            "rel_folder": rel_folder,
            "images": imgs
        })

print(f"Total Tokopedia folders: {len(tokopedia_folders)}")

def norm(s):
    s = s.lower()
    s = re.sub(r'[^a-z0-9]', ' ', s)
    return set(s.split())

mapping_results = {}
for p in products:
    sku = p['master_sku']
    m_name = p['model_name']
    o_sku = p['original_sku']
    p_tokens = norm(m_name + " " + o_sku + " " + p.get('english_title', ''))
    
    candidates = []
    for tf in tokopedia_folders:
        folder_tokens = norm(tf['rel_folder'])
        overlap = p_tokens.intersection(folder_tokens)
        score = len(overlap)
        
        clean_o = re.sub(r'[^a-z0-9]', '', o_sku.lower())
        clean_f = re.sub(r'[^a-z0-9]', '', tf['rel_folder'].lower())
        if clean_o and len(clean_o) > 2 and clean_o in clean_f:
            score += 15
            
        for tok in p_tokens:
            if tok in folder_tokens and (re.search(r'\d+', tok) or tok in ['moto', 'allbike', 'max', 'orca', 'chef', 'medic', 'roots', 'terra', 'fuxia']):
                score += 3
                
        if score >= 3:
            candidates.append((score, tf))
            
    candidates.sort(key=lambda x: x[0], reverse=True)
    mapping_results[sku] = {
        "model_name": m_name,
        "matched_folders": [c[1]['rel_folder'] for c in candidates[:2]],
        "matched_images_count": sum(len(c[1]['images']) for c in candidates[:2])
    }

print("\n--- SAMPLE MAPPINGS (First 10) ---")
for sku, info in list(mapping_results.items())[:10]:
    print(f"[{sku}] {info['model_name']} -> {info['matched_folders']} ({info['matched_images_count']} images)")

print("\n--- SAMPLE MAPPINGS (Petrova) ---")
for sku, info in list(mapping_results.items())[106:116]:
    print(f"[{sku}] {info['model_name']} -> {info['matched_folders']} ({info['matched_images_count']} images)")
