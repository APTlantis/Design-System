/* ==========================================================================
   APTLANTIS v2.0 — Lightweight Explainer Component Behaviors (apt-explainer.js)
   Zero dependencies · Progressive enhancement · Works with or without HTMX
   ========================================================================== */

(function () {
  "use strict";

  // 1. Copy-to-clipboard buttons
  function bindCopyButtons(root) {
    root.querySelectorAll("[data-apt-copy]").forEach((btn) => {
      if (btn.dataset.bound) return;
      btn.dataset.bound = "true";
      btn.addEventListener("click", async () => {
        const targetSelector = btn.getAttribute("data-apt-copy");
        const target = targetSelector ? document.querySelector(targetSelector) : null;
        const text = target ? target.textContent : "";
        if (!text) return;
        const original = btn.textContent;
        try {
          await navigator.clipboard.writeText(text.trim());
          btn.textContent = "Copied!";
        } catch (_) {
          btn.textContent = "Copy failed";
        }
        setTimeout(() => {
          btn.textContent = original;
        }, 1600);
      });
    });
  }

  // 2. Code viewer tabs
  function bindCodeTabs(root) {
    root.querySelectorAll("[data-apt-code-viewer]").forEach((viewer) => {
      if (viewer.dataset.bound) return;
      viewer.dataset.bound = "true";
      const tabs = viewer.querySelectorAll("[data-code-tab]");
      const panels = viewer.querySelectorAll("[data-code-panel]");
      const copyBtn = viewer.querySelector("[data-apt-copy]");

      tabs.forEach((tab) => {
        tab.addEventListener("click", () => {
          const key = tab.getAttribute("data-code-tab");
          tabs.forEach((t) => t.setAttribute("aria-selected", String(t === tab)));
          panels.forEach((p) => {
            const match = p.getAttribute("data-code-panel") === key;
            p.hidden = !match;
            if (match && copyBtn && p.id) {
              copyBtn.setAttribute("data-apt-copy", `#${p.id}`);
            }
          });
        });
      });
    });
  }

  // 3. Gallery filter pills
  function bindGalleryFilters(root) {
    const filterBar = root.querySelector("[data-apt-gallery-filter]");
    if (!filterBar || filterBar.dataset.bound) return;
    filterBar.dataset.bound = "true";
    const buttons = filterBar.querySelectorAll("[data-filter]");
    const cards = document.querySelectorAll("[data-component-card]");

    buttons.forEach((btn) => {
      btn.addEventListener("click", () => {
        const filter = btn.getAttribute("data-filter");
        buttons.forEach((b) => b.setAttribute("aria-pressed", String(b === btn)));
        cards.forEach((card) => {
          const status = card.getAttribute("data-status");
          const cat = card.getAttribute("data-category");
          const show = filter === "ALL" || status === filter || cat === filter;
          card.hidden = !show;
        });
      });
    });
  }

  // 4. Interactive Process Stepper (supports both standalone DOM & HTMX swaps)
  function bindSteppers(root) {
    root.querySelectorAll("[data-apt-stepper]").forEach((stepper) => {
      if (stepper.dataset.bound) return;
      stepper.dataset.bound = "true";

      const triggers = Array.from(stepper.querySelectorAll("[data-step-index]"));
      const panels = Array.from(stepper.querySelectorAll("[data-step-panel]"));
      const prevBtn = stepper.querySelector("[data-step-prev]");
      const nextBtn = stepper.querySelector("[data-step-next]");
      const progressFill = stepper.querySelector("[data-step-progress]");
      const counter = stepper.querySelector("[data-step-counter]");

      let activeIdx = triggers.findIndex((t) => t.getAttribute("aria-selected") === "true");
      if (activeIdx < 0) activeIdx = 0;

      function sync(idx, triggerHtmx) {
        activeIdx = Math.max(0, Math.min(triggers.length - 1, idx));
        triggers.forEach((btn, i) => {
          btn.setAttribute("aria-selected", String(i === activeIdx));
          btn.setAttribute("tabindex", i === activeIdx ? "0" : "-1");
          btn.setAttribute("data-completed", String(i < activeIdx));
        });

        // Standalone panel switching (when local panels exist)
        if (panels.length > 0) {
          panels.forEach((panel, i) => {
            panel.hidden = i !== activeIdx;
          });
        } else if (triggerHtmx && typeof htmx !== "undefined") {
          const activeBtn = triggers[activeIdx];
          if (activeBtn && activeBtn.hasAttribute("hx-get")) {
            htmx.trigger(activeBtn, "click");
          }
        }

        if (progressFill) {
          const pct = ((activeIdx + 1) / triggers.length) * 100;
          progressFill.style.width = `${pct}%`;
        }
        if (counter) {
          counter.textContent = `STAGE ${String(activeIdx + 1).padStart(2, "0")} / ${String(triggers.length).padStart(2, "0")}`;
        }
        if (prevBtn) prevBtn.disabled = activeIdx === 0;
        if (nextBtn) nextBtn.disabled = activeIdx === triggers.length - 1;
      }

      triggers.forEach((btn, i) => {
        btn.addEventListener("click", () => sync(i, false));
        btn.addEventListener("keydown", (e) => {
          let next = null;
          if (e.key === "ArrowRight" || e.key === "ArrowDown") next = (i + 1) % triggers.length;
          if (e.key === "ArrowLeft" || e.key === "ArrowUp") next = (i - 1 + triggers.length) % triggers.length;
          if (e.key === "Home") next = 0;
          if (e.key === "End") next = triggers.length - 1;
          if (next !== null) {
            e.preventDefault();
            triggers[next].focus();
            sync(next, true);
          }
        });
      });

      if (prevBtn) prevBtn.addEventListener("click", () => sync(activeIdx - 1, true));
      if (nextBtn) nextBtn.addEventListener("click", () => sync(activeIdx + 1, true));

      sync(activeIdx, false);
    });
  }

  // 5. Expandable Explanation Panel (local depth tabs + HTMX active sync)
  function bindExplainPanels(root) {
    root.querySelectorAll("[data-apt-explain]").forEach((panel) => {
      if (panel.dataset.bound) return;
      panel.dataset.bound = "true";

      const tabs = Array.from(panel.querySelectorAll("[data-depth-key]"));
      const sections = Array.from(panel.querySelectorAll("[data-depth-panel]"));

      function activate(tab) {
        const key = tab.getAttribute("data-depth-key");
        tabs.forEach((t) => {
          t.setAttribute("aria-selected", String(t === tab));
          t.setAttribute("tabindex", t === tab ? "0" : "-1");
        });
        if (sections.length > 0) {
          sections.forEach((s) => {
            s.hidden = s.getAttribute("data-depth-panel") !== key;
          });
        }
      }

      tabs.forEach((tab, i) => {
        tab.addEventListener("click", () => activate(tab));
        tab.addEventListener("keydown", (e) => {
          let next = null;
          if (e.key === "ArrowRight") next = (i + 1) % tabs.length;
          if (e.key === "ArrowLeft") next = (i - 1 + tabs.length) % tabs.length;
          if (next !== null) {
            e.preventDefault();
            tabs[next].focus();
            tabs[next].click();
          }
        });
      });
    });
  }

  // 6. Interactive Diagram Inspector (SVG node selection + keyboard Enter/Space)
  function bindDiagrams(root) {
    root.querySelectorAll("[data-apt-diagram]").forEach((diagram) => {
      if (diagram.dataset.bound) return;
      diagram.dataset.bound = "true";

      const nodes = Array.from(diagram.querySelectorAll("[data-diagram-node]"));
      nodes.forEach((node) => {
        const select = () => {
          nodes.forEach((n) => n.setAttribute("aria-selected", String(n === node)));
        };
        node.addEventListener("click", select);
        node.addEventListener("keydown", (e) => {
          if (e.key === "Enter" || e.key === " ") {
            e.preventDefault();
            select();
            if (typeof htmx !== "undefined" && node.hasAttribute("hx-get")) {
              htmx.trigger(node, "click");
            }
          }
        });
      });
    });
  }

  // 7. Before / After Comparison (range slider + preset mode buttons)
  function bindComparisons(root) {
    root.querySelectorAll("[data-apt-compare]").forEach((wrap) => {
      if (wrap.dataset.bound) return;
      wrap.dataset.bound = "true";

      const stage = wrap.querySelector(".apt-compare");
      const range = wrap.querySelector(".apt-compare-range");
      const readout = wrap.querySelector("[data-compare-readout]");
      const modeBtns = Array.from(wrap.querySelectorAll("[data-compare-preset]"));

      function setSplit(val) {
        const clamped = Math.max(0, Math.min(100, Number(val)));
        stage.style.setProperty("--split", `${clamped}%`);
        if (range) range.value = String(clamped);
        if (readout) readout.textContent = `${Math.round(clamped)}%`;
        modeBtns.forEach((btn) => {
          const preset = Number(btn.getAttribute("data-compare-preset"));
          btn.setAttribute("aria-pressed", String(Math.abs(preset - clamped) < 1));
        });
      }

      if (range) {
        range.addEventListener("input", (e) => setSplit(e.target.value));
      }

      modeBtns.forEach((btn) => {
        btn.addEventListener("click", () => setSplit(btn.getAttribute("data-compare-preset")));
      });

      setSplit(range ? range.value : 52);
    });
  }

  // 8. Theme Switcher & Live Preview (isolated [data-apt-theme] scoping)
  function bindThemeSwitchers(root) {
    root.querySelectorAll("[data-apt-theme-switcher]").forEach((switcher) => {
      if (switcher.dataset.bound) return;
      switcher.dataset.bound = "true";

      const stage = switcher.querySelector("[data-theme-stage]");
      const buttons = Array.from(switcher.querySelectorAll("[data-theme-pick]"));
      const nameOut = switcher.querySelector("[data-theme-name]");
      const taglineOut = switcher.querySelector("[data-theme-tagline]");
      const snippetOut = switcher.querySelector("[data-theme-snippet]");

      buttons.forEach((btn) => {
        btn.addEventListener("click", () => {
          const key = btn.getAttribute("data-theme-pick");
          buttons.forEach((b) => b.setAttribute("aria-pressed", String(b === btn)));
          if (stage) stage.setAttribute("data-apt-theme", key);
          if (nameOut) nameOut.textContent = btn.getAttribute("data-theme-label") || key;
          if (taglineOut) taglineOut.textContent = btn.getAttribute("data-theme-desc") || "";
          if (snippetOut) snippetOut.textContent = btn.getAttribute("data-theme-css") || "";
        });
      });
    });
  }

  // 9. Color & OKLCH Explorer (live L/C/H sliders + role presets)
  function bindOklchExplorers(root) {
    root.querySelectorAll("[data-apt-oklch]").forEach((explorer) => {
      if (explorer.dataset.bound) return;
      explorer.dataset.bound = "true";

      const lInput = explorer.querySelector("[data-oklch-l]");
      const cInput = explorer.querySelector("[data-oklch-c]");
      const hInput = explorer.querySelector("[data-oklch-h]");
      const lOut = explorer.querySelector("[data-oklch-l-out]");
      const cOut = explorer.querySelector("[data-oklch-c-out]");
      const hOut = explorer.querySelector("[data-oklch-h-out]");
      const cssOut = explorer.querySelector("[data-oklch-css]");
      const roleBtns = Array.from(explorer.querySelectorAll("[data-oklch-role]"));

      function update() {
        const l = Number(lInput.value).toFixed(2);
        const c = Number(cInput.value).toFixed(3);
        const h = Math.round(Number(hInput.value));
        explorer.style.setProperty("--ok-l", l);
        explorer.style.setProperty("--ok-c", c);
        explorer.style.setProperty("--ok-h", String(h));
        if (lOut) lOut.textContent = l;
        if (cOut) cOut.textContent = c;
        if (hOut) hOut.textContent = `${h}°`;
        if (cssOut) cssOut.textContent = `oklch(${l} ${c} ${h})`;
      }

      [lInput, cInput, hInput].forEach((el) => {
        if (el) el.addEventListener("input", update);
      });

      roleBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
          roleBtns.forEach((b) => b.setAttribute("aria-selected", String(b === btn)));
          if (lInput) lInput.value = btn.getAttribute("data-l") || "0.77";
          if (cInput) cInput.value = btn.getAttribute("data-c") || "0.145";
          if (hInput) hInput.value = btn.getAttribute("data-h") || "204";
          update();
        });
      });

      update();
    });
  }

  // 10. Artifact Gallery category filter & active card highlight
  function bindArtifactGallery(root) {
    root.querySelectorAll("[data-apt-artifacts]").forEach((gallery) => {
      if (gallery.dataset.bound) return;
      gallery.dataset.bound = "true";

      const filterBtns = Array.from(gallery.querySelectorAll("[data-artifact-filter]"));
      const cards = Array.from(gallery.querySelectorAll("[data-artifact-card]"));

      filterBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
          const cat = btn.getAttribute("data-artifact-filter");
          filterBtns.forEach((b) => b.setAttribute("aria-pressed", String(b === btn)));
          cards.forEach((card) => {
            card.hidden = cat !== "ALL" && card.getAttribute("data-artifact-category") !== cat;
          });
        });
      });

      cards.forEach((card) => {
        card.addEventListener("click", () => {
          cards.forEach((c) => c.setAttribute("data-selected", String(c === card)));
        });
      });
    });
  }

  // 11. Feature Spotlight interactive demo toggles
  function bindSpotlights(root) {
    root.querySelectorAll("[data-apt-spotlight-toggle]").forEach((btn) => {
      if (btn.dataset.bound) return;
      btn.dataset.bound = "true";
      btn.addEventListener("click", () => {
        const visual = btn.closest(".apt-spotlight")?.querySelector(".apt-spotlight-visual");
        if (!visual) return;
        const isOn = visual.getAttribute("data-glow") === "on";
        visual.setAttribute("data-glow", isOn ? "off" : "on");
        btn.setAttribute("aria-pressed", String(!isOn));
        btn.textContent = isOn ? "Enable Bioluminescent Glow" : "Disable Bioluminescent Glow";
      });
    });
  }

  // 12. Interactive Timeline keyboard & active selection
  function bindTimelines(root) {
    root.querySelectorAll("[data-apt-timeline]").forEach((tl) => {
      if (tl.dataset.bound) return;
      tl.dataset.bound = "true";
      const nodes = Array.from(tl.querySelectorAll("[data-timeline-node]"));

      function select(idx) {
        nodes.forEach((n, i) => {
          n.setAttribute("aria-selected", String(i === idx));
          n.setAttribute("tabindex", i === idx ? "0" : "-1");
        });
      }

      nodes.forEach((node, i) => {
        node.addEventListener("click", () => select(i));
        node.addEventListener("keydown", (e) => {
          let next = null;
          if (e.key === "ArrowRight" || e.key === "ArrowDown") next = (i + 1) % nodes.length;
          if (e.key === "ArrowLeft" || e.key === "ArrowUp") next = (i - 1 + nodes.length) % nodes.length;
          if (e.key === "Home") next = 0;
          if (e.key === "End") next = nodes.length - 1;
          if (next !== null) {
            e.preventDefault();
            nodes[next].focus();
            nodes[next].click();
          }
        });
      });
    });
  }

  // 13. Component Playground live property editor + markup generator
  function bindPlaygrounds(root) {
    root.querySelectorAll("[data-apt-playground]").forEach((pg) => {
      if (pg.dataset.bound) return;
      pg.dataset.bound = "true";

      const card = pg.querySelector("[data-pg-card]");
      const badge = pg.querySelector("[data-pg-badge]");
      const titleEl = pg.querySelector("[data-pg-title]");
      const metricEl = pg.querySelector("[data-pg-metric]");
      const codeOut = pg.querySelector("[data-pg-code]");

      const variantSel = pg.querySelector("[data-pg-variant]");
      const densitySel = pg.querySelector("[data-pg-density]");
      const glowSel = pg.querySelector("[data-pg-glow]");
      const toneSel = pg.querySelector("[data-pg-tone]");
      const titleInput = pg.querySelector("[data-pg-title-input]");
      const metricInput = pg.querySelector("[data-pg-metric-input]");

      function render() {
        const variant = variantSel ? variantSel.value : "primary";
        const density = densitySel ? densitySel.value : "comfortable";
        const glow = glowSel && glowSel.checked ? "on" : "off";
        const tone = toneSel ? toneSel.value : "cyan";
        const title = (titleInput && titleInput.value.trim()) || "Pelagic Telemetry Node";
        const metric = (metricInput && metricInput.value.trim()) || "9.4 ms · VERIFIED";

        if (card) {
          card.setAttribute("data-variant", variant);
          card.setAttribute("data-density", density);
          card.setAttribute("data-glow", glow);
        }
        if (badge) {
          badge.setAttribute("data-tone", tone);
          badge.textContent = tone === "amber" ? "GOVERNANCE" : "ONLINE";
        }
        if (titleEl) titleEl.textContent = title;
        if (metricEl) metricEl.textContent = metric;

        if (codeOut) {
          codeOut.textContent =
`<article class="apt-hud-card" data-variant="${variant}" data-density="${density}" data-glow="${glow}">
  <div style="display:flex; justify-content:space-between; align-items:center;">
    <strong class="apt-display">${title}</strong>
    <span class="apt-badge" data-tone="${tone}">${tone === "amber" ? "GOVERNANCE" : "ONLINE"}</span>
  </div>
  <span class="apt-mono" style="font-size:0.78rem; color:var(--apt-text-secondary);">${metric}</span>
</article>`;
        }
      }

      [variantSel, densitySel, glowSel, toneSel, titleInput, metricInput].forEach((el) => {
        if (el) {
          el.addEventListener("input", render);
          el.addEventListener("change", render);
        }
      });

      render();
    });
  }

  // 14. Mermaid Skills Topology (classDef vs Base Theme toggle + active node/edge highlight)
  function bindMermaidTopology(root) {
    root.querySelectorAll("[data-apt-mmd-kit]").forEach((kit) => {
      if (kit.dataset.bound) return;
      kit.dataset.bound = "true";

      const modeBtns = Array.from(kit.querySelectorAll("[data-mmd-mode]"));
      const lensBtns = Array.from(kit.querySelectorAll("[data-mmd-lens-btn]"));

      modeBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
          const mode = btn.getAttribute("data-mmd-mode");
          modeBtns.forEach((b) => b.setAttribute("aria-pressed", String(b === btn)));
          kit.querySelectorAll("[data-mmd-stage]").forEach((stage) => {
            stage.setAttribute("data-style-mode", mode);
          });
        });
      });

      lensBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
          lensBtns.forEach((b) => b.setAttribute("aria-selected", String(b === btn)));
        });
      });
    });

    root.querySelectorAll("[data-mmd-stage]").forEach((stage) => {
      if (stage.dataset.bound) return;
      stage.dataset.bound = "true";

      // Sync current mode from outer kit toggle if present
      const activeModeBtn = document.querySelector("[data-mmd-mode][aria-pressed='true']");
      if (activeModeBtn) {
        stage.setAttribute("data-style-mode", activeModeBtn.getAttribute("data-mmd-mode"));
      }

      const nodes = Array.from(stage.querySelectorAll("[data-mmd-node]"));
      const edges = Array.from(stage.querySelectorAll("[data-mmd-edge]"));

      function highlight(nodeId) {
        nodes.forEach((n) => n.setAttribute("aria-selected", String(n.getAttribute("data-mmd-node") === nodeId)));
        edges.forEach((e) => {
          const ends = (e.getAttribute("data-mmd-edge") || "").split(",");
          const active = ends.includes(nodeId);
          e.setAttribute("data-active", String(active));
          e.setAttribute("marker-end", active ? "url(#aptMmdArrowActive)" : "url(#aptMmdArrow)");
        });
      }

      nodes.forEach((node) => {
        const id = node.getAttribute("data-mmd-node");
        node.addEventListener("click", () => highlight(id));
        node.addEventListener("keydown", (e) => {
          if (e.key === "Enter" || e.key === " ") {
            e.preventDefault();
            highlight(id);
            if (typeof htmx !== "undefined" && node.hasAttribute("hx-get")) {
              htmx.trigger(node, "click");
            }
          }
        });
      });

      const initial = nodes.find((n) => n.getAttribute("aria-selected") === "true");
      if (initial) highlight(initial.getAttribute("data-mmd-node"));
    });
  }

  function initAll(root) {
    bindCopyButtons(root);
    bindCodeTabs(root);
    bindGalleryFilters(root);
    bindSteppers(root);
    bindExplainPanels(root);
    bindDiagrams(root);
    bindComparisons(root);
    bindThemeSwitchers(root);
    bindOklchExplorers(root);
    bindArtifactGallery(root);
    bindSpotlights(root);
    bindTimelines(root);
    bindPlaygrounds(root);
    bindMermaidTopology(root);
  }

  document.addEventListener("DOMContentLoaded", () => initAll(document));
  document.body.addEventListener("htmx:afterSwap", (evt) => {
    if (evt.detail && evt.detail.target) {
      initAll(evt.detail.target);
    }
  });
})();
