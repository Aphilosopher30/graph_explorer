class ForceCreatePortalNodeUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :PortalNode, :uuid, force: true
  end

  def down
    drop_constraint :PortalNode, :uuid
  end
end
