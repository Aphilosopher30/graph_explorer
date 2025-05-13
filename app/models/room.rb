class Room
  include ActiveGraph::Node

  property :name, type: String
  property :description, type: String
  property :floor_plan, type: String, default: '{"arrays": [[1, 1, 1], [1, 1, 1], [1, 1, 1]]}'

  has_many :both, :portals, model_class: :Room, rel_class: :Portal

  def passage_ways()
    # @portals = @room.portals.where(to_node: adjacent_room)
    self.query_as(:room).match('(room)-[r]-(n)').pluck('r')
  end
end
