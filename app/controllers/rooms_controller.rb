class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @adjacent_rooms = @room.portals

    @matrix = [
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 0, 1],
      [1, 1, 1, 1]
    ]

  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "Room successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :description)
  end
end
