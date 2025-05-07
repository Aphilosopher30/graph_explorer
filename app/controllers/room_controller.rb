class RoomController < ApplicationController
  def index
    @rooms = Room.all
  end
end
