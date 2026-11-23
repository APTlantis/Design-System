# Aptlantis-Logo Markdown theme

Load apt-logo-markdown-tokens.css, apt-logo-markdown.css and optionally apt-logo-markdown-extras.css and syntax-prism.css. Put `markdown-body` on each document container. Wrap wide tables in `.table-scroll` for local scrolling without changing table layout. Supply a sanitized GFM renderer and a syntax engine; CSS does not parse Markdown. This stylesheet cannot theme GitHub.com READMEs.

Alerts use `.markdown-alert.markdown-alert-note|tip|important|warning|caution` with `.markdown-alert-title`; footnotes use `.footnotes` with accessible links. These are conditional HTML contracts, not formal GFM syntax support. The preview authors these extras separately from the parsed baseline.

Serve the output locally with a static HTTP server for browser previews. All assets are local. See apt-logo-markdown-coverage.json and vendor/browser-themes/manifest.json for coverage and pinned dependencies. No installation, activation or publication is performed.
