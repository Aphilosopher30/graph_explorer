class ExploreController < ApplicationController

  def enter_room
    @rooms = Room.all

    @portal_node = PortalNode.find(params[:id])

    @matrix = [[1, 1, 1, 1], [1 , 1, 1, 1], [1 , 1, 1, 1], [1 , 1, 1, 1]]
  end

  def create_new_room
    @portal_node = PortalNode.find(params[:id])

    room = Room.new({name: params['name'],  description: params['description'], floor_plan: params['floor_plan'] })

    new_portal = Portal.new(to_node: room, from_node: @portal_node.room,
      kind: @portal_node.kind,
      description: @portal_node.description,
      locked: @portal_node.locked )
    new_portal.save
    @portal_node.destroy


    if room.save
      redirect_to room, notice: "Room was successfully created."
    end
  end

  def connect_existing_room
    @portal_node = PortalNode.find(params[:id])

    @room = Room.find(params[:room_id])

    new_portal = Portal.new(to_node: @room, from_node: @portal_node.room,
      kind: @portal_node.kind,
      description: @portal_node.description,
      locked: @portal_node.locked )
    new_portal.save
    @portal_node.destroy


    redirect_to @room, notice: "Room was successfully linked."
  end
end
