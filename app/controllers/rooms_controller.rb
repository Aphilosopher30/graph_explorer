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
    @all_rooms = Room.all.reject { |r| r == @room }

    @passage_ways = @room.passage_ways

    floor_plan = JSON.parse(@room.floor_plan)
    @matrix = floor_plan["arrays"]
  end

  def update
    @room = Room.find(params[:id])

    # change default to having the portal lead from the room, to a special portal_node.
    unknownRoom = Room.find("b1e07b5b-d339-4b7a-9a54-1081f038063f")
    doorways = params["doorways"]
    if doorways != "" && doorways !=nil
      doorways.keys.each { | key |
        new_portal = Portal.new(to_node: unknownRoom, from_node: @room)
        doorway = doorways[key]

        new_portal.kind = doorway["kind"]
        new_portal.description = doorway["description"]
        new_portal.locked = doorway["locked"]
        new_portal.save
      }
    end

    passages = params["passages"]
    if passages != "" || passages != nil
      passages.keys.each { | key |

        passage = passages[key]
        new_room = Room.find(passage["to_room_id"])

        portal = Portal.find(passage["id"])

        # Use ActiveGraph to create the relationship and return its ID

        # IF IT CHANGES THE STUFF\
        filtered = portal.connections.reject{|x| x == @room }
          if filtered.include?(new_room) == false

          result = ActiveGraph::Base.query("
            MATCH (a)-[r:PORTAL]->(b), (c)
            WHERE id(r) = #{portal.id} AND c.uuid = '#{new_room.uuid}'
            CREATE (a)-[new_rel:PORTAL {
               description: r.description,
               kind: r.kind,
               locked: r.locked
            }]->(c)
            RETURN id(new_rel) AS new_relationship_id
          ")
          test_id = result.first["new_relationship_id"]

          update_portal = Portal.find(test_id)

          portal.destroy

         else
          update_portal = portal
        end

        update_portal.kind = passage["kind"]
        update_portal.description = passage["description"]
        update_portal.locked = passage["locked"]
        update_portal.save
      }
    end

    passage_deleations = params["passages_to_delete"]
    if passage_deleations != nil
      passage_deleations.each { | id | delete_portal = Portal.find(id); delete_portal.destroy }
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

  def destroy
    @room = Room.find(params[:id])

    @room.destroy
    redirect_to rooms_path, notice: 'Room was successfully deleted.'
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :floor_plan)
  end

end
