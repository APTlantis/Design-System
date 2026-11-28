module Aptlantis
  struct SkillNodeInfo
    getter id : String
    getter short_label : String
    getter subtitle : String
    getter role : String # "gov", "visual", "eng", "doc"
    getter class_name : String
    getter active : Bool
    getter purpose : String
    getter boundaries : String
    getter archive_path : String

    def initialize(
      @id : String,
      @short_label : String,
      @subtitle : String,
      @role : String,
      @class_name : String,
      @active : Bool,
      @purpose : String,
      @boundaries : String,
      @archive_path : String
    )
    end
  end

  struct SkillLens
    getter id : String
    getter label : String
    getter badge : String
    getter headline : String
    getter description : String
    getter default_node_id : String
    getter mermaid_source : String

    def initialize(
      @id : String,
      @label : String,
      @badge : String,
      @headline : String,
      @description : String,
      @default_node_id : String,
      @mermaid_source : String
    )
    end
  end

  class SkillsTopology
    getter skills : Hash(String, SkillNodeInfo)
    getter lenses : Array(SkillLens)
    getter mermaid_json : String
    getter class_defs : String

    def initialize
      @skills = {} of String => SkillNodeInfo

      add_skill(
        "skill-synthesis-engine", "skill-synthesis-engine", "Meta-Skill Authoring",
        "doc", "docNode", false,
        "Research, evaluate, synthesize, create, and improve reusable SKILL.md packages with evidence tracking and behavioral checks.",
        "Use when authoring or refining skills—not for executing domain tasks directly.",
        "Y:\\AGENT SKILLS\\Created\\skill-synthesis-engine"
      )
      add_skill(
        "hub-city-hall", "City Hall Suite (5)", "Governance & Standards",
        "gov", "govNode", true,
        "5 active governance skills anchored by city-hall: project formation (PPS), project governance, review/audit, and standards maintenance (SFDS/WGS).",
        "Switch to the 'City Hall Routing' lens to inspect individual governance handoffs without clutter.",
        "Y:\\AGENT SKILLS\\Created\\city-hall*"
      )
      add_skill(
        "hub-visual", "Visual & Brand (6)", "Tokens, SVG, Mermaid, Charts",
        "visual", "visualNode", false,
        "6 visual engineering skills turning Logos-And-Theming runs into design systems, SVGs, Mermaid diagrams, and Chart.js visualizations.",
        "Switch to the 'Visual & Docs' lens to see how brand manifests feed each visual specialist.",
        "Y:\\AGENT SKILLS\\Created\\pipeline-brand-*"
      )
      add_skill(
        "hub-engineering", "Engineering & Media (8)", "Rust/Tauri, Data, CLI, Media",
        "eng", "engNode", false,
        "8 local toolchain specialists covering Rust/Tauri apps, desktop installers, PowerShell, DuckDB/SQLite, local AI retrieval, FFmpeg, ImageMagick, and repo archaeology.",
        "Switch to the 'Engineering & Media' lens to inspect each specialist's boundaries.",
        "Y:\\AGENT SKILLS\\Created\\*-engineer"
      )
      add_skill(
        "hub-docs", "Docs & Publishing (4)", "AsciiDoc, Pandoc, Mirrors, Sites",
        "doc", "docNode", false,
        "4 documentation specialists covering AsciiDoc authoring, Pandoc transforms, bounded web mirroring, and static doc sites (Starlight/Docusaurus/MkDocs).",
        "Excludes unrelated web-app development and ordinary web browsing.",
        "Y:\\AGENT SKILLS\\Created\\documentation-*"
      )

      # City Hall 5 (ACTIVE in .gemini/config/skills)
      add_skill(
        "city-hall", "city-hall", "Orientation & Router",
        "gov", "govNode", true,
        "Orient and route City Hall or Aptlantis governance work using adopted authority, project records, and bundled standards.",
        "Exclude unrelated coding and general project-management advice.",
        "Y:\\AGENT SKILLS\\Created\\city-hall"
      )
      add_skill(
        "city-hall-project-formation", "project-formation", "Intent, Scope & PPS",
        "gov", "govNode", true,
        "Develop rough ideas, revivals, and substantial scope changes into accurate City Hall project definitions and PPS packages.",
        "Exclude routine bug fixes, release certification, and unsolicited implementation.",
        "Y:\\AGENT SKILLS\\Created\\city-hall-project-formation"
      )
      add_skill(
        "city-hall-project-governance", "project-governance", "Onboarding & Closeout",
        "gov", "govNode", true,
        "Apply City Hall standards during authorized onboarding, revival, and existing-project changes including records, validation, and closeout.",
        "Exclude unrelated coding, standards authoring, and review-only requests.",
        "Y:\\AGENT SKILLS\\Created\\city-hall-project-governance"
      )
      add_skill(
        "city-hall-governance-review", "governance-review", "Conformance & Evidence",
        "gov", "govNode", true,
        "Review governed projects, releases, records, and standard suites against adopted requirements and inspectable evidence.",
        "Separate target blockers from future improvements; exclude unsolicited repairs.",
        "Y:\\AGENT SKILLS\\Created\\city-hall-governance-review"
      )
      add_skill(
        "city-hall-standards-maintenance", "standards-maint", "SFDS & WGS Authority",
        "gov", "govNode", true,
        "Develop, revise, and reconcile City Hall standards, templates, schemas, and governance authority using SFDS and WGS.",
        "Exclude ordinary governed-project edits and automatic policy promotion.",
        "Y:\\AGENT SKILLS\\Created\\city-hall-standards-maintenance"
      )

      # Visual, Brand & Docs
      add_skill(
        "pipeline-brand-system", "pipeline-brand-system", "Brand Identity & Lineage",
        "visual", "visualNode", false,
        "Turn Logos-And-Theming output runs into coherent brand manuals, identity kits, design tokens, and cross-app handoffs.",
        "Excludes theme regeneration, isolated fixes, and automatic installation.",
        "Y:\\AGENT SKILLS\\Created\\pipeline-brand-system"
      )
      add_skill(
        "pipeline-brand-generator", "pipeline-brand-gen", "OKLCH Token Generator",
        "visual", "visualNode", false,
        "Generate developer-ready design tokens from palette.toml, evaluating OKLCH dynamics, WCAG contrast, typography, elevation, and motion.",
        "Operates on pipeline-produced palette.toml manifests.",
        "Y:\\AGENT SKILLS\\Created\\pipeline-brand-generator"
      )
      add_skill(
        "visual-engineering-architect", "visual-eng-architect", "Rendering Router",
        "visual", "visualNode", false,
        "Select and coordinate diagram, chart, graph, and vector technologies based on meaning, interaction, scale, and delivery needs.",
        "Prefer the named Mermaid, Chart.js, or SVG specialist for straightforward single-tool work.",
        "Y:\\AGENT SKILLS\\Created\\visual-engineering-architect"
      )
      add_skill(
        "svg-creator", "svg-creator", "Editable Vector Craft",
        "visual", "visualNode", false,
        "Create, edit, and refine editable SVG icons, logos, illustrations, patterns, and diagrams with structural and accessibility checks.",
        "Do not use for photorealistic raster generation or simple PNG conversion.",
        "Y:\\AGENT SKILLS\\Created\\svg-creator"
      )
      add_skill(
        "mermaid-diagrams", "mermaid-diagrams", "Mermaid Source & Themes",
        "visual", "visualNode", false,
        "Create, edit, debug, and theme Mermaid.js flowcharts, sequence, state, class, ER, and Gantt diagrams.",
        "Do not use for arbitrary SVG illustration or quantitative charts.",
        "Y:\\AGENT SKILLS\\Created\\mermaid-diagrams"
      )
      add_skill(
        "chartjs-charts", "chartjs-charts", "Canvas Data Charts",
        "visual", "visualNode", false,
        "Create, style, integrate, and validate Chart.js canvas charts, scales, tooltips, legends, plugins, and image exports.",
        "Do not use for generic data analysis without Chart.js or arbitrary SVG artwork.",
        "Y:\\AGENT SKILLS\\Created\\chartjs-charts"
      )
      add_skill(
        "asciidoc-docs", "asciidoc-docs", "AsciiDoc & Antora",
        "doc", "docNode", false,
        "Write, edit, migrate, and validate AsciiDoc (.adoc) technical documentation for Asciidoctor HTML/PDF and Antora sites.",
        "Use dedicated workflows for ASCII art or character encoding.",
        "Y:\\AGENT SKILLS\\Created\\asciidoc-docs"
      )
      add_skill(
        "pandoc-document-engineer", "pandoc-doc-eng", "Format Transforms",
        "doc", "docNode", false,
        "Engineer Pandoc format conversions, templates, reference docs, citations, and Lua filters with explicit fidelity checks.",
        "Exclude website crawling and documentation-site architecture.",
        "Y:\\AGENT SKILLS\\Created\\pandoc-document-engineer"
      )
      add_skill(
        "documentation-ingestion-mirroring", "doc-ingestion", "Bounded Mirrors",
        "doc", "docNode", false,
        "Acquire and refresh bounded documentation collections with provenance, asset capture, local links, and offline integrity checks.",
        "Exclude ordinary browsing, single-page reading, and site design.",
        "Y:\\AGENT SKILLS\\Created\\documentation-ingestion-mirroring"
      )
      add_skill(
        "documentation-site-engineer", "doc-site-engineer", "Static Doc Sites",
        "doc", "docNode", false,
        "Build, restructure, and debug Starlight, Docusaurus, MkDocs, Material, or AsciiDoc publishing sites.",
        "Exclude standalone format conversion and unrelated web apps.",
        "Y:\\AGENT SKILLS\\Created\\documentation-site-engineer"
      )

      # Local Engineering, Media & Data
      add_skill(
        "repository-archaeologist", "repo-archaeologist", "Read-Only Recon",
        "eng", "engNode", false,
        "Reconstruct an unfamiliar repository's entrypoints, runtime flow, dependencies, conventions, and change impact from source evidence.",
        "Read-only reconnaissance; exclude simple edits where context is already known.",
        "Y:\\AGENT SKILLS\\Created\\repository-archaeologist"
      )
      add_skill(
        "rust-tauri-app-architect", "rust-tauri-architect", "Desktop Apps & IPC",
        "eng", "engNode", false,
        "Design, extend, and troubleshoot Rust/Tauri desktop applications including IPC, state, capabilities, persistence, and native processes.",
        "Exclude general Rust tasks and installer-only release work.",
        "Y:\\AGENT SKILLS\\Created\\rust-tauri-app-architect"
      )
      add_skill(
        "desktop-release-installer-engineer", "desktop-release-eng", "Installers & Checksums",
        "eng", "engNode", false,
        "Prepare, build, inspect, and validate desktop distributables, installer targets, signing evidence, checksums, and release receipts.",
        "Exclude ordinary application development without packaging work.",
        "Y:\\AGENT SKILLS\\Created\\desktop-release-installer-engineer"
      )
      add_skill(
        "powershell-automation-engineer", "powershell-auto-eng", "PS7 Scripts & Modules",
        "eng", "engNode", false,
        "Build, review, and troubleshoot PowerShell 7 scripts, advanced functions, modules, and safe repeatable automation.",
        "Exclude tasks that merely invoke a PowerShell command while another specialist owns the work.",
        "Y:\\AGENT SKILLS\\Created\\powershell-automation-engineer"
      )
      add_skill(
        "duckdb-sqlite-data-engineer", "duckdb-sqlite-eng", "Local SQL Engines",
        "eng", "engNode", false,
        "Design and troubleshoot local DuckDB and SQLite schemas, ingestion, migrations, query performance, backup, and integrity.",
        "Exclude general SQL teaching and retrieval relevance design.",
        "Y:\\AGENT SKILLS\\Created\\duckdb-sqlite-data-engineer"
      )
      add_skill(
        "local-ai-retrieval-engineer", "local-ai-retrieval", "Ollama & Hybrid RAG",
        "eng", "engNode", false,
        "Build and evaluate local model integrations and retrieval systems including Ollama, embeddings, chunking, hybrid search, and citations.",
        "Exclude general AI discussion and database-only engineering.",
        "Y:\\AGENT SKILLS\\Created\\local-ai-retrieval-engineer"
      )
      add_skill(
        "ffmpeg-media-engineer", "ffmpeg-media-eng", "Audio/Video Pipelines",
        "eng", "engNode", false,
        "Inspect, transform, and troubleshoot media with FFmpeg and FFprobe: stream mapping, remuxing, transcoding, filters, and subtitles.",
        "Exclude media-player selection and ordinary file copying.",
        "Y:\\AGENT SKILLS\\Created\\ffmpeg-media-engineer"
      )
      add_skill(
        "imagemagick-imaging-engineer", "imagemagick-eng", "Raster CLI Imaging",
        "eng", "engNode", false,
        "Inspect and process images with ImageMagick 7: geometry, alpha, compositing, palettes, animation, and batch verification.",
        "Exclude brand identity decisions and vector illustration.",
        "Y:\\AGENT SKILLS\\Created\\imagemagick-imaging-engineer"
      )

      @lenses = [
        SkillLens.new(
          "ecosystem", "01 · Ecosystem Overview", "5 HUBS · 24 SKILLS",
          "Agent Skills Ecosystem — Domain Hubs & Meta-Synthesis",
          "High-level view grouping all 24 archived skills into 4 clean domains so you can orient quickly before zooming into dense clusters like City Hall.",
          "hub-city-hall",
          <<-'MMD'
flowchart LR
  SYN["skill-synthesis-engine<br/>Meta-Skill Authoring"]:::docNode
  CH["City Hall Suite (5)<br/>Active Governance"]:::govNode
  VIS["Visual &amp; Brand (6)<br/>Tokens · SVG · Mermaid"]:::visualNode
  ENG["Engineering &amp; Media (8)<br/>Rust · Data · CLI"]:::engNode
  DOC["Docs &amp; Publishing (4)<br/>AsciiDoc · Pandoc · Sites"]:::docNode

  SYN -->|synthesize| CH
  SYN -->|synthesize| VIS
  SYN -->|synthesize| ENG
  SYN -->|synthesize| DOC
  CH -.->|standards| ENG
  VIS -->|assets| DOC
MMD
        ),
        SkillLens.new(
          "city-hall", "02 · City Hall Routing", "5 ACTIVE SKILLS",
          "City Hall Governance Suite — Orientation, Execution & Review",
          "Dedicated lens for the densest cluster: city-hall acts as the single orientation router fanning out to formation, execution, review, and standards maintenance.",
          "city-hall",
          <<-'MMD'
flowchart LR
  CH["city-hall<br/>Orient &amp; Route"]:::govNode
  FORM["city-hall-project-formation<br/>Intent · Scope · PPS"]:::govNode
  GOV["city-hall-project-governance<br/>Onboard · Records · Closeout"]:::govNode
  REV["city-hall-governance-review<br/>Conformance · Evidence"]:::govNode
  STD["city-hall-standards-maintenance<br/>SFDS · WGS Authority"]:::govNode

  CH -->|rough idea| FORM
  FORM -->|PPS| GOV
  CH -->|authorized work| GOV
  GOV -->|evidence| REV
  CH -->|audit| REV
  CH -->|authority| STD
  STD -.->|standards| GOV
MMD
        ),
        SkillLens.new(
          "visual-docs", "03 · Visual, Brand & Docs", "10 SKILLS",
          "Brand Pipeline → Visual Specialists → Documentation Outputs",
          "Shows how Logos-And-Theming manifests flow into OKLCH tokens, vector/diagram specialists, and multi-format documentation publishers.",
          "visual-engineering-architect",
          <<-'MMD'
flowchart LR
  PBS["pipeline-brand-system<br/>Brand Lineage"]:::visualNode
  PBG["pipeline-brand-generator<br/>OKLCH Tokens"]:::visualNode
  VEA["visual-engineering-architect<br/>Rendering Router"]:::visualNode
  SVG["svg-creator<br/>Vectors"]:::visualNode
  MMD["mermaid-diagrams<br/>Diagrams"]:::visualNode
  CJS["chartjs-charts<br/>Charts"]:::visualNode
  ADOC["asciidoc-docs<br/>AsciiDoc"]:::docNode
  PAN["pandoc-document-engineer<br/>Transforms"]:::docNode
  ING["doc-ingestion-mirroring<br/>Mirrors"]:::docNode
  SITE["doc-site-engineer<br/>Doc Sites"]:::docNode

  PBS --> PBG
  PBG -->|tokens| VEA
  VEA --> SVG
  VEA --> MMD
  VEA --> CJS
  ING -->|sources| ADOC
  ADOC --> SITE
  PAN --> SITE
  SVG -.->|assets| SITE
MMD
        ),
        SkillLens.new(
          "engineering", "04 · Engineering & Media", "8 SKILLS",
          "Local Engineering, Desktop Release, Data & Media Toolchains",
          "Read-only repo archaeology and PowerShell automation feeding Rust/Tauri desktop delivery, local SQL/AI retrieval, and FFmpeg/ImageMagick media pipelines.",
          "rust-tauri-app-architect",
          <<-'MMD'
flowchart LR
  ARC["repository-archaeologist<br/>Read-Only Recon"]:::engNode
  PS["powershell-automation-engineer<br/>PS7 Automation"]:::engNode
  TAURI["rust-tauri-app-architect<br/>Desktop App &amp; IPC"]:::engNode
  REL["desktop-release-installer<br/>Installers &amp; Checksums"]:::engNode
  DB["duckdb-sqlite-data-engineer<br/>Local SQL"]:::engNode
  RAG["local-ai-retrieval-engineer<br/>Ollama &amp; RAG"]:::engNode
  FFM["ffmpeg-media-engineer<br/>Audio / Video"]:::engNode
  IMG["imagemagick-imaging-engineer<br/>Raster CLI"]:::engNode

  ARC -->|context| TAURI
  TAURI -->|build| REL
  PS -->|orchestrate| REL
  DB -->|index| RAG
  FFM -.->|frames| IMG
MMD
        ),
      ]

      @mermaid_json = <<-'JSON'
{
  "theme": "base",
  "themeVariables": {
    "darkMode": true,
    "background": "#031C28",
    "fontFamily": "Inter, Space Grotesk, sans-serif",
    "fontSize": "14px",
    "primaryColor": "#14252D",
    "primaryTextColor": "#FDFDFB",
    "primaryBorderColor": "#23F2F7",
    "secondaryColor": "#1E2F38",
    "secondaryTextColor": "#CFD0C9",
    "secondaryBorderColor": "#BC8F81",
    "lineColor": "#86A0A9",
    "edgeLabelBackground": "#031C28",
    "clusterBkg": "#00101A",
    "clusterBorder": "#07455E"
  }
}
JSON

      @class_defs = <<-'CLASSDEF'
classDef govNode    fill:#14252D,stroke:#F7BE4F,stroke-width:2px,color:#FDFDFB;
classDef visualNode fill:#14252D,stroke:#23F2F7,stroke-width:2px,color:#FDFDFB;
classDef engNode    fill:#14252D,stroke:#00CAE3,stroke-width:2px,color:#FDFDFB;
classDef docNode    fill:#1E2F38,stroke:#BC8F81,stroke-width:2px,color:#FDFDFB;
CLASSDEF
    end

    private def add_skill(
      id : String,
      short_label : String,
      subtitle : String,
      role : String,
      class_name : String,
      active : Bool,
      purpose : String,
      boundaries : String,
      archive_path : String
    )
      @skills[id] = SkillNodeInfo.new(
        id, short_label, subtitle, role, class_name, active, purpose, boundaries, archive_path
      )
    end

    def find_lens(id : String) : SkillLens?
      @lenses.find { |l| l.id == id }
    end

    def find_skill(id : String) : SkillNodeInfo?
      @skills[id]?
    end
  end
end
