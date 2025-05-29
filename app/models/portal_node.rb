class PortalNode
  include ActiveGraph::Node

  property :description, type: String
  property :locked, type: Boolean, default: false
  property :kind, type: String

  has_one :in, :room, origin: :portal_nodes

end
