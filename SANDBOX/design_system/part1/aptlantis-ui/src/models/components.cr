module Aptlantis
  struct ComponentSpec
    getter number : String
    getter slug : String
    getter name : String
    getter category : String
    getter status : String
    getter summary : String
    getter dependencies : Array(String)
    getter htmx_demo : Bool

    def initialize(
      @number : String,
      @slug : String,
      @name : String,
      @category : String,
      @status : String,
      @summary : String,
      @dependencies : Array(String),
      @htmx_demo : Bool = false
    )
    end

    def live? : Bool
      @status == "LIVE"
    end
  end

  struct StepperStage
    getter index : Int32
    getter code : String
    getter title : String
    getter subtitle : String
    getter summary : String
    getter details : Array(String)
    getter artifact : String
    getter accent : String

    def initialize(
      @index : Int32,
      @code : String,
      @title : String,
      @subtitle : String,
      @summary : String,
      @details : Array(String),
      @artifact : String,
      @accent : String
    )
    end
  end

  struct ExplanationDepth
    getter key : String
    getter label : String
    getter reading_time : String
    getter headline : String
    getter body : String
    getter bullets : Array(String)
    getter code_sample : String?

    def initialize(
      @key : String,
      @label : String,
      @reading_time : String,
      @headline : String,
      @body : String,
      @bullets : Array(String),
      @code_sample : String? = nil
    )
    end
  end

  struct DiagramNode
    getter id : String
    getter code : String
    getter title : String
    getter layer : String
    getter status : String
    getter summary : String
    getter inputs : Array(String)
    getter outputs : Array(String)
    getter artifact_path : String

    def initialize(
      @id : String,
      @code : String,
      @title : String,
      @layer : String,
      @status : String,
      @summary : String,
      @inputs : Array(String),
      @outputs : Array(String),
      @artifact_path : String
    )
    end
  end

  struct ThemePreset
    getter key : String
    getter name : String
    getter tagline : String
    getter surface_hex : String
    getter primary_hex : String
    getter secondary_hex : String
    getter css_snippet : String

    def initialize(
      @key : String,
      @name : String,
      @tagline : String,
      @surface_hex : String,
      @primary_hex : String,
      @secondary_hex : String,
      @css_snippet : String
    )
    end
  end

  struct OklchRole
    getter key : String
    getter token : String
    getter label : String
    getter l : Float64
    getter c : Float64
    getter h : Int32
    getter hex_ref : String
    getter usage : String

    def initialize(
      @key : String,
      @token : String,
      @label : String,
      @l : Float64,
      @c : Float64,
      @h : Int32,
      @hex_ref : String,
      @usage : String
    )
    end
  end

  struct ArtifactItem
    getter id : String
    getter name : String
    getter category : String
    getter format : String
    getter size_label : String
    getter workspace_path : String
    getter summary : String
    getter copy_snippet : String
    getter download_filename : String
    getter download_mime : String
    getter download_body : String

    def initialize(
      @id : String,
      @name : String,
      @category : String,
      @format : String,
      @size_label : String,
      @workspace_path : String,
      @summary : String,
      @copy_snippet : String,
      @download_filename : String,
      @download_mime : String,
      @download_body : String
    )
    end
  end

  struct TimelineEvent
    getter id : String
    getter version : String
    getter date_label : String
    getter kind : String
    getter title : String
    getter summary : String
    getter highlights : Array(String)
    getter artifact : String

    def initialize(
      @id : String,
      @version : String,
      @date_label : String,
      @kind : String,
      @title : String,
      @summary : String,
      @highlights : Array(String),
      @artifact : String
    )
    end
  end

  struct DecisionChoice
    getter label : String
    getter hint : String
    getter next_id : String

    def initialize(@label : String, @hint : String, @next_id : String)
    end
  end

  struct DecisionNode
    getter id : String
    getter step_tag : String
    getter title : String
    getter body : String
    getter choices : Array(DecisionChoice)
    getter outcome_tag : String?
    getter outcome_checklist : Array(String)

    def initialize(
      @id : String,
      @step_tag : String,
      @title : String,
      @body : String,
      @choices : Array(DecisionChoice) = [] of DecisionChoice,
      @outcome_tag : String? = nil,
      @outcome_checklist : Array(String) = [] of String
    )
    end

    def outcome? : Bool
      !@outcome_tag.nil?
    end
  end

  class ComponentCatalog
    getter items : Array(ComponentSpec)
    getter stepper_stages : Array(StepperStage)
    getter explanation_depths : Array(ExplanationDepth)
    getter diagram_nodes : Array(DiagramNode)
    getter theme_presets : Array(ThemePreset)
    getter oklch_roles : Array(OklchRole)
    getter artifacts : Array(ArtifactItem)
    getter timeline_events : Array(TimelineEvent)
    getter decision_nodes : Array(DecisionNode)

    def initialize
      @items = [
        ComponentSpec.new(
          "01", "process-stepper", "Interactive Process Stepper", "Narrative", "LIVE",
          "Navigate sequential stages with stage-specific visuals, explanations, keyboard navigation, and optional HTMX stage fragment swaps.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js", "HTMX (optional)"],
          true
        ),
        ComponentSpec.new(
          "02", "explanation-panel", "Expandable Explanation Panel", "Progressive Depth", "LIVE",
          "Move smoothly between Simple, Detailed, and Technical explanations without leaving the page—available in pure HTML/JS or HTMX fragment mode.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js", "HTMX (optional)"],
          true
        ),
        ComponentSpec.new(
          "03", "diagram-inspector", "Interactive Diagram Inspector", "Visual Systems", "LIVE",
          "Select interactive SVG diagram nodes via mouse or keyboard to inspect live contextual metadata, inputs, and outputs in an adjacent panel.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js", "HTMX"],
          true
        ),
        ComponentSpec.new(
          "04", "before-after", "Before/After Comparison", "Visual Systems", "LIVE",
          "Compare two visual or functional states using a draggable split divider, keyboard-accessible range control, or instant state toggle.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js"],
          false
        ),
        ComponentSpec.new(
          "05", "theme-switcher", "Theme Switcher & Live Preview", "Theming", "LIVE",
          "Change an isolated specimen's palette or theme via scoped CSS custom properties and inspect surface, border, and accent contrast immediately.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js"],
          false
        ),
        ComponentSpec.new(
          "06", "oklch-explorer", "Color & OKLCH Explorer", "Theming", "LIVE",
          "Explore lightness, chroma, hue, semantic roles, and immediate preview changes alongside the canonical Aptlantis palette.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js", "HTMX (optional)"],
          true
        ),
        ComponentSpec.new(
          "07", "artifact-gallery", "Artifact Gallery", "Assets", "LIVE",
          "Browse Aptlantis SVGs, palettes, stylesheets, and icons with inline previews, category filters, metadata, copy actions, and downloads.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js", "HTMX"],
          true
        ),
        ComponentSpec.new(
          "08", "feature-spotlight", "Feature Spotlight", "Narrative", "LIVE",
          "Present a hero visual, a concise explanation, and an optional interactive demonstration in a balanced exhibition block.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js"],
          false
        ),
        ComponentSpec.new(
          "09", "interactive-timeline", "Interactive Timeline", "Narrative", "LIVE",
          "Explore project milestones, release versions, governance events, and linked artifacts along a keyboard-navigable axis.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js", "HTMX (optional)"],
          true
        ),
        ComponentSpec.new(
          "10", "code-output-viewer", "Tabbed Code & Output Viewer", "Developer", "LIVE",
          "Switch cleanly between live rendered preview, HTML, CSS, JavaScript, and token JSON with one-click copy and split-view mode.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js"],
          false
        ),
        ComponentSpec.new(
          "11", "decision-explorer", "Guided Decision Explorer", "Interactive", "LIVE",
          "Navigate a branching series of choices with contextual explanations, trail history, and actionable Aptlantis outcomes.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "HTMX"],
          true
        ),
        ComponentSpec.new(
          "12", "component-playground", "Component Playground", "Developer", "LIVE",
          "Adjust supported component properties live—variant, density, glow, tone, and copy—and inspect the resulting HTML and rendered preview.",
          ["tokens-extended.css", "apt-components.css", "apt-gallery.css", "apt-explainer.js"],
          false
        ),
      ]

      @stepper_stages = [
        StepperStage.new(
          1, "STAGE 01", "Source Artwork Ingestion", "Vector & raster brand geometry",
          "Begin with canonical Aptlantis emblems and markups—citadel shield, wordmark lockup, and icon glyphs—before any palette derivation occurs.",
          [
            "Inspects dominant oceanic hues, solar amber highlights, and neutral ink values.",
            "Preserves geometric proportions and stroke clarity across dark abyssal surfaces.",
            "Locks a deterministic provenance record for downstream token generation."
          ],
          "DESIGN-FOUNDATION/logos/aptlantis-citadel-shield.svg",
          "cyan"
        ),
        StepperStage.new(
          2, "STAGE 02", "OKLCH Extraction & Calibration", "32 perceptually uniform primitives",
          "Sampled colors are lifted into OKLCH space so lightness steps and chroma remain visually balanced across deep canvases and glowing accents.",
          [
            "Generates --apt-color-01 (#000000) through --apt-color-32 (#FDFDFB).",
            "Separates abyssal cyan luminance ramps from warm amber/sand counterpoints.",
            "Validates WCAG contrast pairs for primary text, secondary metadata, and status badges."
          ],
          "public/css/tokens-extended.css",
          "amber"
        ),
        StepperStage.new(
          3, "STAGE 03", "Semantic Role Mapping", "Surfaces, borders, brand, and status",
          "Raw primitives are bound to intent-driven CSS custom properties so components never hardcode hex values.",
          [
            "Maps surfaces: --apt-bg-void, --apt-bg-canvas, --apt-bg-base, --apt-bg-raised, --apt-bg-overlay.",
            "Maps interactive feedback: --apt-border-interactive, --apt-glow-primary, --apt-focus-ring.",
            "Keeps motion physics and radii alongside color tokens for cohesive HUD feel."
          ],
          "OTHER-FACETS/website/apt-logo-website-tokens.json",
          "cyan"
        ),
        StepperStage.new(
          4, "STAGE 04", "Multi-Facet Output & Live HTML", "Web, Markdown, SVG, Mermaid & Slides",
          "The calibrated token set fans out into ready-to-use CSS, Prism syntax themes, Mermaid configs, data-viz palettes, and reusable HTML components.",
          [
            "Zero-build CSS custom properties load directly in browsers or Kemal ECR templates.",
            "Components stay portable: copy HTML + CSS into any page without a JS framework.",
            "Same visual identity spans telemetry apps, explainers, diagrams, and documentation."
          ],
          "SANDBOX/design_system/part1/aptlantis-ui",
          "amber"
        ),
      ]

      @explanation_depths = [
        ExplanationDepth.new(
          "simple", "Simple", "20 sec read",
          "Why Aptlantis uses semantic color tokens instead of raw hex codes",
          "Think of semantic tokens like labeled switches on a submarine control panel. Instead of painting every button '#00CAE3' by hand, we tell the button to use 'brand-primary'. When we tune the glow or switch themes, every component updates together without breaking contrast.",
          [
            "One visual language across dashboards, explainers, and diagrams.",
            "Safe contrast on dark abyssal backgrounds by default.",
            "Easy to tweak a single token and see the whole system respond."
          ],
          nil
        ),
        ExplanationDepth.new(
          "detailed", "Detailed", "1 min read",
          "Two-tier architecture: 32 calibrated primitives mapped to UI intent",
          "Aptlantis separates palette calibration from component styling. Tier 1 holds 32 OKLCH-calibrated primitives (--apt-color-01 through --apt-color-32). Tier 2 assigns those primitives to functional roles—surfaces, borders, typography hierarchy, brand accents, and in-palette status tones.",
          [
            "Surface ladder: void (#000000) -> canvas (#02020E) -> base (#00101A) -> raised (#031C28) -> overlay (#05303F).",
            "Accent tension: cool bioluminescent cyan (#00CAE3 / #23F2F7) paired with solar amber (#F7BE4F).",
            "Components only reference Tier 2 tokens, making theme isolation straightforward."
          ],
          "/* Component consumes semantic intent, never raw hex */\n.apt-callout {\n  background: var(--apt-bg-raised);\n  border: 1px solid var(--apt-border-interactive);\n  color: var(--apt-text-primary);\n}"
        ),
        ExplanationDepth.new(
          "technical", "Technical", "2 min read",
          "Cascade layers, relative OKLCH alpha, and zero-runtime portability",
          "Stylesheets are partitioned with CSS @layer (apt.reset, apt.layout, apt.controls, apt.data, apt.overlays) so specimen styles compose predictably without selector specificity wars. Translucent borders and glows derive dynamically using CSS Color 5 relative syntax (oklch(from var(--apt-border-subtle) l c h / 0.5)), keeping every component pure HTML + CSS.",
          [
            "Zero preprocessor build step: tokens-extended.css loads directly in any modern browser.",
            "HTMX fragments inherit :root tokens automatically on swap with zero re-hydration.",
            "Focus visibility uses unified --apt-focus-ring and --apt-glow-primary tokens."
          ],
          "@layer apt.controls {\n  .apt-panel-head {\n    border-bottom: 1px solid oklch(from var(--apt-border-subtle) l c h / 0.5);\n    transition: border-color var(--apt-duration-fast) var(--apt-ease-instrument);\n  }\n}"
        ),
      ]

      @diagram_nodes = [
        DiagramNode.new(
          "foundation", "DF-01", "Design Foundation", "DESIGN-FOUNDATION", "ACTIVE",
          "Canonical visual primitives: 32 OKLCH tokens, Space Grotesk / Inter / JetBrains Mono fonts, brand emblems, and SVG icons.",
          ["Brand artwork (SVG)", "OKLCH calibration rules"],
          ["tokens-extended.css", "Typography & icon sprites"],
          "F:/DESIGN-FOUNDATION"
        ),
        DiagramNode.new(
          "components", "CL-02", "Component Library", "COMPONENY-LIBRARY / SANDBOX", "PROTOTYPING",
          "Reusable, HTML-first interactive specimens styled with Aptlantis tokens—prototyped in Sandbox and promoted once proven.",
          ["Semantic CSS tokens", "Minimal vanilla JS behaviors"],
          ["Copyable HTML/CSS specimens", "Standalone gallery demos"],
          "F:/SANDBOX/design_system/part1/aptlantis-ui"
        ),
        DiagramNode.new(
          "behavior", "BL-03", "Behavior & HTMX Layer", "BEHAVIOR-LAYER", "ACTIVE",
          "Focused client interactions (keyboard nav, drag handles, copy actions) paired with lightweight Kemal HTML fragment endpoints.",
          ["User pointer & keyboard events", "HTMX fragment requests"],
          ["Accessible DOM state", "Partial HTML swaps"],
          "public/js/apt-explainer.js + src/aptlantis.cr"
        ),
        DiagramNode.new(
          "explainer", "EX-04", "Explainer Platform", "TARGET APPLICATION", "UPCOMING",
          "Interactive exhibition explaining City Hall, Chromatic Atlas, and the Logos & Theming Pipeline using assembled components.",
          ["Proven gallery components", "Curated narrative & diagrams"],
          ["Interactive exhibition pages", "Inspectable downloadable artifacts"],
          "Phase C — Logos & Theming Pipeline Explainer"
        ),
      ]

      @theme_presets = [
        ThemePreset.new(
          "abyssal", "Abyssal Cyan", "Canonical Navigator-Architect HUD",
          "#031C28", "#00CAE3", "#F7BE4F",
          "[data-apt-theme=\"abyssal\"] {\n  --apt-bg-base: #00101A;\n  --apt-bg-raised: #031C28;\n  --apt-brand-primary: #00CAE3;\n  --apt-brand-secondary: #F7BE4F;\n}"
        ),
        ThemePreset.new(
          "citadel", "Solar Citadel", "Warm amber-led City Hall governance mode",
          "#1B140C", "#F7BE4F", "#23F2F7",
          "[data-apt-theme=\"citadel\"] {\n  --apt-bg-base: #120B05;\n  --apt-bg-raised: #1B140C;\n  --apt-bg-overlay: #2A1F13;\n  --apt-border-subtle: #71481D;\n  --apt-brand-primary: #F7BE4F;\n  --apt-brand-secondary: #23F2F7;\n}"
        ),
        ThemePreset.new(
          "pelagic", "Pelagic Slate", "Calm oceanic mist for long-form explainers",
          "#0B2532", "#18AAC2", "#FDEDB3",
          "[data-apt-theme=\"pelagic\"] {\n  --apt-bg-base: #071923;\n  --apt-bg-raised: #0B2532;\n  --apt-bg-overlay: #123647;\n  --apt-border-subtle: #1A4E63;\n  --apt-brand-primary: #18AAC2;\n  --apt-brand-secondary: #FDEDB3;\n}"
        ),
        ThemePreset.new(
          "daylight", "Chromatic Paper", "High-contrast light surface for print & reading",
          "#F4F7F8", "#00637D", "#A95403",
          "[data-apt-theme=\"daylight\"] {\n  --apt-bg-base: #E8F0F2;\n  --apt-bg-raised: #F4F7F8;\n  --apt-bg-overlay: #FFFFFF;\n  --apt-text-primary: #031C28;\n  --apt-text-secondary: #2C4854;\n  --apt-border-subtle: #A0B4B9;\n  --apt-brand-primary: #00637D;\n  --apt-brand-secondary: #A95403;\n}"
        ),
      ]

      @oklch_roles = [
        OklchRole.new("primary", "--apt-brand-primary", "Brand Primary", 0.77, 0.145, 204, "#00CAE3", "Interactive buttons, active indicators, primary telemetry lines, and links."),
        OklchRole.new("hover", "--apt-brand-primary-hover", "Bioluminescent Glow", 0.88, 0.148, 194, "#23F2F7", "Hover highlights, focus rings, active tab borders, and split handles."),
        OklchRole.new("secondary", "--apt-brand-secondary", "Solar Amber", 0.83, 0.142, 84, "#F7BE4F", "Governance callouts, stage badges, secondary chart series, and accent markers."),
        OklchRole.new("surface", "--apt-bg-raised", "Raised Oceanic Surface", 0.22, 0.042, 224, "#031C28", "Cards, inspector drawers, panels, and elevated HUD containers."),
        OklchRole.new("border", "--apt-border-interactive", "Interactive Border", 0.45, 0.088, 218, "#00637D", "Focused panels, diagram node outlines, and interactive control edges."),
        OklchRole.new("danger", "--apt-status-danger", "In-Palette Alert", 0.63, 0.145, 58, "#CF7818", "Destructive actions, drift warnings, and critical status alerts."),
      ]

      @artifacts = [
        ArtifactItem.new(
          "citadel-shield", "Aptlantis Citadel Shield", "Logos", "SVG", "2.4 KB",
          "DESIGN-FOUNDATION/logos/aptlantis-citadel-shield.svg",
          "Primary geometric brand emblem combining abyssal cyan hull geometry with a solar amber beacon core.",
          %(<img src="/icons/apt-citadel-shield.svg" alt="Aptlantis Citadel Shield" width="48" height="48" />),
          "aptlantis-citadel-shield.svg", "image/svg+xml",
          %(<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120"><polygon points="60,8 108,30 98,88 60,112 22,88 12,30" fill="#031C28" stroke="#00CAE3" stroke-width="3"/><polygon points="60,24 90,40 84,78 60,94 36,78 30,40" fill="#05303F" stroke="#F7BE4F" stroke-width="2"/><circle cx="60" cy="58" r="10" fill="#23F2F7"/><circle cx="60" cy="58" r="4" fill="#F7BE4F"/></svg>)
        ),
        ArtifactItem.new(
          "hud-sprite", "HUD Icon Sprite Sheet", "Icons", "SVG", "1.1 KB",
          "SANDBOX/design_system/part1/aptlantis-ui/public/icons/apt-hud-sprite.svg",
          "Inline symbol sprite powering the left navigation rail: Ledger, Gallery, Topology, and Search glyphs.",
          %(<svg width="18" height="18"><use href="/icons/apt-hud-sprite.svg#icon-gallery"/></svg>),
          "apt-hud-sprite-sample.svg", "image/svg+xml",
          %(<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#00CAE3" stroke-width="1.75"><rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5" stroke="#F7BE4F"/></svg>)
        ),
        ArtifactItem.new(
          "tokens-extended", "Extended OKLCH Token Sheet", "Tokens", "CSS", "3.8 KB",
          "SANDBOX/design_system/part1/aptlantis-ui/public/css/tokens-extended.css",
          "Canonical 32-color primitive ramp plus semantic surfaces, borders, brand accents, glows, and motion curves.",
          %(<link rel="stylesheet" href="/css/tokens-extended.css" />),
          "aptlantis-tokens-snippet.css", "text/css",
          ":root {\n  --apt-bg-base: #00101A;\n  --apt-bg-raised: #031C28;\n  --apt-brand-primary: #00CAE3;\n  --apt-brand-primary-hover: #23F2F7;\n  --apt-brand-secondary: #F7BE4F;\n  --apt-text-primary: #FDFDFB;\n}\n"
        ),
        ArtifactItem.new(
          "mermaid-theme", "Mermaid Topology Theme", "Diagrams", "JSON", "0.9 KB",
          "DESIGN-FOUNDATION/visuals_diagrams/mermaid-theme-builder",
          "Dark abyssal Mermaid theme variables matching Aptlantis surfaces, cyan edges, and JetBrains Mono labels.",
          %(mermaid.initialize({ theme: 'base', themeVariables: { primaryColor: '#05303F', primaryBorderColor: '#00CAE3' } });),
          "apt-mermaid-theme.json", "application/json",
          %({\n  "theme": "base",\n  "themeVariables": {\n    "fontFamily": "JetBrains Mono, monospace",\n    "primaryColor": "#05303F",\n    "primaryTextColor": "#FDFDFB",\n    "primaryBorderColor": "#00CAE3",\n    "lineColor": "#00637D",\n    "background": "#00101A"\n  }\n}\n)
        ),
        ArtifactItem.new(
          "website-palette", "Website Facet Palette", "Tokens", "TOML", "1.4 KB",
          "OTHER-FACETS/website/apt-logo-website-palette.toml",
          "Generated website facet palette mapping extracted logo colors to nav, hero, card, dialog, and table roles.",
          %(/* Import website facet tokens */\n@import "apt-logo-website.css";),
          "apt-website-palette.toml", "text/plain",
          "[palette]\nbackground = \"#031C28\"\npanel = \"#14252D\"\nprimary = \"#23F2F7\"\nsecondary = \"#BC8F81\"\nforeground = \"#FDFDFB\"\n"
        ),
        ArtifactItem.new(
          "telemetry-bars", "6-Series Data-Viz Palette", "Diagrams", "SVG", "1.9 KB",
          "OTHER-FACETS/data_visualization/apt-logo-data-visualization-bars.svg",
          "Alternating cyan, amber, muted teal, sand, ice, and rust-orange series calibrated for dark dashboards.",
          %(/* Chart tokens: --apt-chart-1 through --apt-chart-6 */\nstroke: var(--apt-chart-1);),
          "apt-6-series-bars.svg", "image/svg+xml",
          %(<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 180 80"><rect x="10" y="28" width="20" height="44" rx="3" fill="#00CAE3"/><rect x="38" y="16" width="20" height="56" rx="3" fill="#F7BE4F"/><rect x="66" y="34" width="20" height="38" rx="3" fill="#0380A1"/><rect x="94" y="22" width="20" height="50" rx="3" fill="#A29062"/><rect x="122" y="12" width="20" height="60" rx="3" fill="#A1FCFD"/><rect x="150" y="38" width="20" height="34" rx="3" fill="#CF7818"/></svg>)
        ),
      ]

      @timeline_events = [
        TimelineEvent.new(
          "v01", "v0.1", "FOUNDATION", "MILESTONE",
          "Brand Emblems & Facet Pipeline",
          "Extracted core Aptlantis hues from source vector artwork and fanned them out into Website, Markdown, SVG, Prism, and PowerPoint facets.",
          [
            "Established the Abyssal Cyan & Solar Amber visual identity.",
            "Generated validated palette TOML, token JSON, and CSS outputs."
          ],
          "OTHER-FACETS/website/apt-logo-website.css"
        ),
        TimelineEvent.new(
          "v10", "v1.0", "INFRASTRUCTURE", "RELEASE",
          "OKLCH 32-Token Calibration",
          "Standardized 32 perceptually uniform primitives (--apt-color-01..32) and mapped them to semantic surface, border, brand, and status tokens.",
          [
            "Eliminated hardcoded hex values across component stylesheets.",
            "Introduced @layer cascade architecture and unified keyboard focus rings."
          ],
          "public/css/tokens-extended.css"
        ),
        TimelineEvent.new(
          "v15", "v1.5", "VALIDATION", "RELEASE",
          "Crystal/Kemal + HTMX Telemetry HUD",
          "Built the working telemetry workspace exercising live tables, SSE heartbeats, Mermaid topology inspection, dialogs, and bulk actions.",
          [
            "Proved local-first, HTML-forward architecture without heavy JS frameworks.",
            "Validated zero-build CSS + small explicit Kemal HTML fragment endpoints."
          ],
          "SANDBOX/design_system/part1/aptlantis-ui"
        ),
        TimelineEvent.new(
          "v20", "v2.0", "CREATIVE PLATEAU", "PIVOT",
          "12-Component Gallery & Sandbox Shift",
          "Established an intentional complexity plateau—shifting focus from engineering infrastructure to crafting 12 polished, reusable interactive components.",
          [
            "Organized F:/ into 6 functional workspace segments.",
            "Built standalone specimens with variations, keyboard nav, and copyable source."
          ],
          "/components"
        ),
        TimelineEvent.new(
          "phase-c", "NEXT", "EXHIBITION", "UPCOMING",
          "Logos & Theming Pipeline Explainer",
          "Compose proven gallery components into an interactive exhibition explaining Aptlantis City Hall, Chromatic Atlas, and the Logos Pipeline.",
          [
            "Real-world composition test using actual gallery pieces.",
            "Refines component ergonomics through practical use before library promotion."
          ],
          "Phase C — Explainer Demonstration"
        ),
      ]

      @decision_nodes = [
        DecisionNode.new(
          "start", "QUESTION 01", "What are you building right now?",
          "Pick the closest description of your current task to route it cleanly inside the 6-segment Aptlantis workspace.",
          [
            DecisionChoice.new("A new reusable UI component", "Interactive piece for dashboards, docs, or explainers", "component-backend"),
            DecisionChoice.new("An interactive system explanation", "Walkthrough for City Hall, Chromatic Atlas, or Logos", "explainer-scope"),
            DecisionChoice.new("A quick visual or CSS experiment", "Unproven idea you want to test without ceremony", "outcome-sandbox"),
          ]
        ),
        DecisionNode.new(
          "component-backend", "QUESTION 02", "Does this component need server-returned HTML?",
          "Prefer pure HTML/CSS/JS by default. Reach for a Kemal/HTMX endpoint only when server fragments meaningfully demonstrate the interaction.",
          [
            DecisionChoice.new("No — purely client-side visual or state", "Sliders, comparisons, theme previews, disclosures", "outcome-static-component"),
            DecisionChoice.new("Yes — dynamic fragment loading", "Inspectors, branching flows, filtered panels", "outcome-htmx-component"),
          ]
        ),
        DecisionNode.new(
          "explainer-scope", "QUESTION 02", "Are the needed components already in the Gallery?",
          "The explainer platform is designed to assemble real components rather than hand-coding one-off layouts.",
          [
            DecisionChoice.new("Yes — compose existing specimens", "Stepper, Explanation Panel, Diagram Inspector, Spotlight", "outcome-compose-explainer"),
            DecisionChoice.new("Not yet — missing an interaction pattern", "Need a new visual or interactive building block first", "component-backend"),
          ]
        ),
        DecisionNode.new(
          "outcome-sandbox", "RECOMMENDATION", "Prototype freely in SANDBOX",
          "Keep it lightweight and fun—no governance ceremony, no schema changes, and no pressure to make it production-ready yet.",
          [] of DecisionChoice,
          "SANDBOX EXPERIMENT",
          [
            "Create a small standalone HTML or ECR specimen inside F:/SANDBOX.",
            "Reuse tokens-extended.css so it looks like Aptlantis immediately.",
            "Discard freely or promote later once its usefulness is obvious."
          ]
        ),
        DecisionNode.new(
          "outcome-static-component", "RECOMMENDATION", "Build a Zero-Backend HTML/CSS/JS Specimen",
          "Craft an independent, copyable component using canonical Aptlantis tokens and minimal vanilla JS in apt-explainer.js.",
          [] of DecisionChoice,
          "PORTABLE COMPONENT",
          [
            "Use semantic CSS variables (--apt-bg-raised, --apt-brand-primary, etc.).",
            "Include keyboard navigation, focus states, and at least one variation.",
            "Add a copyable usage snippet so it drops cleanly into any HTML page."
          ]
        ),
        DecisionNode.new(
          "outcome-htmx-component", "RECOMMENDATION", "Pair HTML Specimen with a Small Kemal Fragment Route",
          "Keep the markup HTML-first and add one explicit Kemal GET endpoint returning a focused ECR partial.",
          [] of DecisionChoice,
          "HTMX FRAGMENT COMPONENT",
          [
            "Add one narrow route in src/aptlantis.cr returning an ECR partial.",
            "Render the initial state server-side so the page works immediately on load.",
            "Avoid adding databases or frameworks unless the behavior truly requires them."
          ]
        ),
        DecisionNode.new(
          "outcome-compose-explainer", "RECOMMENDATION", "Assemble a Phase C Explainer Page",
          "Combine 3–5 live components from the Gallery to tell a clear, visual story about the Logos & Theming Pipeline.",
          [] of DecisionChoice,
          "EXHIBITION COMPOSITION",
          [
            "Lead with a Feature Spotlight to orient visitors quickly.",
            "Use Process Stepper + Diagram Inspector for interactive exploration.",
            "Finish with Artifact Gallery so visitors can inspect and download real outputs."
          ]
        ),
      ]
    end

    def find(slug : String) : ComponentSpec?
      @items.find { |item| item.slug == slug }
    end

    def find_stage(index : Int32) : StepperStage?
      @stepper_stages.find { |s| s.index == index }
    end

    def find_depth(key : String) : ExplanationDepth?
      @explanation_depths.find { |d| d.key == key }
    end

    def find_diagram_node(id : String) : DiagramNode?
      @diagram_nodes.find { |n| n.id == id }
    end

    def find_oklch_role(key : String) : OklchRole?
      @oklch_roles.find { |r| r.key == key }
    end

    def find_artifact(id : String) : ArtifactItem?
      @artifacts.find { |a| a.id == id }
    end

    def find_timeline_event(id : String) : TimelineEvent?
      @timeline_events.find { |e| e.id == id }
    end

    def find_decision_node(id : String) : DecisionNode?
      @decision_nodes.find { |n| n.id == id }
    end
  end
end
