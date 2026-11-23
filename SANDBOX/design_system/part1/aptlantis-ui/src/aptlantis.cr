require "kemal"
require "ecr"
require "html"
require "./models/node"
require "./models/components"

STORE   = Aptlantis::Store.new
CATALOG = Aptlantis::ComponentCatalog.new

# Helper to render an ECR partial cleanly into a String
macro render_partial(path, **locals)
  String.build do |io|
    {% for k, v in locals %}
      {% unless k.id.stringify == v.stringify %}
        {{k.id}} = {{v}}
      {% end %}
    {% end %}
    ECR.embed("src/views/partials/{{path.id}}.ecr", io)
  end
end

# 1. Full Workspace Shell
get "/" do
  active_nav = "telemetry"
  topbar_label = "KEMAL TELEMETRY WORKSPACE"
  nodes = STORE.nodes
  render "src/views/workspace.ecr", "src/views/layout.ecr"
end

# 1b. Phase A — Component Gallery Index
get "/components" do
  active_nav = "gallery"
  topbar_label = "COMPONENT GALLERY"
  components = CATALOG.items
  render "src/views/gallery.ecr", "src/views/layout.ecr"
end

# 1c. Phase B — Individual Component Specimens
get "/components/process-stepper" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 01 PROCESS STEPPER"
  spec = CATALOG.find("process-stepper").not_nil!
  stages = CATALOG.stepper_stages
  render "src/views/components/process_stepper.ecr", "src/views/layout.ecr"
end

get "/components/process-stepper/stage/:index" do |env|
  idx = env.params.url["index"].to_i? || 1
  if stage = CATALOG.find_stage(idx)
    render_partial("_stepper_stage", stage: stage)
  else
    halt env, status_code: 404, response: "Stage not found"
  end
end

get "/components/explanation-panel" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 02 EXPLANATION PANEL"
  spec = CATALOG.find("explanation-panel").not_nil!
  depths = CATALOG.explanation_depths
  render "src/views/components/explanation_panel.ecr", "src/views/layout.ecr"
end

get "/components/explanation-panel/depth/:level" do |env|
  level = env.params.url["level"]
  if depth = CATALOG.find_depth(level)
    render_partial("_explanation_depth", depth: depth)
  else
    halt env, status_code: 404, response: "Depth level not found"
  end
end

get "/components/diagram-inspector" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 03 DIAGRAM INSPECTOR"
  spec = CATALOG.find("diagram-inspector").not_nil!
  nodes = CATALOG.diagram_nodes
  render "src/views/components/diagram_inspector.ecr", "src/views/layout.ecr"
end

get "/components/diagram-inspector/node/:id" do |env|
  id = env.params.url["id"]
  if node = CATALOG.find_diagram_node(id)
    render_partial("_diagram_node", node: node)
  else
    halt env, status_code: 404, response: "Diagram node not found"
  end
end

get "/components/before-after" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 04 BEFORE / AFTER"
  spec = CATALOG.find("before-after").not_nil!
  render "src/views/components/before_after.ecr", "src/views/layout.ecr"
end

get "/components/theme-switcher" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 05 THEME SWITCHER"
  spec = CATALOG.find("theme-switcher").not_nil!
  presets = CATALOG.theme_presets
  render "src/views/components/theme_switcher.ecr", "src/views/layout.ecr"
end

get "/components/oklch-explorer" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 06 OKLCH EXPLORER"
  spec = CATALOG.find("oklch-explorer").not_nil!
  roles = CATALOG.oklch_roles
  render "src/views/components/oklch_explorer.ecr", "src/views/layout.ecr"
end

get "/components/oklch-explorer/role/:key" do |env|
  key = env.params.url["key"]
  if role = CATALOG.find_oklch_role(key)
    render_partial("_oklch_role", role: role)
  else
    halt env, status_code: 404, response: "Role not found"
  end
end

get "/components/artifact-gallery" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 07 ARTIFACT GALLERY"
  spec = CATALOG.find("artifact-gallery").not_nil!
  artifacts = CATALOG.artifacts
  render "src/views/components/artifact_gallery.ecr", "src/views/layout.ecr"
end

get "/components/artifact-gallery/item/:id" do |env|
  id = env.params.url["id"]
  if artifact = CATALOG.find_artifact(id)
    render_partial("_artifact_detail", artifact: artifact)
  else
    halt env, status_code: 404, response: "Artifact not found"
  end
end

get "/components/artifact-gallery/download/:id" do |env|
  id = env.params.url["id"]
  if artifact = CATALOG.find_artifact(id)
    env.response.content_type = artifact.download_mime
    env.response.headers["Content-Disposition"] = %(attachment; filename="#{artifact.download_filename}")
    artifact.download_body
  else
    halt env, status_code: 404, response: "Artifact not found"
  end
end

get "/components/feature-spotlight" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 08 FEATURE SPOTLIGHT"
  spec = CATALOG.find("feature-spotlight").not_nil!
  render "src/views/components/feature_spotlight.ecr", "src/views/layout.ecr"
end

get "/components/interactive-timeline" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 09 INTERACTIVE TIMELINE"
  spec = CATALOG.find("interactive-timeline").not_nil!
  events = CATALOG.timeline_events
  render "src/views/components/interactive_timeline.ecr", "src/views/layout.ecr"
end

get "/components/interactive-timeline/event/:id" do |env|
  id = env.params.url["id"]
  if event = CATALOG.find_timeline_event(id)
    render_partial("_timeline_event", event: event)
  else
    halt env, status_code: 404, response: "Timeline event not found"
  end
end

get "/components/code-output-viewer" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 10 CODE & OUTPUT VIEWER"
  spec = CATALOG.find("code-output-viewer").not_nil!
  render "src/views/components/code_output_viewer.ecr", "src/views/layout.ecr"
end

get "/components/decision-explorer" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 11 GUIDED DECISION EXPLORER"
  spec = CATALOG.find("decision-explorer").not_nil!
  start_node = CATALOG.find_decision_node("start").not_nil!
  render "src/views/components/decision_explorer.ecr", "src/views/layout.ecr"
end

get "/components/decision-explorer/step/:id" do |env|
  id = env.params.url["id"]
  if node = CATALOG.find_decision_node(id)
    render_partial("_decision_step", node: node)
  else
    halt env, status_code: 404, response: "Decision step not found"
  end
end

get "/components/component-playground" do
  active_nav = "gallery"
  topbar_label = "GALLERY / 12 COMPONENT PLAYGROUND"
  spec = CATALOG.find("component-playground").not_nil!
  render "src/views/components/component_playground.ecr", "src/views/layout.ecr"
end

# 2. Filter Ledger Rows (Sector Popover Menu)
get "/telemetry" do |env|
  sector = env.params.query["sector"]? || "ALL"
  nodes = STORE.filter(sector)

  rows = nodes.map { |node| render_partial("_ledger_row", node: node) }.join
  counter = %(<span id="row-counter" hx-swap-oob="true" class="apt-mono" style="font-size:0.75rem; color:var(--apt-text-secondary);">#{nodes.size} NODES SHOWN</span>)

  rows + counter
end

# 3. Populate Right-Hand Inspector Drawer (#apt-inspector)
get "/nodes/:id" do |env|
  id = env.params.url["id"]
  if node = STORE.find(id)
    render_partial("_inspector", node: node)
  else
    env.response.status_code = 404
    render_partial("_toast", tone: "danger", message: "Node '#{HTML.escape(id)}' not found.")
  end
end

# 4. Verify Node Digest from Inspector + OOB Toast
post "/nodes/:id/verify" do |env|
  id = env.params.url["id"]
  if node = STORE.find(id)
    inspector = render_partial("_inspector", node: node)
    toast = render_partial("_toast", tone: "success", message: "Re-verified #{node.hostname} SHA-256 digest.")
    inspector + toast
  else
    halt env, status_code: 404
  end
end

# 5. Dispatch New Release Contract (<dialog> form -> prepend row + OOB counter + OOB toast)
post "/contracts/dispatch" do |env|
  hostname = env.params.body["node"]?.to_s.strip
  contract = env.params.body["contract"]?.to_s.strip
  next render_partial("_toast", tone: "danger", message: "Hostname is required.") if hostname.empty?

  new_id = (STORE.nodes.size + 1).to_s.rjust(2, '0')
  node = Aptlantis::TelemetryNode.new(new_id, hostname, contract, "VERIFIED", 10.1, "Newly dispatched contract node.")
  STORE.nodes.unshift(node)

  row = render_partial("_ledger_row", node: node)
  counter = %(<span id="row-counter" hx-swap-oob="true" class="apt-mono" style="font-size:0.75rem; color:var(--apt-text-secondary);">#{STORE.nodes.size} NODES ONLINE</span>)
  toast = render_partial("_toast", tone: "success", message: "Dispatched #{contract} to #{hostname}.")

  row + counter + toast
end

# 6. Server-Driven Multi-Row Selection -> OOB Bulk Action Toolbar
post "/telemetry/selection" do |env|
  selected_ids = env.params.body.fetch_all("ids")
  render_partial("_bulk_bar", count: selected_ids.size)
end

# 7. Bulk Action Execution -> Hide Bulk Bar + Push OOB Toast
post "/telemetry/bulk-action" do |env|
  action = env.params.body["action"]? || "Processed"
  selected_ids = env.params.body.fetch_all("ids")

  bulk_bar = render_partial("_bulk_bar", count: 0)
  toast = render_partial("_toast", tone: "success", message: "#{HTML.escape(action)} #{selected_ids.size} selected node(s).")

  bulk_bar + toast
end

# 8. Refresh Mermaid Topology Graph
get "/topology/refresh" do
  <<-MERMAID
  flowchart LR
    02["WGS · Governance Quorum"]:::govNode --> 01["DRS · Deterministic Release"]:::releaseNode
    01 --> 03["CTS · Telemetry Ledger"]:::auditNode
    01 --> 04["apt-edge-04.pelagic"]:::releaseNode

    classDef govNode fill:#031C28,stroke:#F7BE4F,stroke-width:1.5px,color:#FDFDFB;
    classDef releaseNode fill:#05303F,stroke:#00CAE3,stroke-width:1.5px,color:#FDFDFB;
    classDef auditNode fill:#00101A,stroke:#A29062,stroke-width:1.5px,color:#FDFDFB;
  MERMAID
end

# 9. Server-Sent Events (SSE) Live Telemetry Heartbeat
get "/stream" do |env|
  env.response.content_type = "text/event-stream"
  env.response.headers["Cache-Control"] = "no-cache"
  env.response.headers["Connection"] = "keep-alive"

  loop do
    break if env.response.closed?
    latency = (9.0 + rand * 4.5).round(1)
    env.response.print("event: heartbeat\n")
    env.response.print("data: STREAM: ACTIVE · #{latency} ms\n\n")
    env.response.flush
    sleep 2.5.seconds
  end
end

Kemal.run
