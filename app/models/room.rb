class Room
  include ActiveGraph::Node

  property :name, type: String
  property :description, type: String
  property :floor_plan, type: String, default: '[1, 1, 1], [1, 1, 1], [1, 1, 1]'
  
  has_many :both, :portals, type: :PORTAL, model_class: :Room

end
