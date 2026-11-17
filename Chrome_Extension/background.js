// Background Service Worker (Manifest V3) — HOTS Alibaba & Google Flow Bridge
const BRIDGE_BASE = "http://localhost:8888";
const HOTS_GROUP_TITLE = "HOTS Flow";
const HOTS_GROUP_COLOR = "blue";

const WORKSPACE_URLS = {
  local: "http://localhost:8888",
  flow: "https://flow.google.com/project/5a88c3fd-477c-4eed-a126-f812ccfb079c",
  photobank: "https://photobank.alibaba.com/?spm=a2747.$spmCode.0.0.486254bez2VZ2Y",
  list: "https://i.alibaba.com/products/list-manage?spm=a2700.post-success.0.0.290f3e5fVEhelJ#/product/all",
  publish: "https://post.alibaba.com/product/publish.htm"
};

const WORKSPACE_MATCHERS = {
  flow: (url) => url.includes("flow.google.com/project/5a88c3fd-477c-4eed-a126-f812ccfb079c") || url.includes("flow.google.com"),
  photobank: (url) => url.includes("photobank.alibaba.com"),
  publish: (url) => url.includes("post.alibaba.com/product/publish.htm") || url.includes("i.alibaba.com/products/publish-plan"),
  list: (url) => url.includes("i.alibaba.com/products/list-manage")
};

async function bridgeFetchJson(endpoint, options = {}) {
  const url = `${BRIDGE_BASE}${endpoint}`;
  const resp = await fetch(url, options);
  if (!resp.ok) {
    throw new Error(`HTTP ${resp.status} from ${endpoint}`);
  }
  return await resp.json();
}

function arrayBufferToBase64(buffer) {
  let binary = "";
  const bytes = new Uint8Array(buffer);
  const chunkSize = 0x8000;
  for (let i = 0; i < bytes.length; i += chunkSize) {
    binary += String.fromCharCode.apply(null, bytes.subarray(i, i + chunkSize));
  }
  return btoa(binary);
}

async function getCurrentWindowId() {
  const win = await chrome.windows.getLastFocused();
  return win ? win.id : chrome.windows.WINDOW_ID_CURRENT;
}

async function ensureTabsInHotsGroup(tabIds, windowId) {
  if (!tabIds || tabIds.length === 0) return null;
  const groups = await chrome.tabGroups.query({ title: HOTS_GROUP_TITLE, windowId });
  let groupId;
  if (groups && groups.length > 0) {
    groupId = groups[0].id;
    await chrome.tabs.group({ tabIds, groupId });
  } else {
    groupId = await chrome.tabs.group({ tabIds, createProperties: { windowId } });
    await chrome.tabGroups.update(groupId, {
      title: HOTS_GROUP_TITLE,
      color: HOTS_GROUP_COLOR,
      collapsed: false
    });
  }
  return groupId;
}

async function openOrFocusWorkspaceGroup(targets = ["flow", "photobank", "publish"], focusKey = "flow") {
  const windowId = await getCurrentWindowId();
  const existingTabs = await chrome.tabs.query({ windowId });
  const groupTabIds = [];
  let focusTabId = null;

  for (const key of targets) {
    const matcher = WORKSPACE_MATCHERS[key];
    const url = WORKSPACE_URLS[key];
    if (!url) continue;

    let tab = matcher ? existingTabs.find((t) => t.url && matcher(t.url)) : null;
    if (!tab) {
      tab = await chrome.tabs.create({ url, windowId, active: key === focusKey });
    }
    groupTabIds.push(tab.id);
    if (key === focusKey) {
      focusTabId = tab.id;
    }
  }

  const groupId = await ensureTabsInHotsGroup(groupTabIds, windowId);
  if (focusTabId) {
    await chrome.tabs.update(focusTabId, { active: true });
  }
  return { groupId, tabIds: groupTabIds, focusTabId };
}

async function closeHotsGroup() {
  const groups = await chrome.tabGroups.query({ title: HOTS_GROUP_TITLE });
  let closedCount = 0;
  for (const g of groups) {
    const tabs = await chrome.tabs.query({ groupId: g.id });
    const ids = tabs.map((t) => t.id);
    if (ids.length > 0) {
      await chrome.tabs.remove(ids);
      closedCount += ids.length;
    }
  }
  return { closedCount };
}

async function runFlowFromExtension(sku) {
  const windowId = await getCurrentWindowId();
  const existingTabs = await chrome.tabs.query({ windowId });
  let flowTab = existingTabs.find((t) => t.url && WORKSPACE_MATCHERS.flow(t.url));
  let newlyCreated = false;

  if (!flowTab) {
    flowTab = await chrome.tabs.create({ url: WORKSPACE_URLS.flow, windowId, active: true });
    newlyCreated = true;
  } else {
    await chrome.tabs.update(flowTab.id, { active: true });
  }

  await ensureTabsInHotsGroup([flowTab.id], windowId);

  if (newlyCreated) {
    await new Promise((resolve) => {
      const listener = (tabId, changeInfo) => {
        if (tabId === flowTab.id && changeInfo.status === "complete") {
          chrome.tabs.onUpdated.removeListener(listener);
          resolve();
        }
      };
      chrome.tabs.onUpdated.addListener(listener);
      setTimeout(() => {
        chrome.tabs.onUpdated.removeListener(listener);
        resolve();
      }, 9000);
    });
    await new Promise((r) => setTimeout(r, 1200));
  }

  return await new Promise((resolve) => {
    chrome.tabs.sendMessage(flowTab.id, { type: "TRIGGER_AUTO_RUN", sku }, (resp) => {
      if (chrome.runtime.lastError) {
        resolve({ ok: false, error: chrome.runtime.lastError.message });
      } else {
        resolve({ ok: true, data: resp });
      }
    });
  });
}

chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
  if (!msg || !msg.type) return false;

  if (msg.type === "BRIDGE_HEALTH") {
    bridgeFetchJson("/api/ext/health")
      .then((data) => sendResponse({ ok: true, data }))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "BRIDGE_CATEGORIES") {
    bridgeFetchJson("/api/ext/categories")
      .then((data) => sendResponse({ ok: true, data }))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "BRIDGE_QUEUE") {
    const q = encodeURIComponent(msg.q || "");
    const st = encodeURIComponent(msg.status || "");
    const cat = encodeURIComponent(msg.category || "");
    bridgeFetchJson(`/api/ext/queue?q=${q}&status=${st}&category=${cat}&limit=125`)
      .then((data) => sendResponse({ ok: true, data }))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "BRIDGE_PRODUCT") {
    const sku = encodeURIComponent(msg.sku || "MST-001");
    bridgeFetchJson(`/api/ext/product/${sku}`)
      .then((data) => sendResponse({ ok: true, data }))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "BRIDGE_FLOW_JOBS") {
    const sku = encodeURIComponent(msg.sku || "MST-001");
    bridgeFetchJson(`/api/ext/flow-jobs/${sku}`)
      .then((data) => sendResponse({ ok: true, data }))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "BRIDGE_FETCH_IMAGE_BASE64") {
    const rawPath = msg.path || (msg.url ? msg.url.replace(/^https?:\/\/(localhost|127\.0\.0\.1):8888/, "") : "");
    const safePath = rawPath.startsWith("/") ? encodeURI(rawPath) : rawPath;
    const candidates = rawPath.startsWith("/")
      ? [`http://127.0.0.1:8888${safePath}`, `http://localhost:8888${safePath}`]
      : [encodeURI(msg.url || "")];

    (async () => {
      let lastErr = "Unknown error";
      for (const targetUrl of candidates) {
        if (!targetUrl) continue;
        try {
          const resp = await fetch(targetUrl, { cache: "no-store" });
          if (!resp.ok) {
            lastErr = `HTTP ${resp.status} (${targetUrl})`;
            continue;
          }
          const buf = await resp.arrayBuffer();
          const mimeType = (resp.headers.get("content-type") || "image/webp").split(";")[0];
          const filename = msg.filename || targetUrl.split("/").pop().split("?")[0] || "product.webp";
          sendResponse({
            ok: true,
            base64: arrayBufferToBase64(buf),
            mimeType,
            filename
          });
          return;
        } catch (e) {
          lastErr = e.message;
        }
      }
      sendResponse({ ok: false, error: lastErr });
    })();
    return true;
  }

  if (msg.type === "BRIDGE_SYNC_ALIBABA_LIST") {
    bridgeFetchJson("/api/ext/sync-alibaba-list", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ items: msg.items || [] })
    })
      .then((data) => sendResponse({ ok: true, data }))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "BRIDGE_UPDATE_STATUS") {
    bridgeFetchJson("/api/ext/status", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        sku: msg.sku,
        status: msg.status,
        alibaba_product_id: msg.alibaba_product_id || ""
      })
    })
      .then((data) => sendResponse({ ok: true, data }))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "BRIDGE_SET_ACTIVE_SKU") {
    chrome.storage.local.set({ activeSku: msg.sku || "MST-001" }, () => {
      sendResponse({ ok: true, activeSku: msg.sku });
    });
    return true;
  }

  if (msg.type === "BRIDGE_GET_SETTINGS") {
    chrome.storage.local.get(
      ["activeSku", "activeCategory", "autoRunOnSelect", "alwaysApprove", "isPaused", "flowSlotIndex", "flowLastRes"],
      (res) => {
        sendResponse({
          ok: true,
          activeSku: res.activeSku || "MST-001",
          activeCategory: res.activeCategory || "",
          autoRunOnSelect: res.autoRunOnSelect === true,
          alwaysApprove: res.alwaysApprove !== false,
          isPaused: res.isPaused === true,
          flowSlotIndex: res.flowSlotIndex || 1,
          flowLastRes: res.flowLastRes || "2K"
        });
      }
    );
    return true;
  }

  if (msg.type === "BRIDGE_SET_SETTINGS") {
    const patch = {};
    if (msg.activeSku !== undefined) patch.activeSku = msg.activeSku;
    if (msg.activeCategory !== undefined) patch.activeCategory = msg.activeCategory;
    if (msg.autoRunOnSelect !== undefined) patch.autoRunOnSelect = Boolean(msg.autoRunOnSelect);
    if (msg.alwaysApprove !== undefined) patch.alwaysApprove = Boolean(msg.alwaysApprove);
    if (msg.isPaused !== undefined) patch.isPaused = Boolean(msg.isPaused);
    if (msg.flowSlotIndex !== undefined) patch.flowSlotIndex = Number(msg.flowSlotIndex);
    if (msg.flowLastRes !== undefined) patch.flowLastRes = msg.flowLastRes;
    chrome.storage.local.set(patch, () => {
      sendResponse({ ok: true, patch });
    });
    return true;
  }

  if (msg.type === "OPEN_HOTS_GROUP") {
    openOrFocusWorkspaceGroup(msg.targets || ["flow", "photobank", "publish"], msg.focusKey || "flow")
      .then((res) => sendResponse({ ok: true, data: res }))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "CLOSE_HOTS_GROUP") {
    closeHotsGroup()
      .then((res) => sendResponse({ ok: true, data: res }))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "RUN_FLOW_FROM_EXTENSION") {
    runFlowFromExtension(msg.sku || "MST-001")
      .then((res) => sendResponse(res))
      .catch((err) => sendResponse({ ok: false, error: err.message }));
    return true;
  }

  if (msg.type === "RUN_ON_ACTIVE_TAB") {
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
      if (!tabs || !tabs[0]) {
        sendResponse({ ok: false, error: "Tidak ada tab aktif" });
        return;
      }
      chrome.tabs.sendMessage(
        tabs[0].id,
        { type: msg.action || "TRIGGER_AUTO_RUN", sku: msg.sku },
        (resp) => {
          if (chrome.runtime.lastError) {
            sendResponse({ ok: false, error: chrome.runtime.lastError.message });
          } else {
            sendResponse({ ok: true, data: resp });
          }
        }
      );
    });
    return true;
  }

  if (msg.type === "OPEN_WORKSPACE_TAB") {
    const key = msg.target;
    if (key && key !== "local" && WORKSPACE_URLS[key]) {
      openOrFocusWorkspaceGroup([key], key)
        .then((res) => sendResponse({ ok: true, data: res }))
        .catch((err) => sendResponse({ ok: false, error: err.message }));
      return true;
    }
    const targetUrl = WORKSPACE_URLS[key] || msg.url;
    if (!targetUrl) {
      sendResponse({ ok: false, error: "URL target tidak dikenal" });
      return false;
    }
    chrome.tabs.create({ url: targetUrl }, (tab) => {
      sendResponse({ ok: true, tabId: tab.id });
    });
    return true;
  }

  return false;
});

chrome.downloads.onChanged.addListener((delta) => {
  if (delta.state && delta.state.current === "complete") {
    chrome.downloads.search({ id: delta.id }, async (items) => {
      if (!items || !items[0]) return;
      const dl = items[0];
      const url = (dl.url || "").toLowerCase();
      const ref = (dl.referrer || "").toLowerCase();
      const fname = (dl.filename || "").toLowerCase();
      const isImgFile = /\.(png|jpg|jpeg|webp)$/i.test(fname);
      let fromFlow =
        url.includes("flow.google") ||
        ref.includes("flow.google") ||
        url.includes("googleusercontent") ||
        url.includes("googleapis.com") ||
        url.startsWith("data:image");

      if (!fromFlow && isImgFile) {
        const flowTabs = await chrome.tabs.query({ url: "*://flow.google.com/*" });
        if (flowTabs && flowTabs.length > 0) fromFlow = true;
      }
      if (!fromFlow) return;

      chrome.storage.local.get(["activeSku", "flowSlotIndex", "flowLastRes"], (res) => {
        const sku = res.activeSku || "MST-001";
        const slotIdx = Number(res.flowSlotIndex || 1);
        const resolution = res.flowLastRes || "2K";
        bridgeFetchJson("/api/ext/flow-downloaded", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            sku,
            download_path: dl.filename || "",
            slot_index: slotIdx,
            resolution
          })
        })
          .then((r) => {
            console.log("[HOTS Flow Saved]", r);
            const nextSlot = slotIdx >= 4 ? 1 : slotIdx + 1;
            chrome.storage.local.set({ flowSlotIndex: nextSlot });
          })
          .catch((err) => console.warn("[HOTS Flow Save Warn]", err.message));
      });
    });
  }
});
