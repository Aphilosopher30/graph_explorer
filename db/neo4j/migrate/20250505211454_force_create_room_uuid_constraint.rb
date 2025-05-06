class ForceCreateRoomUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :Room, :uuid, force: true
  end

  def down
    drop_constraint :Room, :uuid
  end
end
