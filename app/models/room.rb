class Room
  include ActiveGraph::Node

  property :name, type: String
  property :description, type: String
  property :floor_plan, type: String, default: '{"arrays": [[1, 1, 1], [1, 1, 1], [1, 1, 1]]}'

  has_many :both, :portals, model_class: :Room, rel_class: :Portal
end
