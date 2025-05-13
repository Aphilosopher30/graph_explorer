class Portal
  include ActiveGraph::Relationship

  from_class :Room
  to_class :Room
  type :PORTAL

  property :description, type: String
  property :locked, type: Boolean
  property :kind, type: String

  def connections
    [ self.from_node, self.to_node]
  end

end
