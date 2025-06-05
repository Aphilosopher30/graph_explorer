class ExploreController < ApplicationController

  def enter_room
    @rooms = Room.all

    @portal_node = PortalNode.find(params[:id])

    @matrix = [[1, 1, 1, 1], [1 , 1, 1, 1], [1 , 1, 1, 1], [1 , 1, 1, 1]]
  end

end
