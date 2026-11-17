const connBadge = document.getElementById("connBadge");
const catSelect = document.getElementById("catSelect");
const skuSearch = document.getElementById("skuSearch");
const skuSelect = document.getElementById("skuSelect");
const matchCount = document.getElementById("matchCount");
const chkAutoRun = document.getElementById("chkAutoRun");
const valGroup = document.getElementById("valGroup");
const valPrice = document.getElementById("valPrice");
const popupLog = document.getElementById("popupLog");

let queueItems = [];

function setLog(msg) {
  popupLog.textContent = msg;
}

function renderSkuDetails(sku) {
  const item = queueItems.find((x) => x.master_sku === sku);
  if (!item) return;
  valGroup.textContent = item.photobank_group || "-";
  valPrice.textContent = `${item.moq} prs | $${item.price_min}–$${item.price_max}`;
}

function renderFilteredOptions(filterText, preferSku) {
  const q = (filterText || "").trim().toLowerCase();
  const filtered = q
    ? queueItems.filter((it) => {
        const hay = `${it.master_sku} ${it.original_sku} ${it.model_name} ${it.category_name} ${it.photobank_group}`.toLowerCase();
        return hay.includes(q);
      })
    : queueItems;

  matchCount.textContent = String(filtered.length);
  if (filtered.length === 0) {
    skuSelect.innerHTML = `<option value="">-- Tidak ada produk cocok --</option>`;
    return;
  }

  skuSelect.innerHTML = filtered
    .map(
      (it) =>
        `<option value="${it.master_sku}">${it.master_sku} (${it.original_sku}) — ${it.model_name}</option>`
    )
    .join("");

  if (preferSku && filtered.some((x) => x.master_sku === preferSku)) {
    skuSelect.value = preferSku;
  }
  renderSkuDetails(skuSelect.value);
}

function loadCategories(savedCat = "") {
  chrome.runtime.sendMessage({ type: "BRIDGE_CATEGORIES" }, (cRes) => {
    if (!cRes || !cRes.ok || !cRes.data || !cRes.data.categories) return;
    catSelect.innerHTML =
      `<option value="">📁 Semua Kategori Folder (125 SKU)</option>` +
      cRes.data.categories
        .map((c) => `<option value="${c.folder}">📁 ${c.folder} — ${c.label} (${c.count})</option>`)
        .join("");
    if (savedCat) catSelect.value = savedCat;
  });
}

function loadQueue(categoryFolder = "", preferSku = "") {
  chrome.runtime.sendMessage({ type: "BRIDGE_QUEUE", category: categoryFolder }, (qRes) => {
    if (!qRes || !qRes.ok || !qRes.data || !qRes.data.items) {
      skuSelect.innerHTML = `<option value="MST-001">Server localhost:8888 belum menyala</option>`;
      return;
    }
    queueItems = qRes.data.items;
    renderFilteredOptions(skuSearch.value, preferSku);
  });
}

function triggerTabAction(action, sku) {
  setLog(`⏳ Menjalankan ${action} untuk ${sku}...`);
  chrome.runtime.sendMessage({ type: "RUN_ON_ACTIVE_TAB", action, sku }, (res) => {
    if (!res || !res.ok) {
      setLog(`ℹ️ Buka tab Alibaba/Flow untuk eksekusi langsung (${res ? res.error : "no tab"}).`);
    } else if (res.data && res.data.message) {
      setLog(`✓ ${res.data.message}`);
    } else {
      setLog(`✓ Selesai menjalankan ${action}.`);
    }
  });
}

function initPopup() {
  chrome.runtime.sendMessage({ type: "BRIDGE_HEALTH" }, (res) => {
    if (res && res.ok && res.data && res.data.success) {
      connBadge.textContent = `ONLINE (${res.data.total_master_skus} SKU)`;
      connBadge.className = "badge ok";
    } else {
      connBadge.textContent = "OFFLINE (:8888)";
      connBadge.className = "badge err";
    }
  });

  chrome.runtime.sendMessage({ type: "BRIDGE_GET_SETTINGS" }, (settings) => {
    const savedSku = (settings && settings.activeSku) || "MST-001";
    const savedCat = (settings && settings.activeCategory) || "";
    chkAutoRun.checked = settings ? settings.autoRunOnSelect === true : false;
    loadCategories(savedCat);
    loadQueue(savedCat, savedSku);
  });
}

catSelect.addEventListener("change", () => {
  const cat = catSelect.value;
  chrome.runtime.sendMessage({ type: "BRIDGE_SET_SETTINGS", activeCategory: cat });
  loadQueue(cat, skuSelect.value);
});

skuSearch.addEventListener("input", () => {
  renderFilteredOptions(skuSearch.value, skuSelect.value);
});

skuSelect.addEventListener("change", () => {
  const sku = skuSelect.value;
  if (!sku) return;
  renderSkuDetails(sku);
  chrome.runtime.sendMessage({ type: "BRIDGE_SET_ACTIVE_SKU", sku });
  if (chkAutoRun.checked) {
    triggerTabAction("TRIGGER_AUTO_RUN", sku);
  } else {
    setLog(`SKU aktif: ${sku}`);
  }
});

chkAutoRun.addEventListener("change", () => {
  chrome.runtime.sendMessage({
    type: "BRIDGE_SET_SETTINGS",
    autoRunOnSelect: chkAutoRun.checked
  });
});

document.getElementById("btnOpenGroup").addEventListener("click", () => {
  setLog("🚀 Mengelompokkan & membuka tab kerja dalam grup 'HOTS Flow'...");
  chrome.runtime.sendMessage(
    { type: "OPEN_HOTS_GROUP", targets: ["flow", "photobank", "publish"], focusKey: "flow" },
    (res) => {
      if (res && res.ok) {
        setLog(`✓ Grup 'HOTS Flow' siap (${res.data.tabIds.length} tab dalam 1 grup).`);
      } else {
        setLog(`❌ Gagal membuka grup: ${res ? res.error : "unknown"}`);
      }
    }
  );
});

document.getElementById("btnCloseGroup").addEventListener("click", () => {
  chrome.runtime.sendMessage({ type: "CLOSE_HOTS_GROUP" }, (res) => {
    if (res && res.ok) {
      setLog(`✓ Ditutup ${res.data.closedCount} tab dari grup 'HOTS Flow'.`);
    } else {
      setLog("❌ Gagal menutup grup tab.");
    }
  });
});

document.getElementById("btnRunFlowDirect").addEventListener("click", () => {
  const sku = skuSelect.value || "MST-001";
  setLog(`🎨 Membuka Flow di grup & menjalankan Agent 2K untuk ${sku}...`);
  chrome.runtime.sendMessage({ type: "RUN_FLOW_FROM_EXTENSION", sku }, (res) => {
    if (res && res.ok && res.data) {
      setLog(res.data.message || `✓ Flow berjalan untuk ${sku}`);
    } else {
      setLog(`ℹ️ Tab Flow dibuka. Klik '⚡ Auto-Run Halaman' di panel kanan bawah jika halaman baru selesai muat.`);
    }
  });
});

document.getElementById("btnRunActiveTab").addEventListener("click", () => {
  triggerTabAction("TRIGGER_AUTO_RUN", skuSelect.value || "MST-001");
});

document.getElementById("btnSyncList").addEventListener("click", () => {
  triggerTabAction("TRIGGER_SYNC_LIST", skuSelect.value || "MST-001");
});

document.getElementById("btnScanButtons").addEventListener("click", () => {
  triggerTabAction("TRIGGER_SCAN_BUTTONS", skuSelect.value || "MST-001");
});

document.querySelectorAll("button[data-target]").forEach((btn) => {
  btn.addEventListener("click", () => {
    const target = btn.getAttribute("data-target");
    chrome.runtime.sendMessage({ type: "OPEN_WORKSPACE_TAB", target });
  });
});

initPopup();
