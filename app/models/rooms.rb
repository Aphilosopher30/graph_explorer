class Room
  include Neo4j::ActiveNode

  property :name, type: String
  property :size, type: Integer
end
