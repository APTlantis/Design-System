require "digest/sha256"

module Aptlantis
  struct TelemetryNode
    property id : String
    property hostname : String
    property contract : String
    property status : String
    property latency_ms : Float64
    property digest : String
    property notes : String

    def initialize(@id, @hostname, @contract, @status, @latency_ms, @notes)
      @digest = Digest::SHA256.hexdigest("#{hostname}:#{contract}:#{Time.utc.to_unix}")[0, 16]
    end

    def tone : String
      case contract
      when .starts_with?("DRS") then "cyan"
      when .starts_with?("CTS") then "amber"
      else ""
      end
    end
  end

  class Store
    getter nodes : Array(TelemetryNode)

    def initialize
      @nodes = [
        TelemetryNode.new("01", "apt-node-01.abyssal", "DRS · v2.4", "VERIFIED", 11.4, "Nominal oceanic ingress; zero packet loss over 24h."),
        TelemetryNode.new("02", "apt-gov-02.hadal", "WGS · v2.0", "VERIFIED", 14.8, "Governance quorum signer active; 6/6 keys attested."),
        TelemetryNode.new("03", "apt-telemetry-03.trench", "CTS · v1.9", "DEGRADED", 28.1, "Elevated queue depth on ingestion worker #4."),
        TelemetryNode.new("04", "apt-edge-04.pelagic", "DRS · v2.4", "VERIFIED", 9.2, "Edge cache warm; serving 14.2k req/s."),
      ]
    end

    def find(id : String) : TelemetryNode?
      @nodes.find { |n| n.id == id || n.hostname == id }
    end

    def filter(sector : String) : Array(TelemetryNode)
      return @nodes if sector == "ALL" || sector.empty?
      @nodes.select { |n| n.contract.starts_with?(sector) }
    end
  end
end
