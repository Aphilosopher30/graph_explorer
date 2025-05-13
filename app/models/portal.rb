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

    def to_node_from(present_node)
      if self.to_node == present_node
        self.from_node
      elsif self.from_node ==  present_node
        self.to_node
      else
        return "ERROR"
      end

    end

end
