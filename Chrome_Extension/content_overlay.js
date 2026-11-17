// Floating Control Panel & Auto-Runner Engine (Alibaba + Photobank + Google Flow 2K/1K)
(function () {
  if (document.getElementById("hots-ext-panel")) return;

  const href = window.location.href;
  const host = window.location.hostname;

  let pageType = "generic";
  let pageMode = "Alibaba Workspace";
  if (host.includes("flow.google.com")) {
    pageType = "flow";
    pageMode = "Google Flow Agent (aufahots@gmail.com)";
  } else if (host.includes("photobank.alibaba.com")) {
    pageType = "photobank";
    pageMode = "Alibaba Photobank Uploader";
  } else if (href.includes("list-manage")) {
    pageType = "list";
    pageMode = "Alibaba Product List Manager";
  } else if (href.includes("publish-plan")) {
    pageType = "publish_plan";
    pageMode = "Alibaba Add Product (publish-plan)";
  } else if (host.includes("post.alibaba.com") || href.includes("/post")) {
    pageType = "post";
    pageMode = "Alibaba Post / Freeze Form";
  }

  const panel = document.createElement("div");
  panel.id = "hots-ext-panel";
  panel.innerHTML = `
    <div id="hots-ext-hdr">
      <span id="hots-ext-title">HOTS Bridge (:8888)</span>
      <div class="hots-hdr-right">
        <span id="hots-ext-status">Connecting...</span>
        <button id="hots-btn-minimize" class="hots-hdr-btn" title="Minimize / Expand panel">Minimize</button>
        <button id="hots-btn-close" class="hots-hdr-btn close" title="Tutup sementara panel">Close</button>
      </div>
    </div>
    <div id="hots-ext-body">
      <div class="hots-top-pills">
        <span class="hots-mode-pill">${pageMode}</span>
        <button id="hots-btn-pause" class="hots-btn pause" style="padding:3px 8px; font-size:10px;">⏸️ Pause</button>
      </div>

      <select id="hots-ext-cat">
        <option value="">📁 Semua Kategori Folder (11 Kategori)</option>
      </select>
      <input type="text" id="hots-ext-search" placeholder="🔍 Cari SKU, nama, atau kategori..." />
      <select id="hots-ext-sku">
        <option value="MST-001">Memuat Master SKU...</option>
      </select>

      <div class="hots-toggles-row">
        <label class="hots-chk-lbl" title="Otomatis tekan kirim & lanjutkan di Google Flow">
          <input type="checkbox" id="hots-chk-approve" checked />
          <span>✅ Always Approve</span>
        </label>
        <label class="hots-chk-lbl" title="Otomatis suntik data/foto saat ganti SKU">
          <input type="checkbox" id="hots-chk-autorun" />
          <span>⚡ Auto-Run Pilih</span>
        </label>
      </div>

      <div id="hots-ext-info" class="hots-info-box">
        Menghubungkan ke Local Bridge <code>localhost:8888</code>...
      </div>

      <div class="hots-thumb-hdr">
        <span>🖼️ Foto Lokal Produk (<span id="hots-thumb-count">0</span>)</span>
        <span id="hots-thumb-selected" style="color:#38bdf8;">0 dipilih</span>
      </div>
      <div id="hots-thumb-grid" class="hots-thumb-grid">
        <div style="grid-column:span 4; color:#64748b; text-align:center; padding:8px;">Memuat thumbnail lokal...</div>
      </div>

      <div class="hots-btn-row">
        <button id="hots-btn-inject" class="hots-btn inject">📤 Suntik Foto Terpilih</button>
        <button id="hots-btn-autorun" class="hots-btn">⚡ Auto-Run Halaman</button>
        ${pageType === "publish_plan" || pageType === "post" ? '<button id="hots-btn-fill-desc" class="hots-btn full" style="background:#0284c7;">📝 Isi Deskripsi Produk (B2B Specs)</button>' : ""}
        ${pageType === "flow" ? '<button id="hots-btn-flow-dl" class="hots-btn flowdl">⬇️ Auto-Download Hasil (Hero 2K + 1K)</button>' : ""}
        <button id="hots-btn-sync" class="hots-btn sync">🔄 Sinkronisasi</button>
        <button id="hots-btn-scan" class="hots-btn scan">🔍 Cari Tombol</button>
      </div>
      <div class="hots-btn-row">
        <button id="hots-btn-copy-title" class="hots-btn sec">Salin Judul + KW</button>
        <button id="hots-btn-copy-flow" class="hots-btn sec">Salin 4 Prompt Flow</button>
      </div>

      <div class="hots-progress-wrap">
        <div class="hots-progress-hdr">
          <span id="hots-progress-text">⏳ Siap memproses</span>
          <span id="hots-progress-pct">0%</span>
        </div>
        <div class="hots-progress-bar">
          <div id="hots-progress-fill" class="hots-progress-fill"></div>
        </div>
      </div>
      <div id="hots-ext-log">Siap. Pilih kategori atau SKU untuk memuat thumbnail lokal.</div>
    </div>
  `;
  document.body.appendChild(panel);

  const reopenBtn = document.createElement("button");
  reopenBtn.id = "hots-ext-reopen";
  reopenBtn.textContent = "🔓 Buka HOTS Bridge";
  document.body.appendChild(reopenBtn);

  const hdr = document.getElementById("hots-ext-hdr");
  const btnMinimize = document.getElementById("hots-btn-minimize");
  const btnClose = document.getElementById("hots-btn-close");
  const statusEl = document.getElementById("hots-ext-status");
  const catEl = document.getElementById("hots-ext-cat");
  const searchEl = document.getElementById("hots-ext-search");
  const skuSelect = document.getElementById("hots-ext-sku");
  const chkApprove = document.getElementById("hots-chk-approve");
  const chkAutoRun = document.getElementById("hots-chk-autorun");
  const btnPause = document.getElementById("hots-btn-pause");
  const infoBox = document.getElementById("hots-ext-info");
  const thumbGrid = document.getElementById("hots-thumb-grid");
  const thumbCountEl = document.getElementById("hots-thumb-count");
  const thumbSelectedEl = document.getElementById("hots-thumb-selected");
  const progressTextEl = document.getElementById("hots-progress-text");
  const progressPctEl = document.getElementById("hots-progress-pct");
  const progressFillEl = document.getElementById("hots-progress-fill");
  const logEl = document.getElementById("hots-ext-log");

  let queueItems = [];
  let currentProduct = null;
  let selectedImageUrls = new Set();
  let isPaused = false;
  let freezeTimer = null;
  const logLines = [];

  btnMinimize.addEventListener("click", (e) => {
    e.stopPropagation();
    const isCollapsed = panel.classList.toggle("collapsed");
    btnMinimize.textContent = isCollapsed ? "Expand" : "Minimize";
  });

  btnClose.addEventListener("click", (e) => {
    e.stopPropagation();
    panel.style.display = "none";
    reopenBtn.style.display = "block";
  });

  reopenBtn.addEventListener("click", () => {
    panel.style.display = "block";
    reopenBtn.style.display = "none";
  });

  function setProgress(pct, label) {
    const clamped = Math.max(0, Math.min(100, Number(pct) || 0));
    progressFillEl.style.width = `${clamped}%`;
    progressPctEl.textContent = `${clamped}%`;
    if (label) progressTextEl.textContent = label;
  }

  function setLog(txt) {
    const ts = new Date().toTimeString().slice(0, 8);
    logLines.push(`[${ts}] ${txt}`);
    if (logLines.length > 40) logLines.shift();
    logEl.textContent = logLines.join("\n");
    logEl.scrollTop = logEl.scrollHeight;
  }

  function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }

  function sendMsg(payload) {
    return new Promise((resolve) => {
      try {
        if (!chrome.runtime || !chrome.runtime.id) {
          resolve({ ok: false, error: "Extension baru di-update. Tekan F5 (refresh) halaman ini." });
          return;
        }
        chrome.runtime.sendMessage(payload, (res) => {
          if (chrome.runtime.lastError) {
            resolve({ ok: false, error: chrome.runtime.lastError.message });
          } else {
            resolve(res);
          }
        });
      } catch (e) {
        resolve({ ok: false, error: "Extension baru di-update. Tekan F5 (refresh) halaman ini." });
      }
    });
  }

  function updatePauseBtnUI() {
    if (isPaused) {
      btnPause.textContent = "▶️ Resume";
      btnPause.classList.add("paused");
    } else {
      btnPause.textContent = "⏸️ Pause";
      btnPause.classList.remove("paused");
    }
  }

  function base64ToFile(base64, mimeType, filename) {
    const byteChars = atob(base64);
    const byteNumbers = new Array(byteChars.length);
    for (let i = 0; i < byteChars.length; i++) {
      byteNumbers[i] = byteChars.charCodeAt(i);
    }
    const byteArray = new Uint8Array(byteNumbers);
    const blob = new Blob([byteArray], { type: mimeType || "image/webp" });
    return new File([blob], filename, { type: mimeType || "image/webp" });
  }

  async function buildDataTransferFromImages(imageObjs, maxFiles = 6) {
    const dt = new DataTransfer();
    const list = (imageObjs || []).slice(0, maxFiles);
    let lastError = "";
    for (const img of list) {
      const res = await sendMsg({
        type: "BRIDGE_FETCH_IMAGE_BASE64",
        url: img.url,
        path: img.path,
        filename: img.filename
      });
      if (res && res.ok && res.base64) {
        dt.items.add(base64ToFile(res.base64, res.mimeType, res.filename));
      } else if (res && res.error) {
        lastError = res.error;
      }
    }
    if (dt.files.length === 0 && lastError) {
      setLog(`❌ Gagal ambil gambar: ${lastError}`);
    }
    return dt;
  }

  function setReactInputValue(el, value) {
    if (!el) return;
    const proto = el.tagName === "TEXTAREA" ? HTMLTextAreaElement.prototype : HTMLInputElement.prototype;
    const desc = Object.getOwnPropertyDescriptor(proto, "value");
    if (desc && desc.set) {
      desc.set.call(el, value);
    } else {
      el.value = value;
    }
    el.dispatchEvent(new Event("input", { bubbles: true }));
    el.dispatchEvent(new Event("change", { bubbles: true }));
  }

  function findClickableByText(patterns, root = document) {
    const els = Array.from(root.querySelectorAll("button, a, span, div[role='button'], div[role='menuitem'], li"));
    for (const pat of patterns) {
      const rx = typeof pat === "string" ? new RegExp(pat, "i") : pat;
      const found = els.find(
        (el) => el.offsetParent !== null && !el.closest("#hots-ext-panel") && rx.test((el.innerText || "").trim())
      );
      if (found) return found;
    }
    return null;
  }

  function findFileInputsDeep(root = document) {
    const results = Array.from(root.querySelectorAll("input[type='file']"));
    const allEls = root.querySelectorAll("*");
    for (const el of allEls) {
      if (el.shadowRoot) {
        results.push(...findFileInputsDeep(el.shadowRoot));
      }
    }
    return results;
  }

  function getSelectedImagesFromProduct() {
    if (!currentProduct || !currentProduct.images) return [];
    const chosen = currentProduct.images.filter((im) => selectedImageUrls.has(im.url));
    return chosen.length > 0 ? chosen : currentProduct.images.slice(0, 6);
  }

  function updateThumbSelectedLabel() {
    thumbSelectedEl.textContent = `${selectedImageUrls.size} dipilih`;
  }

  function renderThumbnailGallery(images) {
    const localImgs = (images || []).filter((im) => im.is_local || im.url.includes("localhost:8888"));
    const displayImgs = localImgs.length > 0 ? localImgs : (images || []);
    thumbCountEl.textContent = String(displayImgs.length);
    selectedImageUrls.clear();

    if (displayImgs.length === 0) {
      thumbGrid.innerHTML = `<div style="grid-column:span 4; color:#64748b; text-align:center; padding:8px;">Belum ada foto lokal.</div>`;
      updateThumbSelectedLabel();
      return;
    }

    if (pageType === "flow") {
      const heroImg =
        displayImgs.find((im) => /hero/i.test(im.type || "") || /^hero_/i.test(im.filename || "")) ||
        displayImgs[0];
      if (heroImg) selectedImageUrls.add(heroImg.url);
    } else {
      displayImgs.slice(0, 6).forEach((im) => selectedImageUrls.add(im.url));
    }
    thumbGrid.innerHTML = displayImgs
      .map((im, idx) => {
        const isChecked = selectedImageUrls.has(im.url);
        const flagShort = (im.source || "LOKAL").replace("_LOCAL", "").slice(0, 10);
        return `
          <div class="hots-thumb-card ${isChecked ? "selected" : ""}" data-idx="${idx}" title="${im.filename}">
            <input type="checkbox" class="hots-thumb-chk" data-url="${im.url}" ${isChecked ? "checked" : ""} />
            <img class="hots-thumb-img" data-url="${im.url}" data-path="${im.path || ""}" data-filename="${im.filename || ""}" alt="${im.filename}" style="background:#f8fafc;" />
            <div class="hots-thumb-badge">${flagShort}</div>
          </div>
        `;
      })
      .join("");

    // Load thumbnails safely via background.js -> Blob URL (bypasses HTTPS Mixed Content & CSP)
    thumbGrid.querySelectorAll("img.hots-thumb-img").forEach(async (imgEl) => {
      const res = await sendMsg({
        type: "BRIDGE_FETCH_IMAGE_BASE64",
        url: imgEl.getAttribute("data-url"),
        path: imgEl.getAttribute("data-path"),
        filename: imgEl.getAttribute("data-filename")
      });
      if (res && res.ok && res.base64) {
        const fileObj = base64ToFile(res.base64, res.mimeType, res.filename);
        imgEl.src = URL.createObjectURL(fileObj);
      } else {
        imgEl.alt = "⚠️";
      }
    });

    thumbGrid.querySelectorAll(".hots-thumb-card").forEach((card) => {
      const chk = card.querySelector(".hots-thumb-chk");
      card.addEventListener("click", (e) => {
        if (e.target !== chk) chk.checked = !chk.checked;
        const url = chk.getAttribute("data-url");
        if (chk.checked) {
          selectedImageUrls.add(url);
          card.classList.add("selected");
        } else {
          selectedImageUrls.delete(url);
          card.classList.remove("selected");
        }
        updateThumbSelectedLabel();
      });
    });
    updateThumbSelectedLabel();
  }

  // =========================================================
  // 1. SCAN TOMBOL & INPUT HALAMAN AKTIF
  // =========================================================
  function scanPageButtons() {
    document.querySelectorAll(".hots-scan-highlight").forEach((el) => el.classList.remove("hots-scan-highlight"));

    const fileInputs = findFileInputsDeep();
    const textInputs = Array.from(document.querySelectorAll("input:not([type='file']):not([type='hidden']), textarea, [contenteditable='true']"))
      .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"));
    const actionPatterns = [/local drive/i, /image bank/i, /post with category/i, /upload/i, /generate/i, /download/i, /submit/i, /next/i, /save/i];
    const buttons = Array.from(document.querySelectorAll("button, a, [role='button']"))
      .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"))
      .filter((el) => actionPatterns.some((rx) => rx.test((el.innerText || el.getAttribute("aria-label") || "").trim())));

    [...textInputs.slice(0, 8), ...buttons.slice(0, 10)].forEach((el) => el.classList.add("hots-scan-highlight"));
    setTimeout(() => {
      document.querySelectorAll(".hots-scan-highlight").forEach((el) => el.classList.remove("hots-scan-highlight"));
    }, 3500);

    const btnLabels = buttons.slice(0, 5).map((b) => `"${(b.innerText || b.getAttribute("aria-label") || "").trim().slice(0, 22)}"`).join(", ");
    const msg = `Scan: ${fileInputs.length} file input, ${textInputs.length} input teks, ${buttons.length} tombol (${btnLabels || "-"})`;
    setLog(msg);
    return { fileInputs: fileInputs.length, textInputs: textInputs.length, buttons: buttons.length, message: msg };
  }

  // =========================================================
  // 2. SINKRONISASI PRODUK ALIBABA (list-manage)
  // =========================================================
  async function syncAlibabaProducts() {
    if (pageType !== "list") {
      setLog("🔄 Menyegarkan daftar SKU & kategori dari localhost:8888...");
      await loadCategories();
      await loadQueue(catEl.value, searchEl.value, skuSelect.value);
      const msg = `✓ Sinkronisasi lokal selesai (${queueItems.length} SKU pada kategori terpilih).`;
      setLog(msg);
      return { ok: true, message: msg };
    }

    setLog("🔄 Memindai daftar produk di i.alibaba.com/products/list-manage...");
    const rows = Array.from(document.querySelectorAll("tr, .product-item, .next-table-row, [class*='product-row']"));
    const scanned = [];
    for (const r of rows) {
      const txt = (r.innerText || "").trim();
      if (!txt || txt.length < 8) continue;
      const idMatch = txt.match(/\b(1[0-9]{10,15}|16[0-9]{8,12})\b/);
      const firstLine = txt.split("\n").map((s) => s.trim()).filter(Boolean)[0] || "";
      if (firstLine && (idMatch || txt.toLowerCase().includes("ap ") || txt.toLowerCase().includes("petrova") || txt.toLowerCase().includes("boot"))) {
        scanned.push({
          alibaba_product_id: idMatch ? idMatch[1] : "",
          title: firstLine.slice(0, 140),
          model_number: ""
        });
      }
    }

    if (scanned.length === 0) {
      const msg = "Tidak ada baris produk terbaca di DOM saat ini. Pastikan tabel list produk sudah termuat.";
      setLog(msg);
      return { ok: false, message: msg };
    }

    const syncRes = await sendMsg({ type: "BRIDGE_SYNC_ALIBABA_LIST", items: scanned });
    if (syncRes && syncRes.ok && syncRes.data && syncRes.data.success) {
      const msg = `✓ Sinkronisasi selesai: ${syncRes.data.scanned_count} baris dipindai, ${syncRes.data.matched_master_skus} Master SKU cocok!`;
      setLog(msg);
      return { ok: true, message: msg };
    }
    setLog("❌ Gagal sinkronisasi ke database lokal.");
    return { ok: false, message: "Gagal sinkronisasi ke DB" };
  }

  // =========================================================
  // 3. INJECT FOTO & ISI DESKRIPSI (publish-plan & photobank)
  // =========================================================
  function buildAlibabaPublishDescription(p) {
    const attrs = p.attributes || {};
    const header = [
      `Product Title: ${p.Product_Name}`,
      `Model / SKU: ${attrs.model_number || p.original_sku} (${p.master_sku})`,
      `Brand: ${attrs.brand_name || "AP Boots"} | Origin: ${attrs.place_of_origin || "Indonesia"}`,
      `Target Keywords: ${p.Keyword_1}, ${p.Keyword_2}, ${p.Keyword_3}`,
      `Wholesale MOQ & FOB Reference: ${p.MOQ} Pairs | USD $${p.Price_Min} - $${p.Price_Max} / Pair`,
      `Recommended Category: ${p.Category_Path}`,
      ""
    ].join("\n");
    const body = (p.description_en || "").trim();
    return `${header}${body}`.slice(0, 9500);
  }

  function findPublishDescriptionTextarea() {
    const areas = Array.from(document.querySelectorAll("textarea"))
      .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"));
    return (
      areas.find((el) => /describe your product|description/i.test(el.placeholder || "")) ||
      areas[0] ||
      null
    );
  }

  function fillPublishPlanDescription(p) {
    const descEl = findPublishDescriptionTextarea();
    if (!descEl) return false;
    const text = buildAlibabaPublishDescription(p);
    descEl.focus();
    setReactInputValue(descEl, text);
    descEl.classList.add("hots-freeze-locked");

    const aiBtn = findClickableByText([/auto-fill details with ai/i]);
    if (aiBtn) aiBtn.classList.add("hots-scan-highlight");

    setLog(`✓ Deskripsi B2B ${p.master_sku} (${text.length} kar.) diisikan! Klik 'Auto-fill details with AI'.`);
    return true;
  }

  function waitAndFillDescription(p, maxWaitMs = 6000) {
    const started = Date.now();
    const timer = setInterval(() => {
      if (fillPublishPlanDescription(p) || Date.now() - started > maxWaitMs) {
        clearInterval(timer);
      }
    }, 500);
  }

  async function injectSelectedPhotos(p) {
    const imgs = getSelectedImagesFromProduct();
    if (!imgs.length) {
      setLog("❌ Tidak ada foto terpilih untuk disuntikkan.");
      return { ok: false, message: "Tidak ada foto terpilih" };
    }

    const maxUpload = pageType === "flow" ? 1 : 6;
    const targetImgs = pageType === "flow" ? [imgs[0]] : imgs;
    setLog(`⏳ Mengirim ${Math.min(targetImgs.length, maxUpload)} foto terpilih (${p.master_sku})...`);
    const dt = await buildDataTransferFromImages(targetImgs, maxUpload);
    if (dt.files.length === 0) {
      setLog("❌ Gagal mengambil file gambar dari localhost:8888.");
      return { ok: false, message: "Gagal fetch gambar lokal" };
    }

    if (pageType === "photobank") {
      const groupMatch = findClickableByText([
        new RegExp(p.Photobank_Group.replace(/_/g, "[_\\s-]*"), "i"),
        new RegExp(p.Photobank_Group_Label, "i")
      ]);
      if (groupMatch) {
        groupMatch.click();
        groupMatch.classList.add("hots-scan-highlight");
      }
    }

    const fileInputs = findFileInputsDeep();
    if (fileInputs.length > 0) {
      fileInputs[0].files = dt.files;
      fileInputs[0].dispatchEvent(new Event("change", { bubbles: true }));
      const msg = `✓ ${dt.files.length} foto ${p.master_sku} berhasil disuntikkan!`;
      setLog(msg);
      if (pageType === "publish_plan") waitAndFillDescription(p);
      return { ok: true, message: msg };
    }

    const dropzone = document.querySelector("[class*='upload'], [class*='drop'], .next-upload-drag");
    if (dropzone) {
      dropzone.dispatchEvent(new DragEvent("drop", { bubbles: true, cancelable: true, dataTransfer: dt }));
      const msg = `✓ Drop event ${dt.files.length} foto dikirim ke area upload!`;
      setLog(msg);
      if (pageType === "publish_plan") waitAndFillDescription(p);
      return { ok: true, message: msg };
    }

    const msg = "Input file belum terbuka di halaman ini.";
    setLog(msg);
    return { ok: false, message: msg };
  }

  // =========================================================
  // 4. GOOGLE FLOW AGENT MODE + AUTO-DOWNLOAD (HERO 2K, LAINNYA 2K->1K)
  // =========================================================
  function findFlowSendButton(promptBox) {
    const allBtns = Array.from(document.querySelectorAll("button, [role='button']"))
      .filter((b) => b.offsetParent !== null && !b.closest("#hots-ext-panel") && !b.disabled && b.getAttribute("aria-disabled") !== "true");
    const byLabel = allBtns.find((b) =>
      /mulai pembuatan|send|kirim|submit|generate|arrow_forward/i.test(
        `${b.innerText || ""} ${b.getAttribute("aria-label") || ""} ${b.title || ""}`
      )
    );
    if (byLabel) return byLabel;

    if (promptBox) {
      let parent = promptBox.parentElement;
      for (let i = 0; i < 6 && parent; i++) {
        const localBtns = Array.from(parent.querySelectorAll("button, [role='button']"))
          .filter((b) => b.offsetParent !== null && !b.closest("#hots-ext-panel") && !b.disabled && b.getAttribute("aria-disabled") !== "true");
        if (localBtns.length >= 2) {
          return localBtns[localBtns.length - 1];
        }
        parent = parent.parentElement;
      }
    }
    return null;
  }

  async function downloadFlowCardResolution(cardEl, slotIdx) {
    if (isPaused) return false;
    const isHero = slotIdx === 1;
    cardEl.dispatchEvent(new MouseEvent("mouseenter", { bubbles: true }));
    await sleep(250);

    const moreBtn = Array.from(cardEl.querySelectorAll("button, [role='button']"))
      .find((b) => /more|⋮|menu|option/i.test(`${b.innerText} ${b.getAttribute("aria-label") || ""}`) || b.querySelector("svg"));
    if (!moreBtn) return false;

    moreBtn.click();
    await sleep(350);

    const dlItem = findClickableByText([/^download$/i, /download/i]);
    if (!dlItem) return false;
    dlItem.dispatchEvent(new PointerEvent("pointerenter", { bubbles: true }));
    dlItem.dispatchEvent(new MouseEvent("mouseenter", { bubbles: true }));
    dlItem.dispatchEvent(new MouseEvent("mouseover", { bubbles: true }));
    await sleep(300);
    if (!findClickableByText([/^2k/i, /^1k/i])) {
      dlItem.click();
      await sleep(350);
    }

    // Look for 2K and 1K options in the submenu
    const opt2K = findClickableByText([/^2k/i, /2k\b/i]);
    const opt1K = findClickableByText([/^1k/i, /1k\b/i]);

    const isLimited = (el) => {
      if (!el) return true;
      const txt = (el.innerText || "").toLowerCase();
      const ariaDis = el.getAttribute("aria-disabled") === "true" || el.disabled;
      return ariaDis || txt.includes("upgrade");
    };

    if (isHero) {
      if (opt2K && !isLimited(opt2K)) {
        await sendMsg({ type: "BRIDGE_SET_SETTINGS", flowSlotIndex: 1, flowLastRes: "2K" });
        opt2K.click();
        setLog(`✓ Hero (Slot 1) diunduh resolusi 2K!`);
        return true;
      }
      setLog(`⚠️ Hero wajib 2K, namun opsi 2K tidak tersedia/terkunci.`);
      return false;
    }

    // Slot 2-4: try 2K, fallback to 1K if limited
    if (opt2K && !isLimited(opt2K)) {
      await sendMsg({ type: "BRIDGE_SET_SETTINGS", flowSlotIndex: slotIdx, flowLastRes: "2K" });
      opt2K.click();
      setLog(`✓ Slot ${slotIdx} diunduh resolusi 2K!`);
      return true;
    }
    if (opt1K) {
      await sendMsg({ type: "BRIDGE_SET_SETTINGS", flowSlotIndex: slotIdx, flowLastRes: "1K" });
      opt1K.click();
      setLog(`✓ Slot ${slotIdx} fallback ke resolusi 1K (2K limited).`);
      return true;
    }
    return false;
  }

  function getFlowGeneratedCards() {
    const cards = Array.from(document.querySelectorAll("img"))
      .filter((img) => img.offsetParent !== null && img.naturalWidth >= 256 && !img.closest("#hots-ext-panel"))
      .map((img) => img.closest("[class*='card'], [class*='item'], [class*='tile'], div"))
      .filter(Boolean);
    return Array.from(new Set(cards));
  }

  function findFlowAgentActionButton(promptBox) {
    const btns = Array.from(document.querySelectorAll("button, [role='button']"))
      .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"));
    const excludeRe = /cancel|batal|close|tutup|delete|hapus|stop|henti|upgrade|pro|pause|jeda|download|unduh/i;
    const matchRe = /^(continue|lanjutkan|generate|buat|approve|setujui|confirm|konfirmasi|proceed|mulai pembuatan)$/i;
    const partialRe = /\b(continue|lanjutkan|generate|mulai pembuatan)\b/i;

    for (const btn of btns) {
      if (btn.disabled || btn.getAttribute("aria-disabled") === "true") continue;
      if (promptBox && btn.closest("form") && promptBox.closest("form") === btn.closest("form")) continue;
      const txt = ((btn.innerText || "") + " " + (btn.getAttribute("aria-label") || "")).trim();
      if (!txt || excludeRe.test(txt)) continue;
      if (matchRe.test(txt) || partialRe.test(txt)) return btn;
    }
    return null;
  }

  let flowWatcherActiveId = 0;

  async function watchAndCompleteFlowRun(sku, initialSrcs) {
    const runId = ++flowWatcherActiveId;
    const clickedBtns = new WeakSet();
    let lastNewCount = 0;
    let stableTicks = 0;

    setLog(`⏳ Menunggu Google Flow (${sku}) memproses Continue/Generate & hasil...`);

    for (let tick = 0; tick < 120; tick++) {
      await sleep(2500);
      if (runId !== flowWatcherActiveId) return;
      if (isPaused) {
        setLog(`⏸️ Watcher Google Flow (${sku}) dijeda.`);
        return;
      }

      if (chkApprove && chkApprove.checked) {
        let promptBox = document.querySelector("textarea, div[contenteditable='true'], [role='textbox']");
        const actionBtn = findFlowAgentActionButton(promptBox);
        if (actionBtn && !clickedBtns.has(actionBtn)) {
          clickedBtns.add(actionBtn);
          const label = (actionBtn.innerText || actionBtn.getAttribute("aria-label") || "Continue").trim().slice(0, 32);
          actionBtn.click();
          setLog(`🤖 Always Approve (${sku}): klik "${label}"...`);
          stableTicks = 0;
          continue;
        }
      }

      const newCards = getFlowGeneratedCards().filter((card) => {
        const img = card.querySelector("img");
        return img && img.src && !initialSrcs.has(img.src);
      });

      if (newCards.length > 0) {
        if (newCards.length === lastNewCount) {
          stableTicks++;
        } else {
          lastNewCount = newCards.length;
          stableTicks = 0;
          setLog(`🎨 Terdeteksi ${newCards.length} gambar baru (${sku}), menunggu selesai...`);
        }

        if (newCards.length >= 4 || stableTicks >= 3) {
          await sleep(1500);
          if (runId !== flowWatcherActiveId || isPaused) return;
          await autoDownloadFlowResults(newCards.slice(0, 4));
          return;
        }
      }
    }

    setLog(`⌛ Timeout menunggu hasil Google Flow (${sku}). Klik Auto-Download manual jika gambar sudah muncul.`);
  }

  async function autoDownloadFlowResults(targetCards = null) {
    if (isPaused) {
      setLog("⏸️ Sedang Pause. Klik Resume untuk melanjutkan Auto-Download.");
      return { ok: false, message: "Paused" };
    }
    const uniqueCards = (targetCards && targetCards.length ? targetCards : getFlowGeneratedCards()).slice(0, 4);
    if (uniqueCards.length === 0) {
      const msg = "Belum ada kartu gambar hasil Flow yang terdeteksi di layar.";
      setLog(msg);
      return { ok: false, message: msg };
    }

    let dlCount = 0;
    for (let i = 0; i < uniqueCards.length; i++) {
      if (isPaused) {
        setLog(`⏸️ Dijeda setelah ${dlCount} gambar.`);
        break;
      }
      const ok = await downloadFlowCardResolution(uniqueCards[i], i + 1);
      if (ok) dlCount++;
      await sleep(900);
    }
    const msg = `✓ Proses Auto-Download selesai (${dlCount}/${uniqueCards.length} gambar). Memuat ke Foto Lokal Produk...`;
    setLog(msg);
    if (dlCount > 0) {
      await sleep(1800);
      await loadProductDetails(skuSelect.value);
    }
    return { ok: true, message: msg };
  }

  async function runOnFlow(p) {
    if (isPaused) {
      const msg = "⏸️ Status sedang PAUSE. Klik ▶️ Resume terlebih dahulu.";
      setLog(msg);
      return { ok: false, message: msg };
    }

    const fRes = await sendMsg({ type: "BRIDGE_FLOW_JOBS", sku: p.master_sku });
    if (!fRes || !fRes.ok || !fRes.data || !fRes.data.jobs || !fRes.data.jobs.length) {
      setLog("❌ Gagal memuat job Google Flow.");
      return { ok: false, message: "Gagal memuat job Flow" };
    }

    const initialSrcs = new Set(
      getFlowGeneratedCards()
        .map((c) => c.querySelector("img")?.src)
        .filter(Boolean)
    );

    const combinedAgentPrompt = fRes.data.jobs
      .map((j) => `[${j.slot_label}]\n${j.prompt}`)
      .join("\n\n");

    let promptBox = document.querySelector("textarea, div[contenteditable='true'], [role='textbox']");
    const refImgs = getSelectedImagesFromProduct();
    if (refImgs.length > 0) {
      const dt = await buildDataTransferFromImages([refImgs[0]], 1);
      if (dt.files.length > 0) {
        let fileInputs = findFileInputsDeep();
        let openedPopover = false;
        if (fileInputs.length === 0) {
          const addMediaBtn = Array.from(document.querySelectorAll("button, [role='button']"))
            .filter((b) => b.offsetParent !== null && !b.closest("#hots-ext-panel"))
            .find((b) => /tambahkan bahan|add.*ingredient|add.*media|attach/i.test(
              `${b.innerText || ""} ${b.getAttribute("aria-label") || ""} ${b.title || ""}`
            ));
          if (addMediaBtn) {
            addMediaBtn.click();
            openedPopover = true;
            await sleep(450);
            fileInputs = findFileInputsDeep();
          }
        }

        if (fileInputs.length > 0) {
          fileInputs[0].files = dt.files;
          fileInputs[0].dispatchEvent(new Event("input", { bubbles: true }));
          fileInputs[0].dispatchEvent(new Event("change", { bubbles: true }));
          await sleep(800);
          if (openedPopover && promptBox) {
            document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", code: "Escape", bubbles: true }));
            await sleep(200);
          }
        } else if (promptBox) {
          if (openedPopover) {
            document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", code: "Escape", bubbles: true }));
            await sleep(200);
          }
          // Google Flow Slate/rich composer accepts pasted/dropped image files directly without OS dialog
          promptBox.focus();
          try {
            const pasteEv = new ClipboardEvent("paste", { bubbles: true, cancelable: true, clipboardData: dt });
            promptBox.dispatchEvent(pasteEv);
          } catch (_) {}
          const composerWrap = promptBox.closest("form, div[class*='composer'], div[class*='input']") || promptBox.parentElement;
          for (const dropTarget of [promptBox, composerWrap].filter(Boolean)) {
            dropTarget.dispatchEvent(new DragEvent("dragenter", { bubbles: true, cancelable: true, dataTransfer: dt }));
            dropTarget.dispatchEvent(new DragEvent("dragover", { bubbles: true, cancelable: true, dataTransfer: dt }));
            dropTarget.dispatchEvent(new DragEvent("drop", { bubbles: true, cancelable: true, dataTransfer: dt }));
          }
          await sleep(700);
        }
      }
    }

    // Re-query promptBox after image attachment settles (Google Flow re-renders Slate composer when Bahan chip is added)
    await sleep(600);
    promptBox = document.querySelector("textarea, div[contenteditable='true'], [role='textbox']");
    if (promptBox) {
      for (let attempt = 0; attempt < 2; attempt++) {
        promptBox.click();
        promptBox.focus();
        if (promptBox.tagName === "TEXTAREA") {
          setReactInputValue(promptBox, combinedAgentPrompt);
        } else {
          document.execCommand("selectAll", false, null);
          const inserted = document.execCommand("insertText", false, combinedAgentPrompt);
          if (!inserted || !(promptBox.innerText || "").includes("Slot")) {
            promptBox.textContent = combinedAgentPrompt;
            promptBox.dispatchEvent(new InputEvent("input", { bubbles: true, data: combinedAgentPrompt, inputType: "insertText" }));
          }
        }
        await sleep(350);
        const currentTxt = (promptBox.value !== undefined ? promptBox.value : promptBox.innerText) || "";
        if (currentTxt.includes("Slot")) break;
        promptBox = document.querySelector("textarea, div[contenteditable='true'], [role='textbox']") || promptBox;
      }
    }

    if (chkApprove.checked && !isPaused && promptBox) {
      let sendBtn = null;
      for (let t = 0; t < 12; t++) {
        await sleep(250);
        sendBtn = findFlowSendButton(promptBox);
        if (sendBtn) break;
      }
      if (sendBtn) {
        sendBtn.click();
        const msg = `🚀 Always Approve: Referensi & 4-Slot Agent Prompt (${p.master_sku}) dikirim ke Google Flow! Memantau Continue/Generate & Auto-Download...`;
        setLog(msg);
        watchAndCompleteFlowRun(p.master_sku, initialSrcs);
        return { ok: true, message: msg };
      }
    }

    const msg = `✓ Referensi & 4-Slot Agent Prompt (${p.master_sku}) terisi. Klik → untuk generate.`;
    setLog(msg);
    return { ok: true, message: msg };
  }

  // =========================================================
  // 5. AUTO-FILL & FREEZE DI FORM POST ALIBABA
  // =========================================================
  function getFieldContextLabel(el) {
    const item = el.closest(".next-form-item, [class*='form-item'], [class*='field'], tr, li, label");
    const labelText = item ? (item.innerText || "").slice(0, 140) : "";
    return `${el.name || ""} ${el.id || ""} ${el.placeholder || ""} ${el.getAttribute("aria-label") || ""} ${labelText}`.toLowerCase();
  }

  async function selectAlibabaPostCategory(p) {
    const catTrigger = Array.from(document.querySelectorAll("button, [role='button'], [role='combobox'], div[class*='select']"))
      .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"))
      .find((el) => /select a category/i.test((el.innerText || el.getAttribute("aria-label") || "").trim()));
    if (!catTrigger) return false;

    catTrigger.click();
    await sleep(600);

    const catLower = `${p.Category_Path || ""} ${p.Photobank_Group_Label || ""} ${p.Product_Name || ""}`.toLowerCase();
    const patterns = [];
    if (catLower.includes("safety") || catLower.includes("petrova")) {
      patterns.push(/work\s*&\s*safety\s*shoes/i, /safety\s*footwear/i, /safety\s*boots/i, /rain\s*boots/i);
    } else if (catLower.includes("sandal") || catLower.includes("clog") || catLower.includes("slides")) {
      patterns.push(/slides\s*&\s*slippers/i, /clogs/i, /sandals/i, /rain\s*boots/i);
    } else if (catLower.includes("kasual") || catLower.includes("sneaker") || catLower.includes("pantofel") || catLower.includes("977")) {
      patterns.push(/casual\s*shoes/i, /sneakers/i, /loafers/i, /rain\s*boots/i);
    } else if (catLower.includes("kids") || catLower.includes("children")) {
      patterns.push(/children.*rain\s*boots/i, /kids.*boots/i, /rain\s*boots/i);
    } else {
      patterns.push(/rain\s*boots/i, /work\s*&\s*safety\s*shoes/i, /functional\s*shoes/i);
    }

    const candidates = Array.from(document.querySelectorAll("label, li, [role='option'], [role='radio'], [role='menuitem'], div[class*='option']"))
      .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"));

    for (const rx of patterns) {
      const hit = candidates.find((el) => rx.test((el.innerText || "").trim()) && !/candle|perfume|fragrance/i.test(el.innerText || ""));
      if (hit) {
        hit.click();
        await sleep(1100);
        return true;
      }
    }
    return false;
  }

  async function runOnPostForm(p) {
    if (freezeTimer) clearInterval(freezeTimer);
    const lockedFields = [];

    setProgress(15, "⏳ [1/5] Memilih kategori sepatu Alibaba...");
    const catPicked = await selectAlibabaPostCategory(p);
    if (catPicked) setLog(`✓ Kategori sepatu dipilih sesuai ${p.Photobank_Group_Label || p.Category_Path}.`);

    setProgress(35, "⏳ [2/5] Menyuntikkan foto produk...");
    if (selectedImageUrls.size > 0 && findFileInputsDeep().length > 0) {
      await injectSelectedPhotos(p);
      await sleep(500);
    }

    setProgress(60, "⏳ [3/5] Mengisi judul, keyword, dan atribut...");
    const inputs = Array.from(document.querySelectorAll("input:not([type='file']):not([type='hidden']):not([type='radio']):not([type='checkbox']), textarea"))
      .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"));

    const findField = (rx, excludeRx = null) => inputs.find((el) => {
      const meta = getFieldContextLabel(el);
      if (excludeRx && excludeRx.test(meta)) return false;
      return rx.test(meta);
    });

    const titleEl = findField(/product\s*name|enter english characters|title|subject/, /keyword/);
    if (titleEl) {
      setReactInputValue(titleEl, p.Product_Name);
      lockedFields.push({ el: titleEl, val: p.Product_Name });
    }

    const kwText = [p.Keyword_1, p.Keyword_2, p.Keyword_3].filter(Boolean).join(", ");
    const kwEl = findField(/product\s*keywords|hidden to buyers|keyword/);
    if (kwEl && kwText) {
      setReactInputValue(kwEl, kwText);
      lockedFields.push({ el: kwEl, val: kwText });
    }

    const originEl = findField(/place\s*of\s*origin/);
    if (originEl) {
      setReactInputValue(originEl, p.attributes?.place_of_origin || "Indonesia");
      lockedFields.push({ el: originEl, val: p.attributes?.place_of_origin || "Indonesia" });
    }

    const brandEl = findField(/brand\s*name/);
    if (brandEl && p.attributes?.brand_name) {
      setReactInputValue(brandEl, p.attributes.brand_name);
      lockedFields.push({ el: brandEl, val: p.attributes.brand_name });
    }

    const modelEl = findField(/model\s*number/);
    if (modelEl && p.attributes?.model_number) {
      setReactInputValue(modelEl, p.attributes.model_number);
      lockedFields.push({ el: modelEl, val: p.attributes.model_number });
    }

    const weightEl = findField(/product\s*weight/);
    if (weightEl && p.attributes?.weight_kg) {
      setReactInputValue(weightEl, String(p.attributes.weight_kg));
      lockedFields.push({ el: weightEl, val: String(p.attributes.weight_kg) });
    }

    // Auto-select dropdown & multi-select attributes (Upper/Outsole/Midsole/Lining Material, Gender, Boot Height, Toe Style, Unit)
    async function selectAlibabaDropdownOption(labelRx, valueRxList) {
      const triggers = Array.from(document.querySelectorAll("[role='combobox'], [aria-haspopup='listbox'], .next-select, button"))
        .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"));
      const trigger = triggers.find((el) => {
        const item = el.closest(".next-form-item, [class*='form-item'], [class*='field'], tr, div");
        return item && labelRx.test((item.innerText || "").slice(0, 100));
      });
      if (!trigger) return false;
      trigger.click();
      await sleep(320);
      const options = Array.from(document.querySelectorAll("[role='option'], li.next-menu-item, .next-select-menu-item, label"))
        .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"));
      for (const rx of valueRxList) {
        const opt = options.find((el) => rx.test((el.innerText || "").trim()));
        if (opt) {
          opt.click();
          await sleep(180);
          document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", code: "Escape", bubbles: true }));
          await sleep(120);
          return true;
        }
      }
      document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", code: "Escape", bubbles: true }));
      return false;
    }

    const attrs = p.attributes || {};
    let dropdownHits = 0;
    const ddTasks = [
      [/upper\s*material/i, [/pvc/i, /polyvinyl/i, /rubber/i]],
      [/outsole\s*material/i, [/pvc/i, /rubber/i, /nitrile/i]],
      [/midsole\s*material/i, [new RegExp(attrs.midsole_material || "pvc", "i"), /pvc/i, /steel/i]],
      [/lining\s*material/i, [/pvc/i, /cotton/i, /polyester/i]],
      [/gender/i, [new RegExp(attrs.gender || "unisex", "i"), /unisex/i, /men/i]],
      [/boot\s*height/i, [new RegExp(attrs.boot_height || "mid-calf", "i"), /mid-calf/i, /knee/i, /ankle/i]],
      [/toe\s*style/i, [new RegExp(attrs.toe_style || "round toe", "i"), /round toe/i, /steel toe/i]],
      [/\bunit\b/i, [/^pair/i, /pairs/i]]
    ];
    for (const [lRx, vList] of ddTasks) {
      if (isPaused) break;
      if (await selectAlibabaDropdownOption(lRx, vList)) dropdownHits++;
    }
    if (dropdownHits > 0) setLog(`✓ ${dropdownHits} atribut dropdown Alibaba terpilih otomatis.`);

    setProgress(80, "⏳ [4/5] Mengisi MOQ & harga FOB USD...");
    const moqEl = findField(/moq|min\.?\s*order|quantity\s*price|>=|min.*qty/, /price/);
    if (moqEl) {
      setReactInputValue(moqEl, String(p.MOQ));
      lockedFields.push({ el: moqEl, val: String(p.MOQ) });
    }

    const priceMinEl = findField(/min.*price|price.*min|fob.*min|lower|unit\s*price|price\s*\(usd\)/, /max.*price|higher/);
    if (priceMinEl) {
      setReactInputValue(priceMinEl, String(p.Price_Min));
      lockedFields.push({ el: priceMinEl, val: String(p.Price_Min) });
    }

    const priceMaxEl = findField(/max.*price|price.*max|fob.*max|higher/);
    if (priceMaxEl) {
      setReactInputValue(priceMaxEl, String(p.Price_Max));
      lockedFields.push({ el: priceMaxEl, val: String(p.Price_Max) });
    }

    setProgress(92, "⏳ [5/5] Mengisi deskripsi B2B...");
    const descText = buildAlibabaPublishDescription(p);
    const descArea = findField(/detailed\s*description|product\s*description/);
    if (descArea) {
      setReactInputValue(descArea, descText);
      lockedFields.push({ el: descArea, val: descText });
    } else {
      const ceDesc = Array.from(document.querySelectorAll("[contenteditable='true']"))
        .filter((el) => el.offsetParent !== null && !el.closest("#hots-ext-panel"))
        .pop();
      if (ceDesc) {
        ceDesc.focus();
        ceDesc.innerText = descText;
        ceDesc.dispatchEvent(new InputEvent("input", { bubbles: true, data: descText, inputType: "insertText" }));
      }
    }

    lockedFields.forEach((f) => f.el.classList.add("hots-freeze-locked"));
    freezeTimer = setInterval(() => {
      if (isPaused) return;
      for (const f of lockedFields) {
        if (document.body.contains(f.el) && f.el.value !== f.val) {
          setReactInputValue(f.el, f.val);
        }
      }
    }, 400);

    setProgress(100, `✓ Selesai (${lockedFields.length} field terisi & terkunci)`);
    const msg = `✓ Auto-Fill & Freeze aktif pada ${lockedFields.length} field ${p.master_sku} (MOQ: ${p.MOQ}, FOB: $${p.Price_Min}–$${p.Price_Max}).`;
    setLog(msg);
    return { ok: true, message: msg };
  }

  async function executeAutoRun(skuOverride) {
    if (isPaused) {
      const msg = "⏸️ Status sedang PAUSE. Klik ▶️ Resume untuk melanjutkan.";
      setProgress(0, "⏸️ Dijeda");
      setLog(msg);
      return { ok: false, message: msg };
    }
    const sku = skuOverride || skuSelect.value || "MST-001";
    setProgress(10, `⏳ Memuat data ${sku} dari bridge...`);
    const prodRes = await sendMsg({ type: "BRIDGE_PRODUCT", sku });
    if (!prodRes || !prodRes.ok || !prodRes.data || !prodRes.data.success) {
      const msg = `❌ Gagal mengambil data ${sku} dari localhost:8888.`;
      setProgress(0, "❌ Gagal memuat SKU");
      setLog(msg);
      return { ok: false, message: msg };
    }
    const p = prodRes.data;
    currentProduct = p;

    if (pageType === "publish_plan") {
      if (findPublishDescriptionTextarea()) {
        setProgress(85, "⏳ Mengisi deskripsi B2B...");
        fillPublishPlanDescription(p);
        setProgress(100, "✓ Deskripsi B2B terisi");
        return { ok: true, message: `Deskripsi B2B ${p.master_sku} diisi.` };
      }
      setProgress(50, "⏳ Menyuntikkan foto ke publish-plan...");
      const r = await injectSelectedPhotos(p);
      setProgress(r.ok ? 100 : 0, r.ok ? "✓ Foto tersuntik" : "⚠️ Gagal suntik foto");
      return r;
    }
    if (pageType === "photobank") {
      setProgress(50, "⏳ Upload foto ke Photobank...");
      const r = await injectSelectedPhotos(p);
      setProgress(r.ok ? 100 : 0, r.ok ? "✓ Foto terkirim" : "⚠️ Gagal upload");
      return r;
    }
    if (pageType === "list") {
      setProgress(50, "⏳ Sinkronisasi daftar produk...");
      const r = await syncAlibabaProducts();
      setProgress(r.ok ? 100 : 0, r.ok ? "✓ Sinkronisasi selesai" : "⚠️ Gagal sync");
      return r;
    }
    if (pageType === "post") return await runOnPostForm(p);
    if (pageType === "flow") {
      setProgress(45, `⏳ Mengirim Hero & 4-Slot Prompt (${p.master_sku})...`);
      const r = await runOnFlow(p);
      setProgress(r.ok ? 80 : 0, r.ok ? "⏳ Menunggu hasil Flow & Download..." : "⚠️ Gagal di Flow");
      return r;
    }

    const msg = `Halaman ini (${host}) tidak memiliki target auto-fill langsung.`;
    setProgress(0, "ℹ️ Tidak ada target");
    setLog(msg);
    return { ok: false, message: msg };
  }

  // =========================================================
  // 6. DATA LOADERS (KATEGORI, QUEUE, THUMBNAILS)
  // =========================================================
  async function loadCategories(savedCat = "") {
    const cRes = await sendMsg({ type: "BRIDGE_CATEGORIES" });
    if (!cRes || !cRes.ok || !cRes.data || !cRes.data.categories) return;
    catEl.innerHTML = `<option value="">📁 Semua Kategori Folder (125 SKU)</option>` +
      cRes.data.categories
        .map((c) => `<option value="${c.folder}">📁 ${c.folder} — ${c.label} (${c.count} SKU)</option>`)
        .join("");
    if (savedCat) catEl.value = savedCat;
  }

  function loadProductDetail(sku) {
    return sendMsg({ type: "BRIDGE_PRODUCT", sku }).then((res) => {
      if (!res || !res.ok || !res.data || !res.data.success) {
        infoBox.innerHTML = `<span style="color:#f87171;">Gagal memuat detail ${sku}.</span>`;
        return null;
      }
      const p = res.data;
      currentProduct = p;
      infoBox.innerHTML = `
        <div><strong>${p.master_sku}</strong> (${p.original_sku})</div>
        <div style="color:#cbd5e1; margin:2px 0;">${p.Product_Name.slice(0, 68)}...</div>
        <div class="hots-lock-tag">🔒 MOQ: ${p.MOQ} prs | FOB: $${p.Price_Min}–$${p.Price_Max}</div>
        <div>📁 Grup: <strong>${p.Photobank_Group}</strong></div>
      `;
      renderThumbnailGallery(p.images);
      return p;
    });
  }

  function renderFilteredOptions(filterText, preferSku) {
    const q = (filterText || "").trim().toLowerCase();
    const filtered = q
      ? queueItems.filter((it) => {
          const hay = `${it.master_sku} ${it.original_sku} ${it.model_name} ${it.category_name} ${it.photobank_group}`.toLowerCase();
          return hay.includes(q);
        })
      : queueItems;

    if (filtered.length === 0) {
      skuSelect.innerHTML = `<option value="">-- Tidak ada produk cocok --</option>`;
      thumbGrid.innerHTML = "";
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
    loadProductDetail(skuSelect.value);
  }

  async function loadQueue(categoryFolder = "", searchText = "", preferSku = "") {
    const qRes = await sendMsg({ type: "BRIDGE_QUEUE", category: categoryFolder });
    if (!qRes || !qRes.ok || !qRes.data || !qRes.data.items) return;
    queueItems = qRes.data.items;
    renderFilteredOptions(searchText, preferSku);
  }

  async function initBridge() {
    const hRes = await sendMsg({ type: "BRIDGE_HEALTH" });
    if (hRes && hRes.ok && hRes.data && hRes.data.success) {
      statusEl.textContent = `ONLINE • ${hRes.data.total_master_skus} SKU`;
      statusEl.className = "online";
    } else {
      statusEl.textContent = "OFFLINE";
      statusEl.className = "offline";
      infoBox.innerHTML = `<span style="color:#f87171;">Server localhost:8888 belum aktif. Jalankan <b>run_alibaba_extension_flow.bat</b>.</span>`;
      return;
    }

    const settings = await sendMsg({ type: "BRIDGE_GET_SETTINGS" });
    const savedSku = (settings && settings.activeSku) || "MST-001";
    const savedCat = (settings && settings.activeCategory) || "";
    chkApprove.checked = settings ? settings.alwaysApprove !== false : true;
    chkAutoRun.checked = settings ? settings.autoRunOnSelect === true : false;
    isPaused = settings ? settings.isPaused === true : false;
    updatePauseBtnUI();

    await loadCategories(savedCat);
    await loadQueue(savedCat, "", savedSku);
  }

  catEl.addEventListener("change", async () => {
    const cat = catEl.value;
    await sendMsg({ type: "BRIDGE_SET_SETTINGS", activeCategory: cat });
    await loadQueue(cat, searchEl.value, skuSelect.value);
    setLog(`Filter kategori: ${cat || "Semua"}`);
  });

  searchEl.addEventListener("input", () => {
    renderFilteredOptions(searchEl.value, skuSelect.value);
  });

  skuSelect.addEventListener("change", async () => {
    const sku = skuSelect.value;
    if (!sku) return;
    await sendMsg({ type: "BRIDGE_SET_ACTIVE_SKU", sku });
    await loadProductDetail(sku);
    if (chkAutoRun.checked && !isPaused) {
      await executeAutoRun(sku);
    } else {
      setLog(`✓ Thumbnail lokal ${sku} dimuat. Pilih foto lalu klik 'Suntik Foto Terpilih'.`);
    }
  });

  chkApprove.addEventListener("change", () => {
    sendMsg({ type: "BRIDGE_SET_SETTINGS", alwaysApprove: chkApprove.checked });
  });

  chkAutoRun.addEventListener("change", () => {
    sendMsg({ type: "BRIDGE_SET_SETTINGS", autoRunOnSelect: chkAutoRun.checked });
  });

  btnPause.addEventListener("click", () => {
    isPaused = !isPaused;
    updatePauseBtnUI();
    sendMsg({ type: "BRIDGE_SET_SETTINGS", isPaused });
    setLog(isPaused ? "⏸️ Otomasi dijeda (PAUSED)." : "▶️ Otomasi dilanjutkan (RESUMED).");
  });

  document.getElementById("hots-btn-inject").addEventListener("click", () => {
    if (currentProduct) injectSelectedPhotos(currentProduct);
  });
  document.getElementById("hots-btn-autorun").addEventListener("click", () => executeAutoRun());
  document.getElementById("hots-btn-sync").addEventListener("click", () => syncAlibabaProducts());
  document.getElementById("hots-btn-scan").addEventListener("click", () => scanPageButtons());

  const fillDescBtn = document.getElementById("hots-btn-fill-desc");
  if (fillDescBtn) {
    fillDescBtn.addEventListener("click", () => {
      if (!currentProduct) return;
      if (!fillPublishPlanDescription(currentProduct)) {
        setLog("⚠️ Kotak 'Product description' belum muncul di layar.");
      }
    });
  }

  const flowDlBtn = document.getElementById("hots-btn-flow-dl");
  if (flowDlBtn) {
    flowDlBtn.addEventListener("click", () => autoDownloadFlowResults());
  }

  document.getElementById("hots-btn-copy-title").addEventListener("click", () => {
    if (!currentProduct) return;
    const text = `Title: ${currentProduct.Product_Name}\nKW1: ${currentProduct.Keyword_1}\nKW2: ${currentProduct.Keyword_2}\nKW3: ${currentProduct.Keyword_3}\nMOQ: ${currentProduct.MOQ}\nPrice: $${currentProduct.Price_Min} - $${currentProduct.Price_Max}`;
    navigator.clipboard.writeText(text).then(() => {
      setLog(`✓ Data & harga terkunci ${currentProduct.master_sku} disalin.`);
    });
  });

  document.getElementById("hots-btn-copy-flow").addEventListener("click", async () => {
    const sku = skuSelect.value || "MST-001";
    const res = await sendMsg({ type: "BRIDGE_FLOW_JOBS", sku });
    if (!res || !res.ok || !res.data || !res.data.jobs) {
      setLog("Gagal mengambil prompt Flow.");
      return;
    }
    const promptText = res.data.jobs.map((j) => `[${j.slot_label}]\n${j.prompt}`).join("\n\n");
    navigator.clipboard.writeText(promptText).then(() => {
      setLog(`✓ 4 Prompt Google Flow untuk ${sku} disalin!`);
    });
  });

  chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    if (!msg || !msg.type) return false;
    if (msg.type === "TRIGGER_AUTO_RUN") {
      if (msg.sku) skuSelect.value = msg.sku;
      executeAutoRun(msg.sku).then((res) => sendResponse(res));
      return true;
    }
    if (msg.type === "TRIGGER_SYNC_LIST") {
      syncAlibabaProducts().then((res) => sendResponse(res));
      return true;
    }
    if (msg.type === "TRIGGER_SCAN_BUTTONS") {
      sendResponse(scanPageButtons());
      return true;
    }
    return false;
  });

  initBridge();
})();
