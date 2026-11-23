# APTLANTIS v2.0 — Desktop HTML / OKLCH CSS / htmx + Crystal/Kemal Bundle

## What Was Fixed From the Raw Conversation Export
1. **Merged & Repaired `apt-components.css`**: Recombined the split CSS blocks, fixed stripped HTML tags (`<dialog>`) in comments, and mapped every variable (`--apt-brand-secondary`, `--apt-border-interactive`, `--apt-status-danger-surface`, `--apt-radius-*`, `--apt-shadow-*`, `--apt-duration-*`) directly to your canonical `tokens-extended.css` primitives.
2. **Restored Stripped HTML in `components.html`**: Rebuilt the standalone `public/specimen.html` kitchen-sink with intact HTML structure, inline SVG 6-series chart, working JS demo handlers, and embedded `tokens-extended.css`.
3. **Completed `src/aptlantis.cr`**: Added `require "ecr"`, `require "html"`, the `GET /topology/refresh` endpoint, and the `GET /stream` SSE heartbeat route, and fixed the Mermaid node IDs (`01`..`04`) so clicking a graph node resolves cleanly in `STORE.find(id)`.
4. **Fixed Truncated CDN URLs in `layout.ecr`**: Restored full `fonts.googleapis.com`, `unpkg.com/htmx.org@2.0.4`, `unpkg.com/htmx-ext-sse@2.2.2/sse.js`, and `cdn.jsdelivr.net/npm/mermaid@11` URLs.

## Quick Start (Crystal / Kemal)
Requires Crystal 1.12 or newer. Verified on Windows with Crystal 1.22.2 and Kemal 1.15.0.

```bash
shards install
crystal run src/aptlantis.cr
```
Open `http://localhost:3000` for the live Kemal + htmx workspace, or open `public/specimen.html` directly in any browser for the standalone zero-backend specimen.

If upgrading an existing checkout from Kemal 1.5.0, run `shards update kemal` first. The old release passes strings to the standard library's static directory listing API, which now requires `Path` arguments. Keep the updated `shard.lock` with the project so subsequent installs use the verified versions.
