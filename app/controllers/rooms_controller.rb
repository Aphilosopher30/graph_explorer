class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    # @adjacent_rooms = @room.portals
    @passage_ways = @room.passage_ways

    floor_plan = JSON.parse(@room.floor_plan)
    @matrix = floor_plan["arrays"]
  end

  def edit
    @room = Room.find(params[:id])

    @passage_ways = @room.passage_ways

    floor_plan = JSON.parse(@room.floor_plan)
    @matrix = floor_plan["arrays"]
  end

  def update
    @room = Room.find(params[:id])




    unknownRoom = Room.find("b1e07b5b-d339-4b7a-9a54-1081f038063f")
    doorways = params["doorways"]
    if doorways != ""
      doorways.keys.each { | key |
        new_portal = Portal.new(to_node: unknownRoom, from_node: @room)
        doorway = doorways[key]

        new_portal.kind = doorway["kind"]
        new_portal.description = doorway["description"]
        new_portal.locked = doorway["locked"]
        new_portal.save
      }
    end

    if @room.update(room_params)
      redirect_to room_path(@room), notice: "Room successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @room = Room.new
    @matrix = [[1, 1, 1, 1], [1 , 1, 1, 1], [1 , 1, 1, 1], [1 , 1, 1, 1]]
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room, notice: "Room was successfully created."
    else
      render :new
    end
  end

  private
  def room_params
    params.require(:room).permit(:name, :description, :floor_plan)
  end

  # def portal_params
  #   params.require(:doorways).permit(:kind, :description, :locked)
  # end
end
